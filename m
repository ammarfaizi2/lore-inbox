Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWI3Qb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWI3Qb7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 12:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWI3Qb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 12:31:59 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:7889 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750999AbWI3Qb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 12:31:58 -0400
Date: Sat, 30 Sep 2006 10:30:00 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA status reports update
In-reply-to: <fa.l8JQ0qnQYteeWfINfpS73yv1OKw@ifi.uio.no>
To: Prakash Punnoor <prakash@punnoor.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>
Message-id: <451E9B88.7020009@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.qX++qRit8w9OM0g1pdrG/oO2vt0@ifi.uio.no>
 <fa.qyxVQ/280iu/YZsbUzTDjAygfL4@ifi.uio.no>
 <fa.BuZY3hsao85GkcEIgE6/7ZlG40A@ifi.uio.no>
 <fa.l8JQ0qnQYteeWfINfpS73yv1OKw@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash Punnoor wrote:
> Am Freitag 29 September 2006 12:03 schrieb Jeff Garzik:
>> Prakash Punnoor wrote:
>>> Well, how would one debug it w/o hw docs? Or is it possible to compare
>>> the patch with a working driver for another chipset?
>> Well, it is based off of the standard ADMA[1] specification, albeit with
>> modifications.  There is pdc_adma.c, which is also based off ADMA.  And
>> the author (from NVIDIA) claims that the driver worked at one time, so
>> maybe it is simply bit rot that broke the driver.
> 
> Well, I tried to hack the patch into 2.6.18 driver, but wasn't very 
> successful. It migt be also due to the case that I have a MCP51 chipset and 
> if I read the patch correctly it isn't designed  to activate ADMA on MCP51. 
> Do you know whether MCP51 knows ADMA? If not, how is NCQ to be activated on 
> MCP51? According to nvidia.com and windows user reports MCP51 does know NCQ.

The same Windows driver supports all of:

CK804SSS="NVIDIA nForce4 Serial ATA Controller"
MCP51S="NVIDIA nForce 430/410 Serial ATA Controller"
MCP55S="NVIDIA nForce 590/570/550 Serial ATA Controller"

 From looking at the patch it seems to only use the ADMA code for CK804 
only. Probably the others use the same programming interface (though who 
knows if they implemented a totally different one in the same Windows 
driver). I guess you could try hacking it to use ADMA on that controller 
and see what happens..

I have an nForce4 board and it would be nice if we could have working 
NCQ, though I haven't really played with libata before. I may experiment 
with it a bit, though - Jeff, what kernel was this patch against? It 
obviously won't apply to current -mm, that nv_host_desc structure it is 
patching is gone for one thing..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

