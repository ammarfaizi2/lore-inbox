Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbTDPQtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264458AbTDPQtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:49:05 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:7333 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264453AbTDPQrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:47:36 -0400
Message-ID: <3E9D8BE6.1020006@colorfullife.com>
Date: Wed, 16 Apr 2003 18:59:18 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shawn Starr <spstarr@sh0n.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-bk5 spinlock warnings/errors - Specifically ide-io:109
 spinlock notice
References: <3E8BCB3A.8080806@colorfullife.com> <003b01c30435$27ac0ab0$030aa8c0@unknown>
In-Reply-To: <003b01c30435$27ac0ab0$030aa8c0@unknown>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:

>I'm going to apply this and see what happens, unless it was already added to
>.67-bk latest?
>  
>
Alan included it into the -ac kernels, I guess he will forward it to Linus.

>>--- 2.5/drivers/ide/ide-io.c 2003-03-25 17:49:40.000000000 +0100
>>+++ build-2.5/drivers/ide/ide-io.c 2003-03-30 10:05:28.000000000 +0200
>>@@ -973,7 +973,7 @@
>>    
>>
>>  }
>>
+   wait = 0;

>>  if ((expiry = hwgroup->expiry) != NULL) {
>>  /* continue */
>>- if ((wait = expiry(drive)) != 0) {
>>+ if ((wait = expiry(drive)) > 0) {
>>  /* reset timer */
>>  hwgroup->timer.expires  = jiffies + wait;
>>  add_timer(&hwgroup->timer);
>>
This change was missing in my patch: wait was used without initialization.


--
    Manfred

