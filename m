Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbUAITP5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 14:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbUAITP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 14:15:57 -0500
Received: from 163.100.172.209.cust.nextweb.net ([209.172.100.163]:25014 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id S263832AbUAITPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 14:15:53 -0500
Mime-Version: 1.0
Message-Id: <p0602047abc24a5dc714d@[192.168.0.3]>
In-Reply-To: <20040109131812.11fc4948.skraw@ithnet.com>
References: <20040107200556.0d553c40.skraw@ithnet.com>
 <20040107210255.GA545@alpha.home.local>
 <3FFCC430.4060804@candelatech.com>
 <20040108091441.3ff81b53.skraw@ithnet.com>
 <20040108084758.GB9050@alpha.home.local>
 <p0602042fbc2347a37845@[192.168.0.3]>
 <20040109004525.GB545@alpha.home.local>
 <p0602045cbc23ac7a1ada@[192.168.0.3]>
 <20040109131812.11fc4948.skraw@ithnet.com>
Date: Fri, 9 Jan 2004 10:43:13 -0800
To: Stephan von Krawczynski <skraw@ithnet.com>
From: Jonathan Lundell <jlundell@lundell-bros.com>
Subject: Re: Problem with 2.4.24 e1000 and keepalived
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:18pm +0100 1/9/04, Stephan von Krawczynski wrote:
>On Thu, 8 Jan 2004 17:00:42 -0800
>Jonathan Lundell <jlundell@lundell-bros.com> wrote:
>
>>  At 1:45am +0100 1/9/04, Willy Tarreau wrote:
>>  >  > It's unfortunate that the two conditions are conflated by most net
>>  >  > drivers.
>>  >
>>  >IMHO, saying "most net drivers" is unfair : tg3, tulip, 3c59x, starfire,
>>  >realtek, sis900, dl2k, pcnet32, and IIRC sunhme are OK. eepro100 is nearly
>>  >OK but has this annoying bug, and only older 10 Mbps drivers don't report
>>  >their status, often because the chip itself doesn't know.
>>
>>  I'm sure you're right; I should have said most of the drivers that
>>  I'm using (including e100 &e1000).
>
>Can we find the cause for this obviously buggy behaviour inside the source?
>Where is the handling of physical up/down events different in tulip 
>compared to
>e100(0) ?

In e1000 5.2.20 (as in earlier versions), the link-state reporters 
rely on netif_carrier_ok() for the state, which is in turned 
maintained by the driver's watchdog timer.

e1000_down() both cancels the watchdog timer and calls 
netif_carrier_off(), guaranteeing that if the interface is logically 
down, the link will be reported as down regardless of the actual link 
state.

I think e100 works the same way, though I haven't looked at the New & 
Improved version.
-- 
/Jonathan Lundell.
