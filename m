Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271376AbUJVPoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271376AbUJVPoV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271377AbUJVPoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:44:20 -0400
Received: from ns.theshore.net ([67.18.92.50]:35557 "EHLO www.theshore.net")
	by vger.kernel.org with ESMTP id S271376AbUJVPoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:44:14 -0400
Message-ID: <001d01c4b84e$b5f88720$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.9 - unable to unmount tmpfs
Date: Fri, 22 Oct 2004 10:49:25 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.6.9 + skas3-v6 + cfq2 (from 2.6.9-ck1)

This box runs a bunch of UMLs -- I mount a tmpfs volume to hold the UML's memory file
each time an UML runs, and with 2.6.9 I'm unable to to unmount the tmpfs volume even
though there are no referring processes...

[root@host19 root]# lsof | grep "/linodes/holden/tmp"
[root@host19 root]#

[root@host19 root]# mount | grep holden
tmpfs on /linodes/holden/tmp type tmpfs (rw,size=64M,mode=0770)
tmpfs on /linodes/holden/tmp type tmpfs (rw,size=64M,mode=0770)
tmpfs on /linodes/holden/tmp type tmpfs (rw,size=64M,mode=0770)

[root@host19 root]# umount /linodes/holden/tmp
umount: /linodes/holden/tmp: device is busy
umount: /linodes/holden/tmp: device is busy
umount: /linodes/holden/tmp: device is busy

I assume this is a bug in 2.6.9 and not UML, possibly relating to ptrace (?) since
UML requires a kill -CONT <pid> to exit properly under 2.6.9 with any version of UML.
I tried creating a tmpfs mount and a few files within, and it unmounted correctly.

Thanks,
-Chris

