Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWJ0UYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWJ0UYM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 16:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWJ0UYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 16:24:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60605 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751239AbWJ0UYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 16:24:11 -0400
Date: Fri, 27 Oct 2006 13:17:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Stephen Hemminger <shemminger@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: vmlinux.lds: consolidate initcall sections
Message-Id: <20061027131730.bde49aed.akpm@osdl.org>
In-Reply-To: <20061027194412.GN5591@parisc-linux.org>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	<20061026224541.GQ27968@stusta.de>
	<20061027010252.GV27968@stusta.de>
	<20061027012058.GH5591@parisc-linux.org>
	<20061026182838.ac2c7e20.akpm@osdl.org>
	<20061026191131.003f141d@localhost.localdomain>
	<20061027170748.GA9020@kroah.com>
	<20061027172219.GC30416@elf.ucw.cz>
	<20061027113908.4a82c28a.akpm@osdl.org>
	<20061027114144.f8a5addc.akpm@osdl.org>
	<20061027194412.GN5591@parisc-linux.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 13:44:13 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> On Fri, Oct 27, 2006 at 11:41:44AM -0700, Andrew Morton wrote:
> > Add a vmlinux.lds.h helper macro for defining the eight-level initcall table,
> > teach all the architectures to use it.
> 
> > @@ -48,13 +48,7 @@ SECTIONS
> >    . = ALIGN(8);
> >    __initcall_start = .;
> >    .initcall.init : {
> > -	*(.initcall1.init) 
> > -	*(.initcall2.init) 
> > -	*(.initcall3.init) 
> > -	*(.initcall4.init) 
> > -	*(.initcall5.init) 
> > -	*(.initcall6.init) 
> > -	*(.initcall7.init)
> > +	INITCALLS
> >    }
> >    __initcall_end = .;
> 
> Why not make the INITCALLS macro include more:
> 
> +#define INITCALLS						\
> +	__initcall_start = .;					\
> +	.initcall.init : {					\
> +		*(.initcall1.init)				\
> +		*(.initcall2.init)				\
> +		*(.initcall3.init)				\
> +		*(.initcall4.init)				\
> +		*(.initcall5.init)				\
> +		*(.initcall6.init)				\
> +		*(.initcall7.init)				\
> +	}							\
> +	__initcall_end = .;

Would be nice, but i386 does:

  __initcall_start = .;
  .initcall.init : AT(ADDR(.initcall.init) - 0xC0000000) {
 *(.initcall1.init)
 *(.initcall2.init)
 ...

> Also, you might want to check the spaces at the front of your INITCALLS
> macro; I see two spaces before the first tab.

thanks.
