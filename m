Return-Path: <linux-kernel-owner+w=401wt.eu-S1030307AbXAKMeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbXAKMeS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 07:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbXAKMeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 07:34:18 -0500
Received: from spirit.analogic.com ([204.178.40.4]:4792 "EHLO
	spirit.analogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030307AbXAKMeR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 07:34:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 11 Jan 2007 12:34:05.0915 (UTC) FILETIME=[C87C3AB0:01C7357C]
Content-class: urn:content-classes:message
Subject: Re: O_DIRECT question
Date: Thu, 11 Jan 2007 07:34:00 -0500
Message-ID: <Pine.LNX.4.61.0701110724040.19233@chaos.analogic.com>
In-Reply-To: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: O_DIRECT question
Thread-Index: Acc1fMiPVFyFTizbRPaAXwTuk/kVtw==
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Aubrey" <aubreylee@gmail.com>
Cc: "Hua Zhong" <hzhong@gmail.com>, "Hugh Dickins" <hugh@veritas.com>,
       <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
       <kenneth.w.chen@intel.com>, <akpm@osdl.org>, <torvalds@osdl.org>,
       <mjt@tls.msk.ru>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Jan 2007, Aubrey wrote:

> Hi all,
>
> Opening file with O_DIRECT flag can do the un-buffered read/write access.
> So if I need un-buffered access, I have to change all of my
> applications to add this flag. What's more, Some scripts like "cp
> oldfile newfile" still use pagecache and buffer.
> Now, my question is, is there a existing way to mount a filesystem
> with O_DIRECT flag? so that I don't need to change anything in my
> system. If there is no option so far, What is the right way to achieve
> my purpose?
>
> Thanks a lot.
> -Aubrey
> -

I don't think O_DIRECT ever did what a lot of folks expect, i.e.,
write this buffer of data to the physical device _now_. All I/O
ends up being buffered. The `man` page states that the I/O will
be synchronous, that at the conclusion of the call, data will have
been transferred. However, the data written probably will not be
in the physical device, perhaps only in a DMA-able buffer with
a promise to get it to the SCSI device, soon.

Maybe you need to say why you want to use O_DIRECT with its terrible
performance?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
