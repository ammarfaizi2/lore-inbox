Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267563AbUHVQEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbUHVQEV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 12:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267537AbUHVQEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 12:04:21 -0400
Received: from mail4.ewetel.de ([212.6.122.28]:34019 "EHLO mail4.ewetel.de")
	by vger.kernel.org with ESMTP id S267563AbUHVQES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 12:04:18 -0400
Date: Sun, 22 Aug 2004 18:04:13 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: nf <nf2@scheinwelt.at>
cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Nonotify 0.3.2 (A simple dnotify replacement)
In-Reply-To: <1093181664.4542.47.camel@lilota.lamp.priv>
Message-ID: <Pine.LNX.4.58.0408221757100.7831@neptune.local>
References: <2vRn8-1D3-9@gated-at.bofh.it>  <E1ByrTz-00003r-8U@localhost>
 <1093181664.4542.47.camel@lilota.lamp.priv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004, nf wrote:

> But i didn't want to bother people with asking to assign me a
> syscall-number before even knowing if they like my idea. And changing it
> to use a syscall lateron would be no problem at all from the concept of
> nonotify.

Right. It's just something to consider if you aim for inclusion in
the mainline tree later.

> Also - as a kernel newbie - i didn't find any good documentation how to
> add my own syscall into the kernel. I just wanted to get nonotify
> working as an 'optional patch', without changing tons of files.

Adding a syscall should roughly work like this:

- write your sys_foo() function
- add your syscall number to include/asm-i386/unistd.h, don't forget
  to change the "#define NR_syscalls" accordingly
- add ".long sys_foo" to sys_call_table in arch/i386/kernel/entry.S,
  in the right place (i.e. syscall 290 would need to be element 290
  in the list)
- arrange for the object file with sys_foo in it to be linked into
  the kernel

You're right, your going to have to touch a couple of files for
this approach.

> But you could help me if you have a look at my ioctl function. I'm using
> a structure which contains a char* pointer and four timespec fields. Do
> you know if this causes problems with 32/64bit compatibility.

I don't think the timespecs will be a problem. However, the char
pointer will have different sizes and alignment requirements on
32bit and 64bit system. I'm no expert in how that can be handled
in the compat layer, though.

-- 
Ciao,
Pascal
