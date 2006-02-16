Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030587AbWBPMdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030587AbWBPMdt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 07:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbWBPMdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 07:33:49 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:40710 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1030587AbWBPMds convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 07:33:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43F3AEAA.4080309@cfl.rr.com>
X-OriginalArrivalTime: 16 Feb 2006 12:33:39.0958 (UTC) FILETIME=[371BC160:01C632F5]
Content-class: urn:content-classes:message
Subject: Re: RFC: disk geometry via sysfs
Date: Thu, 16 Feb 2006 07:33:38 -0500
Message-ID: <Pine.LNX.4.61.0602160728100.20319@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RFC: disk geometry via sysfs
thread-index: AcYy9Tclz4GMvX9IT5ieTXcKmMGRCQ==
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com> <43F2E8BA.90001@bfh.ch> <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <1140019615.14831.22.camel@localhost.localdomain> <43F354E9.2020900@cfl.rr.com> <1140024754.14831.31.camel@localhost.localdomain> <43F3764C.8080503@cfl.rr.com> <Pine.LNX.4.61.0602151411130.9546@chaos.analogic.com> <43F39500.8060008@cfl.rr.com> <Pine.LNX.4.61.0602151606540.10924@chaos.analogic.com> <43F3AEAA.4080309@cfl.rr.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Seewer Philippe" <philippe.seewer@bfh.ch>,
       "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Feb 2006, Phillip Susi wrote:

> linux-os (Dick Johnson) wrote:
>> Heads start at 0. Sectors start at 1. Cylinders start at 0.
>> A "lower head" than allowed would be 0xff so the BIOS wouldn't
>> know it was "lower". The BIOS doesn't look at the MBR for
>> normal read/write access! Only while booting does it
>> read the first sector of the master boot record (MBR) into
>> the appropriate physical place (0x7c00). Then it checks to see
>> if there is an 0xaa55 as the last word in the sector. If so,
>> it executes code starting at offset zero. Modern BIOS don't
>> even check the "boot flag" because it may be wrong, preventing
>> a boot.
>>
>
> I'm talking about the geometry of the disk.  If the disk has 16 sectors
> and 8 heads, then the maximum value allowed for any valid address is 16
> in the sector field and 7 in the heads field.  This influences the
> translation to/from LBA.  A sector with LBA of 1234 would have a CHS
> address using this geometry of 9/5/3.  If the disk reports a geometry of
> x/8/16 but the bios is using a geometry of x/255/63, then when you pass
> 9/5/3 to int 13 it will fetch LBA 144902 which is clearly not going to
> give you what you wanted.
>

Wrong! The disk gets an OFFSET!  It doesn't care how that OFFSET
is obtained. That OFFSET is the sum of some variables. Some start
at 0 and some start at 1. The BIOS takes these PHONY things, without
checking to see if they "fit" in some pre-conceived notion of
"geometery" and sums them all up to make an OFFSET. The C/H/S
stuff started and ENDED with the ST-506 interface.  PERIOD.

[Snipped rest]


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
