Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVBHAVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVBHAVF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 19:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVBHAVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 19:21:05 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:45445 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261353AbVBHAVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 19:21:01 -0500
Subject: Merging the Suspend2 freezer implementation.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1107822206.2756.18.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 08 Feb 2005 11:23:26 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel.

I'm keen to see if we can merge Suspend2's freezer implementation after
2.6.11. Does that conflict with any of your intended changes? If it
doesn't, I'll submit a patch for review/merge as quickly as I can.

The main change involves the introduction of a new SYNCTHREAD flag. We
use this to avoid deadlocking over processes that are running sys_sync
and siblings. Processes that enter those routines get the flag added,
and it's removed when they exit the sync routine. We then freeze in four
stages: 

1) Freeze user space threads without SYNCTHREAD set;
2) Freeze user space threads with SYNCTHREAD set;
3) Run our own sys_sync in case no one else was syncing
4) Freeze kernel space threads without NOFREEZE set.

I'd also like to look at your SMP support and see if we can improve
compatibility there at the same time.

Finally I'd like to merge the support for freezer flags on workqueues.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

