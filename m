Return-Path: <linux-kernel-owner+w=401wt.eu-S932191AbXACXmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbXACXmu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 18:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbXACXmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 18:42:50 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:60881 "EHLO
	pd4mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191AbXACXmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 18:42:49 -0500
Date: Wed, 03 Jan 2007 17:41:29 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
In-reply-to: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no>
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: linux-kernel@vger.kernel.org
Message-id: <459C3F29.2@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Anton Mitterer wrote:
> Hi.
> 
> Perhaps some of you have read my older two threads:
> http://marc.theaimsgroup.com/?t=116312440000001&r=1&w=2 and the even
> older http://marc.theaimsgroup.com/?t=116291314500001&r=1&w=2
> 
> The issue was basically the following:
> I found a severe bug mainly by fortune because it occurs very rarely.
> My test looks like the following: I have about 30GB of testing data on
> my harddisk,... I repeat verifying sha512 sums on these files and check
> if errors occur.
> One test pass verifies the 30GB 50 times,... about one to four
> differences are found in each pass.
> 
> The corrupted data is not one single completely wrong block of data or
> so,.. but if you look at the area of the file where differences are
> found,.. than some bytes are ok,.. some are wrong,.. and so on (seems to
> be randomly).
> 
> Also, there seems to be no event that triggers the corruption,.. it
> seems to be randomly, too.
> 
> It is really definitely not a harware issue (see my old threads my
> emails to Tyan/Hitachi and my "workaround" below. My system isn't
> overclocked.
> 
> 
> 
> My System:
> Mainboard: Tyan S2895
> Chipsets: Nvidia nforce professional 2200 and 2050 and AMD 8131
> CPU: 2x DualCore Opterons model 275
> RAM: 4GB Kingston Registered/ECC
> Diskdrives: IBM/Hitachi: 1 PATA, 2 SATA
> 
> 
> The data corruption error occurs on all drives.
> 
> 
> You might have a look at the emails between me and Tyan and Hitachi,..
> they contain probalby lots of valuable information (especially my
> different tests).
> 
> 
> 
> Some days ago,.. an engineer of Tyan suggested me to boot the kernel
> with mem=3072M.
> When doing this,.. the issue did not occur (I don't want to say it was
> solved. Why? See my last emails to Tyan!)
> Then he suggested me to disable the memory hole mapping in the BIOS,...
> When doing so,.. the error doesn't occur, too.
> But I loose about 2GB RAM,.. and,.. more important,.. I cant believe
> that this is responsible for the whole issue. I don't consider it a
> solution but more a poor workaround which perhaps only by fortune solves
> the issue (Why? See my last eMails to Tyan ;) )
> 
> 
> 
> So I'd like to ask you if you perhaps could read the current information
> in this and previous mails,.. and tell me your opinions.
> It is very likely that a large number of users suffer from this error
> (namely all Nvidia chipset users) but only few (there are some,.. I
> found most of them in the Nvidia forums,.. and they have exactly the
> same issue) identify this as an error because it's so rare.
> 
> Perhaps someone have an idea why disabling the memhole mapping solves
> it. I've always thought that memhole mapping just moves some address
> space to higher addreses to avoid the conflict between address space for
> PCI devices and address space for pyhsical memory.
> But this should be just a simple addition and not solve this obviously
> complex error.

If this is related to some problem with using the GART IOMMU with memory 
hole remapping enabled, then 2.6.20-rc kernels may avoid this problem on 
nForce4 CK804/MCP04 chipsets as far as transfers to/from the SATA 
controller are concerned as the sata_nv driver now supports 64-bit DMA 
on these chipsets and so no longer requires the IOMMU.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

