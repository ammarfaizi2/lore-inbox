Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273934AbRIXPJL>; Mon, 24 Sep 2001 11:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273935AbRIXPJB>; Mon, 24 Sep 2001 11:09:01 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:5645 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S273934AbRIXPIy>; Mon, 24 Sep 2001 11:08:54 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Cress, Andrew R" <andrew.r.cress@intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.10pre10 aic7xxx problem 
Date: Mon, 24 Sep 2001 17:08:54 +0200
Message-Id: <20010924150854.26490@smtp.adsl.oleane.com>
In-Reply-To: <9678C2B4D848D41187450090276D1FAE1008EBA5@FMSMSX32>
In-Reply-To: <9678C2B4D848D41187450090276D1FAE1008EBA5@FMSMSX32>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've seen some pretty heinous bugs in Big Bear firmware of that vintage.
>I'll bet that the aic debug info will indicate that the disk goes out to
>lunch.  I used to support a large customer who had a large population of
>these disks and we went through a lot of pain debugging these drives with
>Seagate.
>The solution will likely be one or both of these changes:
>  1) Upgrade the disk firmware to 1497 or later 
>         (I have a copy if it's not readily available to you.)
>     The servo should also be 6246 or later.
>  2) Turn off SMART in mode page 1C (88 00).  Also the default number of
>retries for the factory settings are way too high.  The mode page settings
>for ST34520W should look like this:
>pg len ....
>-- --  
>01 0a c4 20 79 00 00 00 20 00 ff ff
>02 0e e0 e0 00 00 00 00 00 00 00 00 00 00 00 00
>03 16 00 00 1f 61 00 00 00 00 00 f6 02 00 00 01 00 24 00 34 40 00 00 00
>04 16 00 23 2e 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1c 20 00 00
>07 0a 0c 20 79 00 00 00 00 00 ff ff
>08 12 90 00 ff ff 00 00 ff ff ff ff 80 01 00 00 00 00 00 00
>0a 0a 00 00 00 00 00 00 ff ff 00 00
>1c 0a 88 00 00 00 00 00 00 00 00 01

Ok, thanks. I don't have the firmwares not I know how to update it on
those disks. I can try hacking the mode pages however.

The "weird" thing is that this same disk works perfectly well on MacOS
with the same HW config, and used to work fine in linux until very
recently.

Justin suggested an interrupt problem. I'll look into it in more detail,
but I don't think there's anything like that. This box (PowerMac G4) has
a quite clean interrupt mapping provided by the firmware with no interrupt
sharing, and things related to parsing that firmware didn't evolve lately
(there have been no significant change to PPC OpenPIC interrupt management
since a long time).

Regards,
Ben.


