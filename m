Return-Path: <linux-kernel-owner+w=401wt.eu-S932154AbXAPAf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbXAPAf5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 19:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbXAPAf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 19:35:57 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:20013 "EHLO
	pd4mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932154AbXAPAf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 19:35:56 -0500
Date: Mon, 15 Jan 2007 18:34:43 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions with 2.6.20-rc5
In-reply-to: <20070115234650.GA2124@atjola.homenet>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>, jeff@garzik.org,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com
Message-id: <45AC1DA3.5040104@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no>
 <45AAC039.1020808@shaw.ca> <20070115211723.GA3750@atjola.homenet>
 <20070115234650.GA2124@atjola.homenet>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Björn Steinbrink wrote:
>> My latest bisection attempt actually led to your sata_nv ADMA commit. [1]
>> I've now backed out that patch from 2.6.20-rc5 and have my stress test
>> running for 20 minutes now ("record" for a bad kernel surviving that
>> test is about 40 minutes IIRC). I'll keep it running for at least 2 more
>> hours.
> 
> Yep, that one seems to be guilty. 2.6.20-rc5 with that commit backed out
> survived about 3 hours of testing, while the average was around 5
> minutes for a failure, sometimes even before I could log in.
> I took a look at the patch, but I can't really tell anything.
> nv_adma_check_atapi_dma somehow looks like it should not negate its
> return value, so that it returns 0 (atapi dma available) when
> adma_enable was 1. But I'm not exactly confident about that either ;)
> Will it hurt if I try to remove the negation?

It should be correct the way it is - that check is trying to prevent 
ATAPI commands from using DMA until the slave_config function has been 
called to set up the DMA parameters properly. When the 
NV_ADMA_ATAPI_SETUP_COMPLETE flag is not set, this returns 1 which 
disallows DMA transfers. Unless you were using an ATAPI (i.e. CD/DVD) 
device on the channel this wouldn't affect you anyway.

I'll try your stress test when I get a chance, but I doubt I'll run into 
the same problem and I haven't seen any similar reports. Perhaps it's 
some kind of wierd timing issue or incompatibility between the 
controller and that drive when running in ADMA mode? I seem to remember 
various reports of issues with certain Maxtor drives and some nForce 
SATA controllers under Windows at least..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

