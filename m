Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311456AbSCSRLN>; Tue, 19 Mar 2002 12:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311458AbSCSRLB>; Tue, 19 Mar 2002 12:11:01 -0500
Received: from [195.63.194.11] ([195.63.194.11]:36356 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311456AbSCSRKt>; Tue, 19 Mar 2002 12:10:49 -0500
Message-ID: <3C9770C9.5000201@evision-ventures.com>
Date: Tue, 19 Mar 2002 18:09:29 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Luigi Genoni <kernel@Expansa.sns.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: oops at boot with 2.5.7 and i810
In-Reply-To: <Pine.LNX.4.44.0203191716170.24700-100000@Expansa.sns.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Genoni wrote:
> HI,
> 
> also with 2.5.7, as with 2.5.6, I have problems at boot.
> I get the usual oops while initialising IDE.
> 
> my ide controller is:
> 
> 00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80
> [Master])
>         Subsystem: Intel Corporation 82801AA IDE
>         Flags: bus master, medium devsel, latency 0
>         I/O ports at 2460 [size=16]
> 
> unfortunatelly, I do not have even the time to write down oops message,
> but eip is c0135068, but then I do not find a similar entry in system.map
> 
> any hint

This device is behaving quite like the 440MX chipset
I have myself I can't therefore the oops expect beeing caused
by a trivial programming error in the actual ide driver.
I don't see much pointer acces in piix.c code as well.

However you could eventually just try apply the following
pseudo diff to piix.c and then try again:

- 
{ PCI_DEVICE_ID_INTEL_82801AA_1,	PIIX_UDMA_66  | PIIX_PINGPONG },
+ 
{ PCI_DEVICE_ID_INTEL_82801AA_1,	PIIX_UDMA_66 },

Replaceing PIIX_UDMA_33 with PIIX_UDMA_33 could be worth a try as well.




