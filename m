Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932744AbVINMNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744AbVINMNc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 08:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbVINMNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 08:13:32 -0400
Received: from magic.adaptec.com ([216.52.22.17]:58261 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932740AbVINMNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 08:13:31 -0400
Message-ID: <432813E3.5070308@adaptec.com>
Date: Wed, 14 Sep 2005 08:13:23 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mansfield <patmans@us.ibm.com>
CC: Matthew Wilcox <matthew@wil.cx>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Douglas Gilbert <dougg@torque.net>,
       Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net> <1126537041.4825.28.camel@mulgrave> <20050912164548.GB11455@us.ibm.com> <1126545680.4825.40.camel@mulgrave> <20050912184629.GA13489@us.ibm.com> <1126639342.4809.53.camel@mulgrave> <4327354E.7090409@adaptec.com> <20050913203611.GH32395@parisc-linux.org> <43273E6C.9050807@adaptec.com> <20050913222519.GA1308@us.ibm.com>
In-Reply-To: <20050913222519.GA1308@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Sep 2005 12:13:29.0318 (UTC) FILETIME=[B77B8060:01C5B925]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/05 18:25, Patrick Mansfield wrote:
> On Tue, Sep 13, 2005 at 05:02:36PM -0400, Luben Tuikov wrote:
> 
>>On 09/13/05 16:36, Matthew Wilcox wrote:
>>
>>>On Tue, Sep 13, 2005 at 04:23:42PM -0400, Luben Tuikov wrote:
>>>
>>>
>>>>A SCSI LUN is not "u64 lun", it has never been and it will
>>>>never be.
>>>>
>>>>A SCSI LUN is "u8 LUN[8]" -- it is this from the Application
>>>>Layer down to the _transport layer_ (if you cared to look at
>>>>_any_ LL transport).
> 
> 
> Not all HBA drivers implement a mapping to a SCSI transport, we have
> raid drivers and even an FC driver that has its own lun definition that
> does not fit any SAM or SCSI spec.

Us too.  Especially RAID.

> I think the only HBA's today that can handle an 8 byte lun are lpfc and
> iscsi (plus new SAS ones).
> 
> So, we can't have one "LUN" that fits all, and it makes no sense to call
> it a LUN when it is really a wtf.

"u64 lun" is a lot worse than "u8 LUN[8]".  you can work with
the latter but the former raises questions like
 "How was this translated from the "u8 LUN[8]" which I use
  in the application client and in the transport?"
Etc.

Then, if your lun is 16 bits, there is no question where it is
in "u8 LUN[8]" -- SAM is _clear_ on that.

Second, as I said before a Logical Unit Number _is_ "u8 LUN[8]",
there is _no_ MSB or LSB, and there will never be.  Thus, you cannot
stuff it into "u64".

Yes, we _can_ have _one_ LUN that fits all, _because_
we would copy it _as_ is from the LLDD, be it 16 bits or
32 bits or whatever, in SCSI order format: Big endian.

Again, SAM is clear on that.

	Luben


