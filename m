Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbVAKJY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbVAKJY7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 04:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVAKJY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 04:24:59 -0500
Received: from smtp.hickorytech.net ([216.114.192.16]:61650 "EHLO
	avalanche.hickorytech.net") by vger.kernel.org with ESMTP
	id S262634AbVAKJYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 04:24:25 -0500
Message-ID: <41E39B46.8030904@mnsu.edu>
Date: Tue, 11 Jan 2005 03:24:22 -0600
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Cc: Roland Rosenfeld <rrosenfeld@netcologne.de>
Subject: Bad things happening to journaled filesystem machines; Was: Oops
 in kjournald
References: <20050111090546.GB25756@sys-241.netcologne.de>
In-Reply-To: <20050111090546.GB25756@sys-241.netcologne.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had 4 machines do the similiar things.  It happens during backups 
or during updatedb.  This has happened on 2.6.9, 2.6.10, 2.6.10-ac7, and 
2.6.10-ac8.  I've seen several similiar reports with journaled file 
systems.  I use XFS exclusively; but have seen reports on XFS and EXT3.  
I would report something more useful but what I'm usually left with is 
XFS unmounted and nothing useful on the screen.  This has been on Xeon, 
Pentium-3 and Athlon systems. ...wish I could report more but perhaps it 
will add /part/ of a data point.

-- 
jeffrey hundstad


Roland Rosenfeld wrote:

>In the last week I got the following Oops five times on two machines,
>when they are under very heavy load  (mailserver based on Debian sarge
>with postfix 2.1.4) when the load is >4 for some hours.
>
>---------------------- schnipp --------------------------------
>Unable to handle kernel NULL pointer dereference at virtual address 0000000c
> printing eip:
>c01a65a5
>*pde = 00000000
>Oops: 0002 [#1]
>PREEMTP SMP
>Modules linked in: e1000 tg3 bonding rtc unix
>CPU:    0
>EIP:    0060:[<c01a65a5>]    Not tainted VLI
>EFLAGS: 00010282   (2.6.10-686-nc-smp-1)
>EIP is at jounral_commit_transaction+0x315/0x12f0
>eax: f157117c   ebx: 00000000   ecx: 00000000   edx: f7cffb80
>es: 007b   es: 007b   ss: 0068
>Process kjournald (pid: 171, threadinfo=f6f7e000 task=f6e92520)
>Stack: e2efd5cc e2efd5cc 00000008 000011da 00000000 f6e97ac0 f6f7e000 f6f7e000
>       f6ef6bb8 f6e97a14 00000000 00000000 00000000 00000000 00000000 f0fa9dac
>       e8a39ecc 000011da 00000000 f6e92520 c012d580 f6f7fe44 f6f7fe44 00000000
>Call Trace:
> [<c012d580>] autoremove_wake_function+0x0/0x60
> [<c012d580>] autoremove_wake_function+0x0/0x60
> [<c01a9af5>] kjounald+0xe5/0x240
> [<c011b837>] do_exit+0x2d7/0x480
> [<c012d580>] autoremove_wake_function+0x0/0x60
> [<c012d580>] autoremove_wake_function+0x0/0x60
> [<c0102572>] ret_from_fork+0x6/0x14
> [<c01a99f0>] commit_timeout+0x0/0x10
> [<c01a9a10>] kjournald+0x0/0x240
> [<c01007f5>] kernel_thread_helper+0x5/0x10
>Code: 00 8b 45 20 85 c0 75 be 8b 44 24 38 85 c0 0f 85 16 0d 00 00 8b 45 18 85 c0 0f 84 83 00 00 00 be 00 e0 ff ff 21 e6 8b 78 20 8b 1f <f0> ff 43 0c 8b 03 a8 04 0f 85 b3 0c 00 00 89 5c 24 04 8b 94 24
> <6>note: kjournald[171] exited with preempt_count 1
>---------------------- schnipp --------------------------------
>
>I run a 2.6.10 kernel (with aacraid 1.1.5 2372 driver from Adaptec,
>everything else vanilla) on Dual Xeon machines. The kernel has ext3fs
>and XFS compiled in but currently all filesystems are ext3.
>
>In the logs I don't see anything, because the machines freeze with the
>above message (I retyped the messages from the screen, so there may be
>some typos, if necessary I have a screenshot here to correct some
>misspellings).
>
>What can I do to fix this problem?  Using google I didn't find a hint
>for further search, but my kernel knowledge is very limited :-|
>
>Tschoeeee
>
>        Roland
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

