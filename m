Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265660AbUEZOft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265660AbUEZOft (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 10:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265703AbUEZOft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 10:35:49 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:27140 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265660AbUEZOfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 10:35:47 -0400
Subject: swsusp fails short on memory
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1085582116.1785.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Wed, 26 May 2004 16:35:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm somewhat ignorant on the inner workings of swsusp. I have a 256MB
laptop machine running 2.6.7-rc1-bk2 + ACPI + swsusp two swap
partitions, a 256MB swap partition on /dev/hda4 plus another 256MB swap
on /dev/hda5. When trying to hibernate to disk, swsusp fails with the
following error message:

PCMCIA: socket cf71302c: *** DANGER *** unable to remove socket power
Stopping tasks:
====================================================================|
Freeing memory: ..|
/critical section: counting pages to copy.[nosave pfn
0x2f2]...............................................................
(pages needed: 46305+512=46817 free: 19214)
Suspend Machine: Couldn't get enough free pages, on 27603 pages short
Suspend Machine: Suspend failed, trying to recover...
Fixing swap signatures... ok
Restarting tasks...<4>atkbd.c: Unknown key released (translated set 2,
code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
 done

What I can't unserstand is how swsusp fails with "couldn't get enough
free pages". cat /proc/swaps tells:

Filename                  Type            Size    Used    Priority
/dev/hda4                 partition       281128  0       0
/dev/hda5                 partition       281096  192     1

What going on here? Why does swsusp fail when there is plenty of free
swap space?

NOTE: The same happens while only using a big, 512MB swap partition.

Thanks.

