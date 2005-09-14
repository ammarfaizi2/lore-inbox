Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbVINRCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbVINRCL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbVINRCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:02:10 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:18978 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1030286AbVINRCI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:02:08 -0400
Date: Wed, 14 Sep 2005 19:04:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, joern@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permanently fix kernel configuration include mess (was: Missing #include <config.h>)
Message-ID: <20050914170433.GC9096@mars.ravnborg.org>
References: <20050913135622.GA30675@phoenix.infradead.org> <20050913150825.A23643@flint.arm.linux.org.uk> <20050913155012.C23643@flint.arm.linux.org.uk> <20050914013944.5ee4efa7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914013944.5ee4efa7.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
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
Out-of-tree stuff are broken if they do not use kbuild.
And for 2.6 many out-of-tree modules has started doing this - especially
when they realised how easy it was (modulos backward compatibility
stuff).

	Sam
