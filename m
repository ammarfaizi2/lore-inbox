Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWFYKz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWFYKz6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 06:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWFYKz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 06:55:57 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:8898 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932344AbWFYKz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 06:55:57 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Sun, 25 Jun 2006 12:53:55 +0200
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Bugme-new] [Bug 6745] New: kernel hangs when trying to read  
 atip wiith cdrecord
Message-ID: <449E6B43.nail9A11I1BV@burner>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You did write:

>> Executing 'read buffer' command on Bus 1 Target 0, Lun 0 timeout 40s
>> CDB:  3C 00 00 00 00 00 00 FC 00 00
>> 
>> So the kernel doesn't timeout/return for some reason.
>> You can find the full log here:
>> http://muenchen-surf.de/lohmaier/cdrecord_atip_log
>> 
>> If that information is not enough to handle the process, please tell me what
>> else you need. Thank you.
>> 

>We seem to have an awful lot of these "CD burner doesn't work but it did in
>2.4" reports.

>Does anyone have the vaguest inklink of how we broke it?

There are various reasons....

One important problem of course is the fact that various distributors (e.g. 
RedHat, Suse, Debian, Ubuntu) are ungrading cdrecord slower than the Linux 
kernel changes it's interfaces. Related  to is problem: the Linux Kernel folks
do not inform me before breaking Linux kernel interfaces, so I am informed too 
late in order to add a workaround to cdrecord in time.

The most recent interface changes have been:

-	Instead of fixing the bug that allowed anyone to send arbitrary SCSI 
	commands to CD/DVD-recorders (caused by not requiring write permission
	on the node), the behavior of SCSI generic was changed (in 2.6.8.1).

	Old behavior: open device as root and send commands as user.
	New behavior: open device as user and send commands as root.

-	Some time between January 2006 and 2004, a new rlimit "RLIMIT_NOFILE"
	was added and implemented in a way that is not compatible to previous
	kernel behavior.

	Old behavior: mlockall(MCL_CURRENT|MCL_FUTURE) done as root was honored
			for the same process if later continued as user.
	New behavior: mlockall(MCL_CURRENT|MCL_FUTURE) done as root is no longer
			honored for the same process if later continued as user.


Another problem is caused by the fact that various distributors (e.g. RedHat, 
Suse, Debian, Ubuntu) are applying patches to cdrecord that break cdrecord.


The problem mentioned in this thread seems to be caused by the fact that
Linux sometimes ignores timeouts. I have no idea how to help in this (timeout) 
case.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
