Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTHYSFL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 14:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTHYSFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 14:05:10 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:37071 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S262104AbTHYSFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 14:05:03 -0400
Date: Mon, 25 Aug 2003 11:05:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix the -test3 input config damages
Message-ID: <20030825180501.GD1075@ip68-0-152-218.tc.ph.cox.net>
References: <20030822204903.GA847@ip68-0-152-218.tc.ph.cox.net> <Pine.GSO.4.21.0308251810010.15307-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0308251810010.15307-100000@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 06:13:32PM +0200, Geert Uytterhoeven wrote:
> On Fri, 22 Aug 2003, Tom Rini wrote:
> > --- 1.18/drivers/video/console/Kconfig	Wed Jul 16 10:39:32 2003
> > +++ edited/drivers/video/console/Kconfig	Fri Aug 22 13:27:21 2003
> > @@ -5,7 +5,7 @@
> >  menu "Console display driver support"
> >  
> >  config VGA_CONSOLE
> > -	bool "VGA text console" if EMBEDDED || !X86
> > +	bool "VGA text console" if STANDARD && X86
> >  	depends on !ARCH_ACORN && !ARCH_EBSA110 || !4xx && !8xx
> >  	default y
> >  	help
> 
> Ugh, this makes VGA_CONSOLE default to yes if X86 is not set, right? Don't you
> want
> 
>     bool "VGA text console" if !STANDARD || X86
> 
> ?
> 
> Or do I need an update course on Kconfig syntax?

No, I think that's a logic error on my part.  What I intended was
default to Y on (STANDARD && X86), otherwise ask.  So it should have
been:
bool "VGA text console" if !(STANDARD && X86)

-- 
Tom Rini
http://gate.crashing.org/~trini/
