Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266102AbUAQSnr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 13:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUAQSnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 13:43:46 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:22181 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266102AbUAQSnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 13:43:35 -0500
Message-ID: <40098251.2040009@colorfullife.com>
Date: Sat, 17 Jan 2004 19:43:29 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] kill sleep_on
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Virtually all sleep_on / interruptible_sleep_on users are racy. Actually
there is only one safe case: if both wakeup and sleep happen under
lock_kernel.
Any objections against killing it entirely? Or what about marking it as
deprecated, as the first step towards killing it?

I'll follow with two patches that remove it from shaper and sunrpc/sched
- shaper is racy, rpciod_down is only safe if called with lock_kernel.

--
    Manfred


