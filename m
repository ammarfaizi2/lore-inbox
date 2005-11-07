Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVKGQHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVKGQHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 11:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbVKGQHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 11:07:38 -0500
Received: from [202.125.80.34] ([202.125.80.34]:21320 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S964855AbVKGQHh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 11:07:37 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: Comments on 2.6.10 schedule_timeout please
Date: Mon, 7 Nov 2005 21:34:05 +0530
Message-ID: <3AEC1E10243A314391FE9C01CD65429B13B2E6@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Comments on 2.6.10 schedule_timeout please
Thread-Index: AcXjqwXuOu1/k9oGTAq1yBZwAeSqWgAB8Y5A
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Nish Aravamudan" <nish.aravamudan@gmail.com>
Cc: "Adrian Bunk" <bunk@stusta.de>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Nish,
Sorry that I cannot share the entire code as I have to face some licensing issues.
Please find the required code snapshots below. 
please ask if I have missed something ...

Please see the source code explained briefly below:-

/* my_msleep() sleep milli(msec) seconds */
void my_msleep(int msec)
{
	current->state = TASK_INTERRUPTIBLE;
	schedule_timeout((msec * HZ)/1000);
}
{
MMCSD_RESPONSE2
{
	..............
	.............
	/* gather the hardware interrupt reg status that is updated in the ISR context*/
	..............
	............
}

StandbyMMCSD(PCMMCSD pSD)
{
	do
	{
		tifm_msleep(300);
	}while(!MMCSD_RESPONSE2(pSD, 31, 31, false));
}

Code Description:
This is a part SD card Driver for 2.6.10 kernel & it works fine.
This part of the code is called in the ISR context from the bottomhalf when the SD Card is inserted to initialize the SD slot & card.

How did I diagnose the delay:

1) After inserting the card, I tried pressing the character '1' expecting the shedule_tiemout works by giving the keyboard  process its time to execute and print 1's onto the screen. Instead, I found the a BIG delay of 20 characters. i.e. 20  characters printed at once after the SD card initialization is done.
2) With debug messages immediately before & after the schedule_timeout call.
3) Commenting the schedule_timeout call.
 
Regards,
Mukund Jampala



-----Original Message-----
From: Nish Aravamudan [mailto:nish.aravamudan@gmail.com]
Sent: Monday, November 07, 2005 8:24 PM
To: Mukund JB.
Cc: Adrian Bunk; linux-kernel@vger.kernel.org
Subject: Re: Comments on 2.6.10 schedule_timeout please


On 11/7/05, Mukund JB. <mukundjb@esntechnologies.co.in> wrote:
>
> Dear Kernel Developers,
>
> I have noticed the schedule_timeout behaving somewhat different as penned
> from the Linux 2.6 Oreelly books.
> I have developed a SD card Driver for 2.6.10 kernel & it works fine.
> I needed a hardware reg to update that take a time of 300ms. I have issued a
> call like..
>
> set_current_state(TASK_INTERRUPTIBLE);
> schedule_timeout (300*HZ/1000);

Full code or function snippet, please.

> But, when I finally use it I get a sufficient delay which looks like a looped delay
> not allowing the keyboard to print messages on the screen.

This would be easier to diagnose if you shared all of the code you are
using *and* verified this occurred with a current kernel (2.6.10 is
old.).

Thanks,
Nish
