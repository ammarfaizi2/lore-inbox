Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUF2Uzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUF2Uzl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 16:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266038AbUF2Uzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 16:55:41 -0400
Received: from magic.adaptec.com ([216.52.22.17]:33426 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S266034AbUF2Uz3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 16:55:29 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PATCH: Further aacraid work
Date: Tue, 29 Jun 2004 16:55:27 -0400
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189FF1D6EE@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH: Further aacraid work
Thread-Index: AcReFovPB0OMgsBzS2mB6ACKlbGfvgAAIrYw
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Byron Stanoszek" <gandalf@winds.org>
Cc: "Mark Haverkamp" <markh@osdl.org>, "Alan Cox" <alan@redhat.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-scsi" <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oooo, good!

The Adapter has declared itself `dead' (maybe for reasons other than a
controlled blinkLED situation). Effectively a crash or complete loss of
communications with the Adapter. Last time I've seen this happened it
was a bad power supply.

Contact technical support to have them narrow down the actual cause of
adapter failure ... I don't know where the F/W updates are held on the
Dell Site.

Sincerely -- Mark Salyzyn

-----Original Message-----
From: Byron Stanoszek [mailto:gandalf@winds.org] 
Sent: Tuesday, June 29, 2004 4:21 PM
To: Salyzyn, Mark
Cc: Mark Haverkamp; Alan Cox; linux-kernel; linux-scsi
Subject: RE: PATCH: Further aacraid work

On Tue, 29 Jun 2004, Salyzyn, Mark wrote:

> Although I am gratified that 1.1.5-2345 works, and works well (*many*
> performance improvements have occurred in this driver, but some of
those
> have reached Alan's patch), I am at a loss because I was sure that the
> lockup was associated with commands taking longer than 60 seconds to
> complete (a 'can happen' with a complicated RAID card with multiple
> targets, that unfortunately gives the SCSI layer and especially ext3
> some headaches). The workaround in the reset handler is to let the
> commands quiesce to give the Firmware some breathing space to respond
to
> the test unit ready command that is issued to the target immediately
> following return from the reset handler.
>
> This not solving the problem has the implication, as Alan had noted,
> that this could be an issue with the adapter itself locking up or
going
> unresponsive under load. Both reports, this one and "PERC 3/Di broken
> 2.6.6-mm5 -> 2.6.7-rc1-mm" now smell of some subtle problems creeping
> in.

Turns out I spoke too soon. I repeated the rsync and logged this
information
from the serial console:

aacraid: Host adapter reset request. SCSI hang ?
aacraid: Host adapter appears dead -3
SCSI error : <1 0 0 0> return code = 0x6000000
end_request: I/O error, dev sda, sector 8079007
Buffer I/O error on device sda1, logical block 1009868
lost page write due to I/O error on sda1
scsi1 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 1009869
lost page write due to I/O error on sda1
  ...etc
Buffer I/O error on device sda1, logical block 1009877
lost page write due to I/O error on sda1
SCSI error : <1 0 0 0> return code = 0x6000000
end_request: I/O error, dev sda, sector 8079159
scsi1 (0:0): rejecting I/O to offline device
  ...etc


FYI, I have another [production] server sitting next to this one running
aacraid and so far it hasn't had any problems. It's a PowerEdge 2450,
unsure as
to which PercRaid device it has. So now I'm comparing two systems:

Production: PowerEdge 2450, aacraid driver (1.1.2-lk1), PERCRAID Mirror,
Unknown HW
   AAC0: kernel 2.1.4 build 2951
   AAC0: monitor 2.1.4 build 2951
   AAC0: bios 2.1.0 build 2951
   AAC0: serial 73840ad0fafaf001

and

Development: PowerEdge 2400, aacraid driver (1.1-5[2345]), PERC RAID5,
Perc 2/Si
   AAC0: kernel 2.1-3 build 2939
   AAC0: monitor 2.1-3 build 2939
   AAC0: bios 2.1-3 build 2939
   AAC0: serial 58801d0

Thing I noticed is that the firmware build on my Development server (the
one
that's crashing) is older. Where can I find a firmware upgrade? I've
been
scouring Dell's site the last 20 minutes and all I can find are Linux
drivers.

> Can we get some additional tests on this?
>
> 1) Does this problem occur on a single CPU (Hyperthreading disabled
> too)? I am assuming some locking issues appeared, mainly because of
some
> restructuring in that code.

I'm going to run the above test right now and let you know how it turns
out.

Just for some history, I've been running 2.4 kernels on this machine for
2
years and haven't had a problem with the aacraid driver. Also, the
default
Fedora Core 2 install I had on it yesterday seems to also work
flawlessly too,
and it's a 2.6.5-smp system.

  -Byron

--
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com
