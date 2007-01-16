Return-Path: <linux-kernel-owner+w=401wt.eu-S932195AbXAPBv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbXAPBv1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 20:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbXAPBv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 20:51:27 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:51568 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932195AbXAPBv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 20:51:27 -0500
Message-ID: <45AC2F99.3040209@garzik.org>
Date: Mon, 15 Jan 2007 20:51:21 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: Robert Hancock <hancockr@shaw.ca>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrin?= =?ISO-8859-1?Q?k?= 
	<B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, htejun@gmail.com
Subject: Re: SATA exceptions with 2.6.20-rc5
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <45AAC039.1020808@shaw.ca> <45AAC95B.1020708@garzik.org> <45AAE635.8090308@shaw.ca> <20070115025319.GC4516@kernel.dk> <45AB84D8.3020507@garzik.org> <20070116002336.GB4067@kernel.dk>
In-Reply-To: <20070116002336.GB4067@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Jan 15 2007, Jeff Garzik wrote:
>> Jens Axboe wrote:
>>> I'd be surprised if the device would not obey the 7 second timeout rule
>>> that seems to be set in stone and not allow more dirty in-drive cache
>>> than it could flush out in approximately that time.
>> AFAIK Windows flush-cache timeout is 30 seconds, not 7 as with other 
>> commands...
> 
> Ok, 7 seconds for FLUSH_CACHE would have been nice for us too though, as
> it would pretty much guarentee lower latencies for random writes and
> write back caching. The concern is the barrier code, of course. I guess
> I should do some timings on potential worst case patterns some day. Alan
> may have done that sometime in the past, iirc.

FWIW:  According to the drive guys (Eric M, among others), FLUSH CACHE 
will "probably" be under 30 seconds, but pathological cases might even 
extend beyond that.

Definitely more than 7 seconds in less-than-pathological cases, 
unfortunately...

The SCSI layer /should/ already take this (30 second timeout) into 
account, for SYNCHRONIZE CACHE (and thus FLUSH CACHE for libata) but I'm 
too slack to check at the moment.

	Jeff



