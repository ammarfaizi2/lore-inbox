Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSH0Q2q>; Tue, 27 Aug 2002 12:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316519AbSH0Q2q>; Tue, 27 Aug 2002 12:28:46 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:32525 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316499AbSH0Q2p>;
	Tue, 27 Aug 2002 12:28:45 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200208271632.g7RGWsm29662@oboe.it.uc3m.es>
Subject: Re: block device/VM question
In-Reply-To: <Pine.LNX.4.44.0208271021020.3234-100000@hawkeye.luckynet.adm> from
 Thunder from the hill at "Aug 27, 2002 10:24:40 am"
To: Thunder from the hill <thunder@lightweight.ods.org>
Date: Tue, 27 Aug 2002 18:32:54 +0200 (MET DST)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Thunder from the hill wrote:"
> On Tue, 27 Aug 2002, Peter T. Breuer wrote:
> > Yes, I've noticed this in the 2.5.31 kernel. This is something
> > to be done on open by the overlying fs or userspace utility, or
> > should I set the flag on the inode->filp (or whatever) myself in
> > the drivers open function? And do I need to define
> > inode->mapping->a_ops->direct_IO()? (sorry - but I haven't had time to
> > experiment yet today!).
> 
> Why so rough?

Rough? You mean "approximate"? I was working from my vague mamory of
what I read in the code on the train this morning.

> > It looks like the 2.5 kernel has this pathway, but what about the 2.4
> > kernel? Nothing.
> 
> The manpage claims:
> 
>     O_DIRECT
> 	This flag is supported on a number of Unix-like systems;
> 	support was added under Linux in kernel version 2.4.10.

My manpage for open(2) claims no such thing. It doesn't mention
O_DIRECT. Maybe your libc6 is newer.

In any case, it doesn't make it clear to me if I have to set the flag
in the driver. Well, anyway, I'll set it.

> Also:
> 
> 	A semantically similar interface for block devices is 
> 	described in raw(8).

That's nothing like, since it's a character device that they were
describing. But yes, reading drivers/char/raw.c led me to see the
pathway via direct_IO() in 2.5.31, but in the 2.4.19 kernel the path is
obscure. In 2.5.31 it's clear that mm/filemap.c does pay attention to the
flag, and YES, you are right, in 2.4.19, generic_file_read() does
look at the flag. However, I have not much idea where that filp
comes from or what it represents.  Oh, well, thanks.I suppose
you won't give me a recipe saying "do this and your device won't be
cached", but I'll follow the lead.

Thanks again.


Peter

