Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267308AbSLRSJn>; Wed, 18 Dec 2002 13:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267310AbSLRSJn>; Wed, 18 Dec 2002 13:09:43 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:47726 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S267308AbSLRSJm>; Wed, 18 Dec 2002 13:09:42 -0500
Message-ID: <3E00BBC0.6020807@google.com>
Date: Wed, 18 Dec 2002 10:17:36 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "D.A.M. Revok" <marvin@synapse.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133
 Promise ctrlr, or...
References: <200212151549.37661.marvin@synapse.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a bug in the Promise driver that clears an important PIO bit 
when switching into DMA mode.  When you do an hdparm -I, it issues a 
drive command that attempts to transfer data in PIO mode, but since the 
PIO mode timing registers are hosed, the machine locks up.  It's easy to 
reproduce and applies to all drive commands that return data including 
SMART commands.

The bit in particular is bit 4 of PCI config register 0x61+4*channel 
number (PB bit 4 in Promise terms.)  I've got a very unclean fix that I 
will attempt to clean up once I can put a few more important issues to bed.

For the time being, you can try to do a work around by putting the drive 
into PIO mode with hdparm -X 12  before issuing any drive commands.

    Ross

D.A.M. Revok wrote:

>( that's a capital-aye in the hdparm line )
>
>not even the Magic SysReq key will work.
>
>also, don't
>
>"cd /proc/ide/hde ; cat identify"
>
>... same thing
>drive-light comes on, but have to use the power-switch to get the machine 
>back, ( lost stuff again, fuck )
>
>
>proc says it's pdc202xx
>
>Promise Ultra series driver Ver 1.20.0.7 2002-05-23
>Adapter: Ultra100 on M/B
>
>  
>



