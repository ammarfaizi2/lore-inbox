Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSH0SAa>; Tue, 27 Aug 2002 14:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316609AbSH0SAa>; Tue, 27 Aug 2002 14:00:30 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:19973 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316601AbSH0SAa>;
	Tue, 27 Aug 2002 14:00:30 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200208271804.g7RI4mc05751@oboe.it.uc3m.es>
Subject: Re: block device/VM question
In-Reply-To: <Pine.LNX.4.44.0208271118000.3234-100000@hawkeye.luckynet.adm> from
 Thunder from the hill at "Aug 27, 2002 11:22:28 am"
To: Thunder from the hill <thunder@lightweight.ods.org>
Date: Tue, 27 Aug 2002 20:04:48 +0200 (MET DST)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Thunder from the hill wrote:"
> > there I can do whatever the sysopen with O_DIRECT does.
> 
> I try to say, see how sys_open() handles O_DIRECT. You should be able to 
> do just the same.

Well, how it handles it is manifestly unclear. It seems to trace down to
the dentry and call dentry_open(), but with a struct vfsmount as
another arg. I don't know what that's for. It got the vfsmount by aother
esoteric lookup, getting a struct nameidata from the filename via
open_namei.

Yecch. I have the inode of the sepecial device file. I don't want to
know the name. I even have a file pointer.

In dentry_open(), we get a struct file f = get_empty_filp(), and then
fill out various of its fields with enormously obscure things.  And for
the O_DIRECT flag we seem to do alloc_kiovec(1, &f->f_iobuf).

I feel that the latter is all I want to do, and the question is to what,
where (I'll clean up on release). Do I do this every time the devices
_open() function is called? Or just once, and what do I do it to? I
should do it to the struct file that gets passed into to the driver
open()? I'll try that. And set the flag.

Peter
