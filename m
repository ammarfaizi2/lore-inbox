Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318360AbSGYH64>; Thu, 25 Jul 2002 03:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318361AbSGYH6z>; Thu, 25 Jul 2002 03:58:55 -0400
Received: from zeus.kernel.org ([204.152.189.113]:58295 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S318360AbSGYH6z>;
	Thu, 25 Jul 2002 03:58:55 -0400
Message-ID: <3D3FAEB1.6070704@evision.ag>
Date: Thu, 25 Jul 2002 09:54:25 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Pete Zaitcev <zaitcev@redhat.com>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Safety of IRQ during i/o
References: <Pine.SOL.4.30.0207250041400.15959-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Wed, 24 Jul 2002, Pete Zaitcev wrote:
> 
> 
>>>[...]
>>>I would think that this would be safe when using DMA, and likely to be
>>>safe for PIO and more recent chipsets, but I wouldn't want to actually
>>>tell anyone that.
>>
>>A little story from OLS. I have a 486/75 laptop, which can only
>>do PIO. It always was losing characters evern on 9600 baud on its
>>serial port, and I thought it was simply broken for five years.
> 
> 
> :-)
> 
> 
>>A guy who did a security talk showed me that doing hdparm -u
>>fixes the problem. Apparently, the lappy has a non-buffering UART.
>>
>>So, it seems that hdparm -u is a very useful thing for obsotele
>>boxes. If you do DMA, you probably do not care.
> 
> 
> Yup, for PIO unmask (if possible) is a must.

It's even for DMA a good thing, since the IRQ handler in question can
reenter the RQ handler. The invention of the not unmasking
behaviour in Linux is the result of some not entierly ATA-2 compliant
devices long long time ago gone. Basically XT disks on PC. They did have 
the habbit of splewing IRQs too early for command ACK.

