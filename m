Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264763AbUFYRYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbUFYRYn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 13:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266807AbUFYRYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 13:24:43 -0400
Received: from chaos.analogic.com ([204.178.40.224]:41864 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264763AbUFYRYk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 13:24:40 -0400
Date: Fri, 25 Jun 2004 13:24:23 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Pavel Machek <pavel@ucw.cz>
cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: swsusp.S: meaningfull assembly labels
In-Reply-To: <20040625161050.GB30073@elf.ucw.cz>
Message-ID: <Pine.LNX.4.53.0406251317060.28917@chaos>
References: <20040625115936.GA2849@elf.ucw.cz> <Pine.LNX.4.53.0406250827250.28070@chaos>
 <20040625161050.GB30073@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2004, Pavel Machek wrote:

> Hi!
>
> > > This introduces meaningfull labels instead of .L1234, meaning code is
> > > readable, kills alignment where unneccessary, and kills TLB flush that
> > > was only pure paranoia (and slows it down a lot on emulated
> > > systems). Please apply,
> > >
> > > 								Pavel
> > >
> > > --- linux-cvs//arch/i386/power/swsusp.S	2004-05-25 17:41:18.000000000 +0200
> > > +++ linux/arch/i386/power/swsusp.S	2004-06-24 14:39:01.000000000 +0200
> > > @@ -18,7 +18,7 @@
> > >  ENTRY(do_magic)
> > >  	pushl %ebx
> > >  	cmpl $0,8(%esp)
> > > -	jne .L1450
> > > +	jne resume
> > >  	call do_magic_suspend_1
> > >  	call save_processor_state
> > >
> ...
> > NO! You just made those labels public! The LOCAL symbols need to
> > begin with ".L".  Now, if you have a 'copy_loop' in another module,
> > linked with this, anywhere in the kernel, they will share the
> > same address -- not what you expected, I'm sure! The assembler
> > has some strange rules you need to understand. Use `nm` and you
> > will find that your new labels are in the object file!
>
> Are you sure? I thought theare not visible from other moduless unless
> "ENTRY()" is used.  See for example entry.S.
> 							Pavel

Well if you find a way to make those symbols disappear from the
object files without using ".L", please let me know. I spent
some considerable time beautifying multiple assembly-language
files on a recent project, only to find that it would fail to
link because of the "multiple symbol definition" errors. I
had to change everything back.

You can make labels like ".Lresume:" remain visible only in
the file. They don't need to be numbers. It may even be possible
to use labels like ".L_resume:", I haven't tried. Basically, if
they show up using `nm`, they can (read will) give you problems.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


