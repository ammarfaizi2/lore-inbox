Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTJKPBe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 11:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTJKPBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 11:01:34 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:1205 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262066AbTJKPBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 11:01:33 -0400
Message-ID: <3F881B46.6070301@colorfullife.com>
Date: Sat, 11 Oct 2003 17:01:26 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] SMP races in the timer code, timer-fix-2.6.0-test7-A0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:

>fixing this second race is hard - it involves a heavy race-check operation
>that has to lock all bases, and has to re-check the base->running_timer
>value, and timer_pending condition atomically.
>  
>
What about moving the "timer running" information into the timer_list, 
instead of keeping it in the base?
For example base=0 means neither running nor pending. base=1 means 
running, but not pending, and pointers mean pending on the given base.

This would allow an atomic test without the brute force locking.

--   
     Manfred


