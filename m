Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311362AbSC1Dhn>; Wed, 27 Mar 2002 22:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311570AbSC1Dhd>; Wed, 27 Mar 2002 22:37:33 -0500
Received: from malasada.lava.net ([64.65.64.17]:64743 "EHLO malasada.lava.net")
	by vger.kernel.org with ESMTP id <S311362AbSC1DhW>;
	Wed, 27 Mar 2002 22:37:22 -0500
Message-Id: <m16qQix-0014LaC@malasada.lava.net>
Date: Wed, 27 Mar 2002 17:37:15 -1000 (HST)
From: bhoward@hale.org
To: James Mayer <james.mayer@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bug] 2.4.19-pre4-ac2 hang at boot with ALI15x3 chipset support
In-Reply-To: <86387368@toto.iv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > After adding printk calls to alim15x3.c, it seems to hang during the
>> > pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02) call on line 588.
>> 
>> Does it work if you comemtn that line out ?

James> No, if the line is commented out I get:

James> hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
James> hda: drive not ready for command

I ran into this as well under various kernels including 2.4.18.  Try
adding:
    append="idebus=50"

to the lilo stanza for your kernel.

It seems even after I amputated the offending "write" that causes the
lockup, the bus speed was being set to 33MHz instead of 50Mhz.  The
above solved the problem for me.

I don't need to specifically set idebus in the 2.5.7 version of the
driver so I assume something has been corrected in more recent
releases.

For anyone else trying to configure the pcg-c1mrx or pcg-c1mv, I'm
updating linux configuration document as I work through the
setup of the various devices:
    http://hale.org/~bhoward/issue_7/pcg-c1mrx.html

						Bruce
