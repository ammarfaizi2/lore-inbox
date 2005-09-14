Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbVINIsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbVINIsm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 04:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbVINIsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 04:48:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64528 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965087AbVINIsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 04:48:42 -0400
Date: Wed, 14 Sep 2005 09:48:36 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: joern@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permanently fix kernel configuration include mess (was: Missing #include <config.h>)
Message-ID: <20050914094835.A30672@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, joern@infradead.org,
	linux-kernel@vger.kernel.org
References: <20050913135622.GA30675@phoenix.infradead.org> <20050913150825.A23643@flint.arm.linux.org.uk> <20050913155012.C23643@flint.arm.linux.org.uk> <20050914013944.5ee4efa7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050914013944.5ee4efa7.akpm@osdl.org>; from akpm@osdl.org on Wed, Sep 14, 2005 at 01:39:44AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 01:39:44AM -0700, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> >  LINUXINCLUDE    := -Iinclude \
> >  -                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
> >  +                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
> >  +		   -imacros include/linux/autoconf.h
> 
> This means that over time the kernel will fail to compile correctly without
> `-imacros include/linux/autoconf.h'.
> 
> That's OK for the kernel, but not for out-of-tree stuff.  Those drivers
> will need to add the new gcc commandline option too.
> 
> Not that I'm saying it's a terrible thing.  It's just a thing.

Well I don't really understand all the kbuild complexities, so I just
did a "what works for me in the setups I have" patch.  Maybe someone
who properly understands the kbuild complexity should have a look.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
