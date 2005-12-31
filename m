Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbVLaSHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVLaSHs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 13:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVLaSHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 13:07:48 -0500
Received: from bay103-f34.bay103.hotmail.com ([65.54.174.44]:22324 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932307AbVLaSHs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 13:07:48 -0500
Message-ID: <BAY103-F3438FAEB6A51CC5567D48DDF2B0@phx.gbl>
X-Originating-IP: [69.222.162.187]
X-Originating-Email: [dravet@hotmail.com]
In-Reply-To: <Pine.LNX.4.61.0512311830030.7910@yvahk01.tjqt.qr>
From: "Jason Dravet" <dravet@hotmail.com>
To: jengelh@linux01.gwdg.de
Cc: linux-kernel@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: RFC: add udev support to parport_pc
Date: Sat, 31 Dec 2005 12:07:47 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 31 Dec 2005 18:07:48.0015 (UTC) FILETIME=[1B443BF0:01C60E35]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the reply.  Comments inline.

>I would prefer to actually see == 0x378 in the code, because the
>hexademical number is what you see everywhere else, such as the BIOS POST
>and /proc/ioports. This also applies to 0x278 and 0x3BC below.
>
This is what I wanted but I could not figure out how do it.  If you tell me 
how I will be happy to change it.  I tried  if (p->base == 0x378) but then 
class_device_create does not get executed.

> > +	{
> > +		class_device_create(parallel_class, NULL, MKDEV(6, 0), NULL,
> > "lp0");
> > +		class_device_create(parallel_class, NULL, MKDEV(99, 0), NULL,
> > "parport0");
> > +	}
>
>Background info before: Because I burnt my on-board LPT port (applying too
>much volts or milliamps), I bought a dual-slot PCI add-in card. This card
>provides "parport1" and "parport2" at ports at 0xC800 and 0xC00
>(/proc/ioports).
>
The last experience I have with off board cards was about 5 years ago.  The 
choices for the two parallel ports were 378, 278, or 3BC.  I was not aware 
that you had flexibility now.
>
>There are a number of problems in your code:
>
>1- testing just for 0x378/0x278/0x3BC is not enough
>
>2- parport0 could be 0xC800 (address may vary) if you do not
>    have any onboard LPT ports.
>     2=> that is why I think you should not reserver "lp0"/"parport0"
>         for 0x378.
As I said above I was not aware todays off board parallel ports had more 
choices.  I will see what I can do to fix this.  Do you have any 
suggestions?

Thanks,
Jason


