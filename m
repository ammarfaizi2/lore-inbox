Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292754AbSBUUMQ>; Thu, 21 Feb 2002 15:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292753AbSBUUMG>; Thu, 21 Feb 2002 15:12:06 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:53258 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S292700AbSBUULz>; Thu, 21 Feb 2002 15:11:55 -0500
Message-Id: <200202212011.g1LKBxI49280@aslan.scsiguy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: axboe@suse.de (Jens Axboe), scarfoglio@arpacoop.it (Carlo Scarfoglio),
        linux-kernel@vger.kernel.org
Subject: Re: AIC7XXX 6.2.5 driver 
In-Reply-To: Your message of "Thu, 21 Feb 2002 19:30:19 GMT."
             <E16dyv5-0007xz-00@the-village.bc.nu> 
Date: Thu, 21 Feb 2002 13:11:59 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> included in certain 2.4.18-pre kernels which was the cause of the patch
>> not working for him.  I can only assume you ran into the same problem.
>> My patch was relative to 2.4.17, not a more recent, yet unblessed, kernel.
>
>Relative to 2.4.18-rc would be good

Okay.  I will do this sometime this weekend.  I'm currently in the
middle of a business trip which makes testing a new patch difficult.

>> As to the CMD640 patch.  Can you let me know why you believe it breaks
>> the CMD640?  The current scheme leaks transactions on the bus and *will*
>
>The CMD640 can't do 32bit config space access stuff - thats why the code
>is there to hack around it. That code needs to know or check what pci
>config mode it should have used.

Right.  If you look at the comments added to the code, the PCI APIs always
prefer direct config space access over using the PCI BIOS.  The Linux
direct access methods only perform 32 bit cycles for 32bit API calls.
The ony time Linux will use the PCIBIOS (which may do everything as
32bit accesses) is if the direct access method fails.  So, the machines
where direct access doesn't work can't be supported by the old, manual,
CMD640 code anyway.  On machines that have working direct access, using
the PCI APIs is equivalent to the old method with the added bonus that
you don't blindly attempt to perform an access type that the chipset
does not support.  This was the root cause of the "CMD640 driver performs
drive by shootings of other devices" issue.

>> Information about the SCSI mid-layer changes were posted to the SCSI list
>> and I believe CC'd to you.  If you need that information again, I'd be
>> happy to resend it.
>
>The midlayer stuff Im more than happy with

Okay.

--
Justin
