Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUAXXxq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 18:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbUAXXxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 18:53:46 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:25740 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263205AbUAXXxo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 18:53:44 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 24 Jan 2004 15:53:44 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Andrew Morton <akpm@osdl.org>
cc: Felix von Leitner <felix-kernel@fefe.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Request: I/O request recording
In-Reply-To: <20040124153551.24e74f63.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0401241550350.14163-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jan 2004, Andrew Morton wrote:

> Felix von Leitner <felix-kernel@fefe.de> wrote:
> >
> > I would like to have a user space program that I could run while I cold
> > start KDE.  The program would then record which I/O pages were read in
> > which order.  The output of that program could then be used to pre-cache
> > all those pages, but in an order that reduces disk head movement.
> > Demand Loading unfortunately produces lots of random page I/O scattered
> > all over the disk.
> 
> I wrote a similar thing in September of 2001.  What you do is:
> 
> - Reboot the system, wait until everything is steady-state (eg: X has
>   started, applications are loaded).
> 
> - Load a kernel module which dumps the current contents of the pagecache
>   (filename/offset-into-file) into a file.
> 
>   (The kernel module writes to modprobe's stdout, so you just do
> 
> 	modprobe fboot-dump > /tmp/fboot-dump.out
> 
>    I'm very proud of this.)
> 
> - Post-process the resulting output into a database which is used on the
>   next reboot.
> 
> - reboot
> 
> - This time a userspace application cuts in real early and reads the
>   database and preloads all the pagecache using "optimal" I/O patterns so
>   that everything which you will need in the subsequent boot is already in
>   memory.
> 
> 
> So it's all an attempt to optimise the boot-time I/O patterns.  It was
> pretty much a waste of time, gaining only 10% or so, from memory.  You
> could get just as much or more speedup from simply launching all the
> initscripts in parallel, although this did tend to break stuff.
> 
> Anyway, the code's ancient but might provide some ideas:
> 
> 	http://www.zip.com.au/~akpm/linux/fboot.tar.gz

Warning. I don't know if they do have a patent for this, but MS does this 
starting from XP (look inside %WINDIR%\PreFetch). It is both boot and app 
based.




- Davide


