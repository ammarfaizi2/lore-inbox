Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271134AbRHOLDs>; Wed, 15 Aug 2001 07:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271135AbRHOLDj>; Wed, 15 Aug 2001 07:03:39 -0400
Received: from customers.imt.ru ([212.16.0.33]:28164 "HELO smtp.direct.ru")
	by vger.kernel.org with SMTP id <S271134AbRHOLDY>;
	Wed, 15 Aug 2001 07:03:24 -0400
Message-ID: <20010815035800.A24565@saw.sw.com.sg>
Date: Wed, 15 Aug 2001 03:58:00 -0700
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Ime Smits <ime@isisweb.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Camino 2 (82815/82820) v2.4.x eth/sound related lockups
In-Reply-To: <E15WcZ9-0000zr-00@the-village.bc.nu> <Pine.LNX.4.33.0108141351320.3880-100000@fatbird.isisweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <Pine.LNX.4.33.0108141351320.3880-100000@fatbird.isisweb.nl>; from "Ime Smits" on Tue, Aug 14, 2001 at 02:01:31PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All these wait_for_cmd_done timeout issues look very much like new (or
previously unknown) timing constraints in new onboard chips.
It isn't completely power management-related.

Donald fixed one of such issues several months ago, which I primarily
observed on i82559ER.
Apparently, it's another one.  The chip gets stuck and stops to process
commands.

For a lot of people inserting `udelay(1);' inside wait_for_cmd_done loop
helped, not because it's right to make the delay, but because it changes
timing and introduces minimal 1usec delay even if the chip is ready almost
instantly :-(

Best regards
		Andrey

On Tue, Aug 14, 2001 at 02:01:31PM +0200, Ime Smits wrote:
> 
> INDIVIDVVS VOCATVR Alan Cox DIE 14/8/2001 12:40 VERE SCRIPSIT:
> 
> | Those are not so good. I was having similar problems on an i810 box with
> | onboard eepro100 until I disabled the pm stuff in 2.4.8ac2, but you
> | seem to be running that one
> 
> Already figured that out. Oh, and I forget to mention that the same lockups
> happen with all 2.4  versions I was able to find on my boxen, including
> 2.4.0, -ac7, 2.4.2, 2.4.5, 2.4.5-ac3, -ac5, 2.4.6,  2.4.7, 2.4.8 and -ac2,
> so this is not something introduced in recent kernels. With
> 2.4.8-ac2 I  played with enabling/disabling ACPI & PM stuff and also APIC
> irq stuff as mentioned in the eepro100 thread. No go.
