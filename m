Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWIBLPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWIBLPy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 07:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWIBLPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 07:15:54 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:26251 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750977AbWIBLPx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 07:15:53 -0400
Message-ID: <44F967E8.9020503@drzeus.cx>
Date: Sat, 02 Sep 2006 13:15:52 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>, Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash
 card readers
References: <20060902085343.93521.qmail@web36708.mail.mud.yahoo.com>
In-Reply-To: <20060902085343.93521.qmail@web36708.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, the stuff meant for you is at the bottom.

Alex Dubov wrote:
> Hi there.
> I've made a couple of fixes to my flashmedia driver
> (http://developer.berlios.de/projects/tifmxx/) to the
> effect of much improved R/W speed in PIO mode and
> writing speed in DMA mode.
>   

The users will be pleased :)

> I also tried to clean-up reverse engineering mess out
> of the code - it should be more readable now.
>   

Wonderful. Things are looking a lot better. I have a few questions though.

The constants you've borrowed from OMAP, have you confirmed all of them?
If not, you should add a comment to those that are pure speculation so far.

tifm_sd_op_flags() still use literals. Could you fix up some defines
there as well?

tifm_sd_fetch_resp() could be redone as a for loop to make it more
obvious what's going on. Also, please don't put several statements on
one line.

You should probably rename tifm_sd_set_data_to(). It isn't obvious that
'to' stands for 'timeout'. Same thing with other instances of 'to'.

We're also in the process of fixing this dreadfully slow write mess.
What I'd like to see from you is to double check that bytes_xfered is
set to the number of bytes successfully sent to the _card_, not the
controller. This is critical for correct handling of bus errors.

> Next on my list is MemoryStick functionality.
>
>   

I would suggest finishing this and getting it merged to be your top
priority. There are quite a few people who would like to have this
hardware supported. Which brings me to...

Andrew, we could use some help with how this driver should fit into the
kernel tree. The hardware is multi-function, so there will be a couple
of drivers, one for every function, and a common part. How has this been
organised in the past?

Rgds
Pierre


-- 
VGER BF report: H 0.0963121
