Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318883AbSHUUgP>; Wed, 21 Aug 2002 16:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319203AbSHUUgP>; Wed, 21 Aug 2002 16:36:15 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:15302 "HELO atlrel7.hp.com")
	by vger.kernel.org with SMTP id <S318883AbSHUUgP> convert rfc822-to-8bit;
	Wed, 21 Aug 2002 16:36:15 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Larry Butler <larry_butler@hp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] IPMI driver for Linux
Date: Wed, 21 Aug 2002 14:41:40 -0600
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208211441.40195.larry_butler@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Corey,

I've been working on a driver too because the busy waits in the drivers that 
are out there can hold a CPU for too long.  I've measured as much as 120ms.

First I tried sleeping in the driver until the very next jiffy.  I found that 
my driver became unreliable under high CPU load because the scheduling delays 
were too long.  I even managed wedge the BMC on one of my test systems in a 
way I can't seem to fix. :)

What I finally settled on was using the timer interrupt.  This seems to work 
well both in terms of being nice to the rest of the system (I register a 
shared irq handler only while I need it) and being reliable even under high 
load.   So, just consider it a suggestion.  I'd like to see your driver 
included too.  It's certainly more complete than mine.  You must have access 
to more documentation than I do.

Larry

