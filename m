Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263837AbUDNAmI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 20:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263842AbUDNAmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 20:42:08 -0400
Received: from pileup.ihatent.com ([217.13.24.22]:49609 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S263837AbUDNAlp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 20:41:45 -0400
To: Josh Logan <josh@wcug.wwu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel hang on MX server
References: <Pine.LNX.4.58.0404131648480.27502@sloth.wcug.wwu.edu>
From: Alexander Hoogerhuis <alexh@boxed.no>
Date: Wed, 14 Apr 2004 02:41:23 +0200
In-Reply-To: <Pine.LNX.4.58.0404131648480.27502@sloth.wcug.wwu.edu> (Josh
 Logan's message of "Tue, 13 Apr 2004 17:14:23 -0700 (PDT)")
Message-ID: <87r7ur5r2k.fsf@dorker.boxed.no>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two HP DL360G3's running a very identical load on Gentoo, both
go into doorstop-emulation mode on 2.6.5-mm1 and higher -mm-kernels
withing 24 of running with very low load. I use hardware RAID, and
ha've SCSI, but otherwise its ServerWorks chipsets and ext3.

I've only caught them a few times in seeing the actual oops; at other
times it's happened with a blanked console, but the few I've seen have
been dying while handling an interrupt, and also, the tg3-driver have
figured prominently in the stack trace. 

If anyone have have a good idea on how to capture an oops that
instantly freezes the machine, then I'll go through and capture it
again; but for now I'm down on 2.6.3-mm3 and running solidly.

mvh,
A

Josh Logan <josh@wcug.wwu.edu> writes:

> I have 2 IBM x305's which hang every few days in identical ways.  Both are
> running postfix (with amavis-new, spamassassin and clamav from
> backports.org) and bind9.  They are running debian stable.
>
> The IDE controler is: ServerWorks CSB5 IDE
> The Kernel is 2.6.4
> I have tried 2.4 kernels with ext3.  I have also tried 2.6.4 kernels with
> ext3, jfs, and xfs, but all three FS show the same errors.
> Currently trying ext2 on one of the machines.
>
> The systems is running software raid1 between both hard drives.
> /dev/hda1 and /dev/hdc1 make up md0 which is mount on /
> /dev/hda3 and /dev/hdc3 make up md1 which used LVM to make /usr /home /var
> and /var/spool/postfix
>
> I have also tried mount --bind /postfix /var/spool/postfix to take LVM out
> of the picture.  That did not help.  I have not tried to break the mirror
> and only use 1 IDE drive.
>
> Please see the attached files for better formating, and all of the
> running commands.
>
> The following processes are in uninterruptible sleep (usually IO) via ps:
> root@ares:~# ps axln | grep D
> F   UID   PID  PPID PRI  NI   VSZ  RSS  WCHAN STAT TTY        TIME COMMAND
> 1     0   103     1  15   0     0    0 11e11e D    ?          0:07
> [kjournald]
> 1     0   248     1  15   0     0    0 11e11e D    ?          0:04
> [kjournald]
> 5     0   332     1  15   0  1432  672 86e7cf Ds   ?          0:24
> /sbin/syslogd
> 4   102  9574  9572  16   0  2596 1176 109ea5 D    ?          0:24 qmgr -l
> -t fifo -u -c
> 4   102 26473  9572  17   0  2544 1112 86e7cf D    ?          0:00 cleanup
> -z -n pre-cleanup -t unix -u -c -o virtual_alias_maps  -o canonical_maps
> -o sender_canonical_maps  -o recipient_canonical_maps  -o masquerade_domains
> 4   102 26509  9572  16   0  2464 1020 109ea5 D    ?          0:00 showq
> -t unix -u -c
>
> Decoding the WCHAN:
> 11e11e ->
> c011e0f4 T yield
> c011e110 T io_schedule
> c011e128 T io_schedule_timeout
> c011e144 T sys_sched_get_priority_max
>
>
> 86e7cf ->
> not in System.map, but PS gave: log_wait_commit
>
>
> 109ea5 ->
> c0109df4 t __check_printsym_format
> c0109e00 T __up
> c0109e18 T __down
> c0109f24 T __down_interruptible
>
> Where PS was run as:
> ps -o pid,nwchan,wchan=WIDE-WCHAN-COLUMN -o comm -o state axf
>
>
> I'll happily provide more information, but not sure what to try next.
> Looks like it may be a driver issue, blocking IO writes to the drives.
>
> 							Later, JOSH
>

-- 
Alexander Hoogerhuis                               | alexh@boxed.no
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
