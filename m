Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVGVGZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVGVGZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 02:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVGVGZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 02:25:26 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:60125 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262047AbVGVGZY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 02:25:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lVssliCMM01PDlTsvm8qtFWycSRpupPC4PruAO/zS+iwBGERm8qhJ2VseGasYLl3O6ioQ879UN3eRgMyFg1H80foH+vCag8dA+T1KFCBKCE4+8GRgqkEDVj6tUh846SbIaoK17dKt9nBmcDgP2YBU3mLca6KG+t2zkWyqLY7/4k=
Message-ID: <3faf0568050721232547aa2482@mail.gmail.com>
Date: Fri, 22 Jul 2005 11:55:23 +0530
From: vamsi krishna <vamsi.krishnak@gmail.com>
Reply-To: vamsi krishna <vamsi.krishnak@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Whats in this vaddr segment 0xffffe000-0xfffff000 ---p ?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

Sorry to interrupt you.

I have been facing a wierd problem on same kernel version
(2.6.5-7.97.smp) but running on different machines 32-bit and 64-bit
(which can run 32-bit also).

I found that every process running in this kernel version has a
virtual address mapping in /proc/<pid>/maps file as follows
<-------------------------------------------------------------------------------------------------->
ffffe000-ffff000 ---p 00000000 00:00 0
<-------------------------------------------------------------------------------------------------->

You can find this vaddr mapping at end of maps file.

on a 64-bit(uname --all == 'Linux host 2.6.5-7.97.smp #1 <time stamp>
x86_64 x86_64 x86_64 GNU/Linux) machine which is running the same
kernel, I try to write the contents of the virtual address on to file
with
(r = write(fd,0xffffe000,4096) ). The write on this machine is
successful. But if I try to write the same segment on 32-bit machine
(uname --all == Linux host 2.6.5-7.97-smp #1 <timestamp> i686 i686
i386 GNU/Linux).

The write on this 32-bit machine fails with EFAULT(14), but if memcpy
to a buffer from this virtual address seems to work fine i.e if I do
'memcpy(buf1,0xffffe000,4096)' it write perfectly the contents of this
virtual address segment into the buf1.

I had a hard time googling about this I could'nt find any information
on why this happens. May be some mm hackers may share some of their
thoughts.

Really appreciate your inputs on this.

Sincerely,
Vamsi kundeti 

PS: BTW I'am running suse distribution and will glibc will have any
effect on write behaviour ? (I though that since write is a syscall
the issue might be with the kernel the thus skipping the glibc
details)
