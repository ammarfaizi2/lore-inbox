Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbVITKCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbVITKCb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 06:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbVITKCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 06:02:31 -0400
Received: from [85.8.12.41] ([85.8.12.41]:50818 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S964958AbVITKCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 06:02:30 -0400
Message-ID: <432FDE3A.3070304@drzeus.cx>
Date: Tue, 20 Sep 2005 12:02:34 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: sched_clock() has poor resolution
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to hunt down a HZ bug and as part of that I thought
having printk timestamps would be nice. But too much dismay I noticed
that I couldn't get very good resolution out of these.

The problem turned out to be that sched_clock() uses jiffies as a time
source. It will only use the TSC if that's the primary time source of
the system. But since I have a PM timer that is given priority.

So I see two solutions here:

 * Let sched_clock() follow the time source. Don't have it coupled to
the TSC.

 * Init the TSC even though it isn't used for anything but sched_clock().

The first solution might have problems if one of the "better" timers are
slow as hell to read and the second if there is some assumed dependency
between sched_clock() and the primary timer. I'm blisfully ignorant of
this area so input is welcome.

Rgds
Pierre
