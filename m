Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267238AbTA0RCf>; Mon, 27 Jan 2003 12:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267239AbTA0RCf>; Mon, 27 Jan 2003 12:02:35 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:28767 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S267238AbTA0RCf>; Mon, 27 Jan 2003 12:02:35 -0500
Message-ID: <3E356854.1090100@google.com>
Date: Mon, 27 Jan 2003 09:11:48 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG: [2.4.18+] IDE Race Condition
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is at least one more IDE race condition in 2.4.18 and 2.4.21-pre3. 
 Basically the interrupt for the controller being serviced is left on 
while setting up the next command.  I'm not sure how much trouble it can 
cause but it does lead to some interesting stack traces.

The condition
if (masked_irq && hwif->irq != masked_irq)
in ide_do_request should be replaced with
if (!masked_irq || hwif->irq != masked_irq)
in two places.

This doesn't totally eliminate the race conditions, but it does minimize 
them some more.  I can still see a race in 2.4.18.  I'll say more about 
it once I've tracked it down.

    Ross


