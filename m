Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWIZJoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWIZJoR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 05:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWIZJoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 05:44:17 -0400
Received: from [212.227.126.177] ([212.227.126.177]:1513 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750992AbWIZJoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 05:44:15 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Aubrey <aubreylee@gmail.com>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Date: Tue, 26 Sep 2006 11:43:59 +0200
User-Agent: KMail/1.9.4
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com> <200609251905.22224.arnd@arndb.de> <6d6a94c50609252042g72f676a9s609095e2f1187ada@mail.gmail.com>
In-Reply-To: <6d6a94c50609252042g72f676a9s609095e2f1187ada@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609261144.00022.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 September 2006 05:42, Aubrey wrote:
> So, in the kernel space, there is always one bit in the IPEND register
> is set. And if there comes a timer interrupt event, in the timer
> interrupt handler, there should be two bits set in the IPEND register.
> Therefore, schedule happens in the return_from_int.
> 
> So, I still say there is no latency here.
> 

Well, if that's true, you should change your idle function not to
explicitly call schedule().

I haven't really understood how you preempt the idle task, but
I guess you can simplify the standard

| while (1) {
|	while (!need_resched())
|		asm("idle");
|	schedule();
| }

to 

| while (1)
| 	asm("idle");


	Arnd <><
