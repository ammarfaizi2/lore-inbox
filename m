Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262307AbVCIBzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbVCIBzM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 20:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbVCIBwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 20:52:36 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:17294 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262328AbVCIBpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 20:45:51 -0500
Date: Tue, 08 Mar 2005 19:45:35 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: kernel mmap() and friends.
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <422E553F.7040608@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:

 > If one uses x = __get_dma_pages(GFP_KERNEL, nr), finds the physical
 > address with b = virt_to_bus(x), then attempts to mmap(,,b,,,) the result
 > _does_not_fail_, yet the user ends up with memory ...somewhere....
 > that is R/W able and WRONG.


I don't think virt_to_bus is the correct function to be using for this 
translation (or pretty much anything, these days). What is this memory 
that you are attempting to do an mmap on, and where is this code going? 
Unless this is an ISA device and you need physical memory for DMA, 
__get_dma_pages is not correct either.

 >
 > Yet, if the code executes SetPageReserved(virt_to_page(x)), the
 > mmap() works and the user gets the CORRECT page(s).
 >
 > I think that if mmap() needs a physical buffer to be reserved
 > then that's fine. However, silently returning some different
 > buffer is a BUG.
 >
 > Is anyone aware of this BUG? Does anybody else care?


The kernel isn't responsible for checking that the memory ranges you 
attempt to remap are what you intended - if you get this wrong, things 
can blow up, that's just the way it is.

I would suggest following some similar driver/code in the kernel as an 
example if possible..

-- 
Robert Hancock      Saskatoon, SK, Canada
Home Page: http://www.roberthancock.com/



