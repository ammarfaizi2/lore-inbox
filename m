Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263810AbUDVK7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbUDVK7J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 06:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263933AbUDVK7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 06:59:09 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:3290 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S263810AbUDVKxg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 06:53:36 -0400
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
To: Arjan van de Ven <arjanv@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF99EB5E0C.21B30690-ONC1256E7E.003B1339-C1256E7E.003BCEE8@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 22 Apr 2004 12:53:15 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 22/04/2004 12:53:17
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> well my worry is the API; should it be "turn the timer off" or should it
be
> "the next tick is THIS many from now". The later allows one to use the hw
in
> one-shot mode (PC's can do this) where the scheduler timeslice expiry
ends
> up being a timer as well.

The sysctl is /proc/sys/kernel/hz_timer. If it contains a "1" then HZ timer
is
active in idle, a "0" indicates that the HZ timer is switchted off.
The semantic "the next tick is THIS many <ticks> from now" IHMO doesn't make
any sense. Skipping ticks will have some really bad effects, e.g. if the xtime
isn't up-to-date network packets will get incorrect time stamps, timer events
will be delivered too late, etc.

blue skies,
   Martin

