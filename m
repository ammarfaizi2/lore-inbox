Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWBIQ6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWBIQ6i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 11:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWBIQ6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 11:58:38 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:39909 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932366AbWBIQ6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 11:58:37 -0500
Date: Thu, 9 Feb 2006 17:58:34 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: pid_t range question
In-Reply-To: <m1pslystkz.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.61.0602091751220.30108@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0602071122520.327@chaos.analogic.com>
 <m1pslystkz.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Linux, type pid_t is defined as an int if you look
>> through all the intermediate definitions such as S32_T,
>> etc. However, it wraps at 32767, the next value being 300.

There is also an aesthetical reason. If pids were allowed to exceed, say, 
ten million, you would need a quite wide field in `ps` for the process 
number which is on "normal desktop user" systems just require 5 or 6 
decimal places. Well, what I mean, just look at this sample ps output:

17:59 shanghai:../fs/proc # ps
        PID TTY          TIME CMD
          1 -        00:00:00 init [3]
 4215914607 tty2     00:00:00 bash
 4215914653 tty2     00:00:00 ps

mingw/msys and cygwin already have this "cosmetic problem" since windows 
"pids" are usually above one million.

>> I know the
>> code "reserves" the first 300 pids.

I cannot confirm that. When I start in "-b" mode and 'use' up all pids by 
repeatedly executing /bin/noop, I someday get pids as low as 10 
again, defined by how many kernel threads there are active before /bin/bash 
started.

>I know for certain that proc assumes it can fit pid in
>the upper bits of an ino_t taking the low 16bits for itself
>so that may the entire reason for the limit.
>
inode number in /proc/XXX/fd creation currently is, IIRC
  ino = (pid << 16) | fd
which limits both pid to 16 bits and the fdtable to 16 bits. See 
fs/proc/inode-alloc.txt. At best, procfs should start using 64bit inode 
numbers.


Jan Engelhardt
-- 
