Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131604AbRCXHoc>; Sat, 24 Mar 2001 02:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131606AbRCXHoX>; Sat, 24 Mar 2001 02:44:23 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:15508 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131604AbRCXHoE>; Sat, 24 Mar 2001 02:44:04 -0500
Message-ID: <3ABC5143.167A649E@redhat.com>
Date: Sat, 24 Mar 2001 02:48:19 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Christian Bodmer <cbinsec01@freesurf.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <200103231508.f2NF83xY001147@pincoya.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> "Christian Bodmer" <cbinsec01@freesurf.ch> said:
> 
> > I can't say I understand the whole MM system, however the random killing
> > of processes seems like a rather unfortunate solution to the problem. If
> > someone has a spare minute, maybe they could explain to me why running
> > out of free memory in kswapd results in a deadlock situation.
> 
> OOM is not "normal operations", it is a machine under very extreme stress,
> and should *never* happen. To complicate (or even worse, slow down or
> otherwise use up resources like memory) normal operations for "better
> handling of OOM" is total nonsense.

Puh-Leeze.   Let's inject some reality into this conversation:

[dledford@aic-cvs dledford]$ more kill-list 
Mar 10 22:02:34 monster kernel: Out of Memory: Killed process 475 (identd).
Mar 10 22:03:25 monster kernel: Out of Memory: Killed process 660 (xfs).
Mar 10 23:02:43 monster kernel: Out of Memory: Killed process 415 (rpc.statd).
Mar 11 01:20:31 monster kernel: Out of Memory: Killed process 397 (portmap).
Mar 11 01:37:09 monster kernel: Out of Memory: Killed process 474 (identd).
Mar 11 02:56:54 monster kernel: Out of Memory: Killed process 659 (xfs).
Mar 11 03:01:43 monster kernel: Out of Memory: Killed process 414 (rpc.statd).
Mar 11 03:09:30 monster kernel: Out of Memory: Killed process 396 (portmap).
Mar 11 03:37:30 monster kernel: Out of Memory: Killed process 538 (lpd).
Mar 11 03:49:46 monster kernel: Out of Memory: Killed process 493 (atd).
Mar 11 04:02:15 monster kernel: Out of Memory: Killed process 517 (sshd).
Mar 11 04:05:05 monster kernel: Out of Memory: Killed process 724 (bash).
Mar 11 05:02:40 monster kernel: Out of Memory: Killed process 717 (login).
Mar 11 05:54:04 monster kernel: Out of Memory: Killed process 718 (login).
Mar 11 13:34:25 monster kernel: Out of Memory: Killed process 20357 (bash).
Mar 11 16:04:12 monster kernel: Out of Memory: Killed process 5879 (diff).
Mar 11 16:52:41 monster kernel: Out of Memory: Killed process 7948 (tar).
Mar 11 17:37:09 monster kernel: Out of Memory: Killed process 10072 (tar).
Mar 11 17:42:26 monster kernel: Out of Memory: Killed process 10358 (tar).
Mar 11 18:24:30 monster kernel: Out of Memory: Killed process 11300
(run-parts).
Mar 11 19:23:56 monster kernel: Out of Memory: Killed process 11301
(set-time).
Mar 11 20:28:54 monster kernel: Out of Memory: Killed process 18165 (tar).
Mar 11 20:28:55 monster kernel: Out of Memory: Killed process 18167 (gzip).
Mar 11 21:30:51 monster kernel: Out of Memory: Killed process 21205 (tar).
Mar 11 21:33:09 monster kernel: Out of Memory: Killed process 11303 (rdate).
Mar 11 21:50:36 monster kernel: Out of Memory: Killed process 22195 (tar).
Mar 11 22:07:57 monster kernel: Out of Memory: Killed process 23049 (tar).
Mar 11 22:10:01 monster kernel: Out of Memory: Killed process 22987 (diff).
Mar 11 22:12:28 monster kernel: Out of Memory: Killed process 23233 (diff).
Mar 12 00:25:38 monster kernel: Out of Memory: Killed process 29692 (diff).
Mar 12 00:35:34 monster kernel: Out of Memory: Killed process 30229 (tar).
Mar 12 00:57:42 monster kernel: Out of Memory: Killed process 30796 (diff).
Mar 12 01:49:33 monster kernel: Out of Memory: Killed process 1153 (diff).
Mar 12 02:41:31 monster kernel: Out of Memory: Killed process 3488 (tar).
Mar 12 03:06:00 monster kernel: Out of Memory: Killed process 4257 (diff).
Mar 12 04:55:27 monster kernel: Out of Memory: Killed process 8845 (diff).
Mar 12 05:20:07 monster kernel: Out of Memory: Killed process 9712 (sh).
Mar 12 05:50:47 monster kernel: Out of Memory: Killed process 10475 (diff).
Mar 12 05:51:46 monster kernel: Out of Memory: Killed process 10838 (tar).
Mar 12 05:59:07 monster kernel: Out of Memory: Killed process 11162 (tar).
Mar 12 07:45:19 monster kernel: Out of Memory: Killed process 15489 (diff).
Mar 12 08:08:01 monster kernel: Out of Memory: Killed process 16340 (diff).
Mar 12 09:19:18 monster kernel: Out of Memory: Killed process 20182 (diff).
Mar 12 09:29:41 monster kernel: Out of Memory: Killed process 20237 (diff).
Mar 12 11:17:54 monster kernel: Out of Memory: Killed process 25611 (diff).
Mar 12 11:20:05 monster kernel: Out of Memory: Killed process 26133 (diff).
Mar 12 12:34:51 monster kernel: Out of Memory: Killed process 29826 (tar).
Mar 12 13:24:21 monster kernel: Out of Memory: Killed process 32281 (tar).
Mar 12 13:44:20 monster kernel: Out of Memory: Killed process 819 (tar).
Mar 12 13:49:37 monster kernel: Out of Memory: Killed process 1108 (tar).
Mar 12 14:03:46 monster kernel: Out of Memory: Killed process 1304 (diff).
Mar 12 14:26:29 monster kernel: Out of Memory: Killed process 2933 (tar).
Mar 12 14:29:08 monster kernel: Out of Memory: Killed process 3035 (diff).
Mar 12 14:45:53 monster kernel: Out of Memory: Killed process 3828 (diff).
Mar 12 15:06:05 monster kernel: Out of Memory: Killed process 4832 (tar).
Mar 12 16:03:42 monster kernel: Out of Memory: Killed process 7552 (tar).
Mar 12 17:10:35 monster kernel: Out of Memory: Killed process 10554 (diff).
Mar 12 17:27:39 monster kernel: Out of Memory: Killed process 11285 (diff).
Mar 12 17:52:07 monster kernel: Out of Memory: Killed process 12135 (diff).
Mar 12 18:29:39 monster kernel: Out of Memory: Killed process 14483 (tar).
Mar 12 19:58:20 monster kernel: Out of Memory: Killed process 18489 (diff).
Mar 12 20:11:46 monster kernel: Out of Memory: Killed process 19362 (tar).
Mar 12 20:31:07 monster kernel: Out of Memory: Killed process 20146 (tar).
Mar 12 21:20:00 monster kernel: Out of Memory: Killed process 22132 (diff).
Mar 12 21:37:42 monster kernel: Out of Memory: Killed process 23400 (tar).
Mar 12 22:24:48 monster kernel: Out of Memory: Killed process 25488 (diff).
Mar 12 22:44:35 monster kernel: Out of Memory: Killed process 26597 (tar).
Mar 12 23:49:01 monster kernel: Out of Memory: Killed process 29112 (diff).
Mar 12 23:51:34 monster kernel: Out of Memory: Killed process 29574 (tar).
Mar 13 00:50:36 monster kernel: Out of Memory: Killed process 32244 (diff).
Mar 13 01:05:21 monster kernel: Out of Memory: Killed process 513 (diff).
Mar 13 02:34:52 monster kernel: Out of Memory: Killed process 4948 (bash).
Mar 13 03:06:48 monster kernel: Out of Memory: Killed process 6511 (tar).
Mar 13 04:54:37 monster kernel: Out of Memory: Killed process 11753 (tar).
Mar 13 05:02:02 monster kernel: Out of Memory: Killed process 12137 (tar).
Mar 13 05:09:32 monster kernel: Out of Memory: Killed process 12521 (tar).
Mar 13 05:27:05 monster kernel: Out of Memory: Killed process 13383 (tar).
Mar 13 05:29:19 monster kernel: Out of Memory: Killed process 13490 (tar).
Mar 13 06:06:27 monster kernel: Out of Memory: Killed process 15063 (diff).
Mar 13 06:18:50 monster kernel: Out of Memory: Killed process 15704 (diff).
Mar 13 06:48:27 monster kernel: Out of Memory: Killed process 16703 (diff).
Mar 13 08:07:19 monster kernel: Out of Memory: Killed process 20995 (tar).
Mar 13 08:32:07 monster kernel: Out of Memory: Killed process 21933 (diff).
Mar 13 10:19:18 monster kernel: Out of Memory: Killed process 26764 (diff).
Mar 13 13:21:41 monster kernel: Out of Memory: Killed process 3452 (tar).
Mar 13 14:28:41 monster kernel: Out of Memory: Killed process 6654 (diff).
Mar 13 15:33:14 monster kernel: Out of Memory: Killed process 9434 (diff).
Mar 13 15:46:12 monster kernel: Out of Memory: Killed process 10469 (tar).
Mar 13 16:07:51 monster kernel: Out of Memory: Killed process 11518 (diff).
Mar 13 16:17:53 monster kernel: Out of Memory: Killed process 11588 (diff).
Mar 13 17:20:05 monster kernel: Out of Memory: Killed process 15139 (crond).
Mar 13 18:27:08 monster kernel: Out of Memory: Killed process 17909 (diff).
Mar 13 19:12:00 monster kernel: Out of Memory: Killed process 20059 (diff).
Mar 13 19:12:03 monster kernel: Out of Memory: Killed process 20278 (diff).
Mar 13 20:11:27 monster kernel: Out of Memory: Killed process 23113 (tar).
Mar 13 21:03:20 monster kernel: Out of Memory: Killed process 25638 (tar).
Mar 13 21:49:55 monster kernel: Out of Memory: Killed process 27811 (diff).
Mar 13 21:57:22 monster kernel: Out of Memory: Killed process 28037 (diff).
Mar 13 21:57:57 monster kernel: Out of Memory: Killed process 28383 (tar).
Mar 13 22:05:23 monster kernel: Out of Memory: Killed process 28759 (tar).
Mar 13 23:24:26 monster kernel: Out of Memory: Killed process 32225 (diff).
Mar 14 01:13:23 monster kernel: Out of Memory: Killed process 5235 (diff).
Mar 14 01:20:44 monster kernel: Out of Memory: Killed process 5525 (tar).
Mar 14 01:38:26 monster kernel: Out of Memory: Killed process 6326 (tar).
Mar 14 01:46:03 monster kernel: Out of Memory: Killed process 6713 (tar).
Mar 14 02:03:31 monster kernel: Out of Memory: Killed process 7527 (tar).
Mar 14 04:23:05 monster kernel: Out of Memory: Killed process 11806
(run-parts).
Mar 14 05:17:32 monster kernel: Out of Memory: Killed process 15152 (tar).
Mar 14 05:35:00 monster kernel: Out of Memory: Killed process 15995 (tar).
Mar 14 06:17:07 monster kernel: Out of Memory: Killed process 17282 (diff).
Mar 14 06:17:30 monster kernel: Out of Memory: Killed process 17439 (diff).
Mar 14 08:13:15 monster kernel: Out of Memory: Killed process 22491 (diff).
Mar 14 09:15:08 monster kernel: Out of Memory: Killed process 25782 (tar).
Mar 14 09:49:48 monster kernel: Out of Memory: Killed process 27088 (diff).
Mar 14 10:00:16 monster kernel: Out of Memory: Killed process 28020 (tar).
Mar 14 10:35:05 monster kernel: Out of Memory: Killed process 29703 (tar).
Mar 14 10:47:14 monster kernel: Out of Memory: Killed process 30142 (diff).
Mar 14 12:14:40 monster kernel: Out of Memory: Killed process 2126 (tar).
Mar 14 12:21:57 monster kernel: Out of Memory: Killed process 2135 (diff).
Mar 14 12:39:08 monster kernel: Out of Memory: Killed process 3201 (diff).
Mar 14 13:18:32 monster kernel: Out of Memory: Killed process 5259 (diff).
Mar 14 13:28:50 monster kernel: Out of Memory: Killed process 5385 (diff).
Mar 14 13:55:50 monster kernel: Out of Memory: Killed process 7159 (tar).
Mar 14 14:40:13 monster kernel: Out of Memory: Killed process 8946 (diff).
Mar 14 14:52:21 monster kernel: Out of Memory: Killed process 9932 (diff).
Mar 14 15:02:52 monster kernel: Out of Memory: Killed process 10494 (tar).
Mar 14 15:37:01 monster kernel: Out of Memory: Killed process 11776 (diff).
Mar 14 15:39:53 monster kernel: Out of Memory: Killed process 12268 (tar).
Mar 14 15:46:53 monster kernel: Out of Memory: Killed process 12228 (diff).
Mar 14 16:01:48 monster kernel: Out of Memory: Killed process 13205 (diff).
Mar 14 17:01:31 monster kernel: Out of Memory: Killed process 16291 (tar).
Mar 14 17:15:54 monster kernel: Out of Memory: Killed process 16843 (diff).
Mar 14 17:30:55 monster kernel: Out of Memory: Killed process 17549 (diff).
Mar 14 17:57:54 monster kernel: Out of Memory: Killed process 18798 (diff).
Mar 14 17:58:31 monster kernel: Out of Memory: Killed process 19129 (tar).
Mar 14 18:53:02 monster kernel: Out of Memory: Killed process 21348 (diff).
Mar 14 19:22:52 monster kernel: Out of Memory: Killed process 23256 (tar).
Mar 14 21:01:25 monster kernel: Out of Memory: Killed process 27361 (diff).
Mar 14 21:02:01 monster kernel: Out of Memory: Killed process 27461 (diff).
Mar 14 21:48:57 monster kernel: Out of Memory: Killed process 30069 (tar).
Mar 14 22:36:17 monster kernel: Out of Memory: Killed process 32220 (tar).
Mar 14 23:15:29 monster kernel: Out of Memory: Killed process 1333 (tar).
Mar 14 23:52:04 monster kernel: Out of Memory: Killed process 3022 (diff).
Mar 22 11:49:28 monster kernel: Out of Memory: Killed process 504 (identd).
Mar 22 11:53:18 monster kernel: Out of Memory: Killed process 506 (identd).
Mar 22 11:53:18 monster kernel: Out of Memory: Killed process 507 (identd).
Mar 22 11:53:18 monster kernel: Out of Memory: Killed process 508 (identd).
Mar 22 11:53:19 monster kernel: Out of Memory: Killed process 21534 (bash).
Mar 22 11:53:19 monster kernel: Out of Memory: Killed process 21559 (bash).
Mar 22 14:52:31 monster kernel: Out of Memory: Killed process 490 (identd).
Mar 22 15:19:07 monster kernel: Out of Memory: Killed process 633 (xfs).
Mar 22 15:19:09 monster kernel: Out of Memory: Killed process 436 (rpc.statd).
Mar 22 15:19:13 monster kernel: Out of Memory: Killed process 423 (portmap).
Mar 22 15:45:48 monster kernel: Out of Memory: Killed process 543 (lpd).
Mar 22 15:45:54 monster kernel: Out of Memory: Killed process 504 (atd).
Mar 22 16:12:13 monster kernel: Out of Memory: Killed process 524 (sshd).
[dledford@aic-cvs dledford]$ 

What was that you were saying about "should *never* happen"?  Oh, and let's
not overlook the fact that it killed off mostly system daemons to start off
with while leaving the real culprits alone.  Once it did get around to the
real culprits (diff and tar), it wasn't even killing them because they were
overly large, it was killing them because it wasn't reclaiming space from the
buffer cache and page cache.  All of the programs running on this machine were
never more than roughly 256MB of program code, and this is a 1GB machine. 
This behavior is totally unacceptable and, as Alan put it, is a bug in the
code.  It should never trigger the oom killer with 750+MB of cache sitting
around, but it does.  If you want people to buy into the value of the oom
killer, you've at least got to get it to quit killing shit when it absolutely
doesn't need to.

To those people that would suggest I send in code I only have this to say. 
Fine, I'll send in a patch to fix this bug.  It will make the oom killer call
the cache reclaim functions and never kill anything.  That would at least fix
the bug you see above.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
