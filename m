Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWBOTXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWBOTXo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 14:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWBOTXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 14:23:44 -0500
Received: from spirit.analogic.com ([204.178.40.4]:58377 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932171AbWBOTXn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 14:23:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43F3764C.8080503@cfl.rr.com>
X-OriginalArrivalTime: 15 Feb 2006 19:23:40.0218 (UTC) FILETIME=[5397C9A0:01C63265]
Content-class: urn:content-classes:message
Subject: Re: RFC: disk geometry via sysfs
Date: Wed, 15 Feb 2006 14:23:39 -0500
Message-ID: <Pine.LNX.4.61.0602151411130.9546@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RFC: disk geometry via sysfs
thread-index: AcYyZVOhp90wFJF8QgqBRbiDJb0anQ==
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com> <43F2E8BA.90001@bfh.ch> <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <1140019615.14831.22.camel@localhost.localdomain> <43F354E9.2020900@cfl.rr.com> <1140024754.14831.31.camel@localhost.localdomain> <43F3764C.8080503@cfl.rr.com>
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

> Alan Cox wrote:
>> On Mer, 2006-02-15 at 11:20 -0500, Phillip Susi wrote:
>>> Why do you say the partitioning tool needs to know the disk reported
>>> C/H/S?  The value stored in the MBR must match the bios reported values,
>>> not the disk reported ones, so why does the partitioner care about what
>>> the disk reports?
>>
>> You answered that in asking the question.  "The value stored in the MBR
>> must match the ...". What if the MBR has not yet been written ?
>>
>
> The value in the MBR must match the _bios_ value, not the value that the
> disk reports in its inquiry command ( which often will be different ).
> When creating a new MBR you need to get the geometry from the bios, not
> the drive itself.
>
>> (Also btw its *should*...) most modern OS's will take a sane MBR
>> geometry and trust it over BIOS defaults.
>>
>
> If the value in the MBR differs from the geometry that the bios reports,
> then boot code using int 13 in chs mode will fail because it won't be
> using the geometry that the bios expects.
>

If the disc is a modern disk, and the BIOS is modern as well,
it won't care. For instance, if we attempt to seek to cylinder
10, sector 10, and there are only 9 sectors, then the supplied
head number is incremented, the sector to be read becomes 1
(dumb ones based), and everything is fine. If the head number
can't be incremented, it wraps to 0. Problems occur if the BIOS
has been set to "physical" mode for access. In this mode, the
CHS are absolute and "you can't get there from here." In the
physical mode, you can't have more than 1024 cylinders because
they need to fit into 10 bits.

As long as the BIOS is set for LBA, the boot sequence should not
care.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
