Return-Path: <linux-kernel-owner+w=401wt.eu-S1751439AbXAPDAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbXAPDAe (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 22:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbXAPDAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 22:00:34 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:16021 "EHLO
	pd3mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbXAPDAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 22:00:33 -0500
Date: Mon, 15 Jan 2007 21:00:40 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions with 2.6.20-rc5
In-reply-to: <20070116013505.GA5846@atjola.homenet>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>, jeff@garzik.org,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com
Message-id: <45AC3FD8.7060209@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no>
 <45AAC039.1020808@shaw.ca> <20070115211723.GA3750@atjola.homenet>
 <20070115234650.GA2124@atjola.homenet> <45AC1DA3.5040104@shaw.ca>
 <20070116013505.GA5846@atjola.homenet>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Björn Steinbrink wrote:
>> It should be correct the way it is - that check is trying to prevent 
>> ATAPI commands from using DMA until the slave_config function has been 
>> called to set up the DMA parameters properly. When the 
>> NV_ADMA_ATAPI_SETUP_COMPLETE flag is not set, this returns 1 which 
>> disallows DMA transfers. Unless you were using an ATAPI (i.e. CD/DVD) 
>> device on the channel this wouldn't affect you anyway.
> 
> I wondered about it, because the flag is cleared when adma_enabled is 1,
> which seems to be consistent with everything but nv_adma_check_atapi_dma.

When ADMA is enabled we can't use ATAPI at all (or so says NVidia 
anyway), so it has to be disabled when an ATAPI device is detected in 
slave_config. Since doing that implies using the legacy BMDMA engine 
with its greater restrictions, this is why we need to prevent DMA 
transfers from being attempted until those restrictions have been set 
properly. (Otherwise, the libata core will try to use PACKET commands on 
an ATAPI device with DMA enabled before slave_config is even called.)

> Thus I thought that nv_adma_check_atapi_dma might be wrong, but maybe
> setting/clearing the flag is wrong instead? *feels lost*

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


