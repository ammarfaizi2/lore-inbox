Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWF0Lsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWF0Lsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWF0Lsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:48:46 -0400
Received: from tornado.reub.net ([202.89.145.182]:14520 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932341AbWF0Lsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:48:45 -0400
Message-ID: <44A11B20.5050000@reub.net>
Date: Tue, 27 Jun 2006 23:48:48 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060623)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm3
References: <20060627015211.ce480da6.akpm@osdl.org>
In-Reply-To: <20060627015211.ce480da6.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/06/2006 8:52 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm3/
> 
> 
> - Added the x86 Geode development tree to the -mm lineup, as git-geode.patch
>   (Jordan Crouse).
> 
> - The locking validator patches are back, in a reworked series.

Still seeing the same breakage as I posted about here in -mm2:

http://www.ussg.iu.edu/hypermail/linux/kernel/0606.3/0195.html

I've since noticed that mail delivery is held up by the deliver process. 
'deliver' is a component of the dovecot mail system (http://www.dovecot.org/) 
which does delivery of mails to a user's Maildir and in the process recreates an 
index.

[root@tornado ~]# nice top
top - 23:05:13 up 47 min,  4 users,  load average: 6.48, 4.80, 4.10
Tasks: 170 total,   5 running, 165 sleeping,   0 stopped,   0 zombie
Cpu(s)%:  0.2 us, 98.9 sy,  0.0 ni,  0.6 id,  0.2 wa,  0.2 hi,  0.0 si,  0.0 st
Mem:   1016764k total,   847184k used,   169580k free,    56840k buffers
Swap:   497936k total,        0k used,   497936k free,   267064k cached

   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  2231 reuben    25   0  7984 1392 1136 R   55  0.1  23:20.16 deliver
  2591 reuben    25   0  7988 1392 1136 R   53  0.1  22:41.52 deliver
  2232 reuben    25   0  7988 1392 1136 R   50  0.1  23:23.78 deliver
  2586 reuben    25   0  7984 1392 1136 R   49  0.1  22:28.72 deliver


[root@tornado ~]# strace -p 2232
Process 2232 attached - interrupt to quit

I can't kill these processes with a KILL signal, nor can I strace them.

Revert to -mm1 or any previous kernel release, and it all works fine.  That 
leads me to believe this is probably not a userspace issue.

What patches which could have possibly caused this?

Reuben
