Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965215AbVINOCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbVINOCv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 10:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbVINOCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 10:02:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46269 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965215AbVINOCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 10:02:50 -0400
Date: Wed, 14 Sep 2005 15:02:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, joern@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permanently fix kernel configuration include mess (was: Missing #include <config.h>)
Message-ID: <20050914140245.GA1530@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>, joern@infradead.org,
	linux-kernel@vger.kernel.org
References: <20050913135622.GA30675@phoenix.infradead.org> <20050913150825.A23643@flint.arm.linux.org.uk> <20050913155012.C23643@flint.arm.linux.org.uk> <20050914013944.5ee4efa7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914013944.5ee4efa7.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
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

The only supported way to compile out of tree drivers for 2.6.x is
to use the kbuild framework, which will automatically add it.

