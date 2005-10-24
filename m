Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbVJXAl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbVJXAl4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 20:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbVJXAl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 20:41:56 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:51538 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750847AbVJXAlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 20:41:55 -0400
Date: Sun, 23 Oct 2005 18:40:06 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.14-rc5 e1000 and page allocation failures.. still
In-reply-to: <50tDw-1FH-5@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <435C2D66.6030708@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
References: <50tDw-1FH-5@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bäckstrand wrote:
> Im seeing a massive amount of page allocation failures with 2.6.14-rc5, 
> and also earlier kernels, see "E1000 - page allocation failure - saga 
> continues :(". Machine is a 1Ghz Athlon with 256MB RAM. Attached is 
> example dmesg output. The stack traces come in many variants. Killing 
> processes using RAM only seems to help temporarily. Ive also tried 
> setting vm.min_free_kbytes=16384, which used to work pretty well, but 
> this does not help (atleast not in the state the machine is currently 
> in, without rebooting).
> 
> free currently gives:
> 
>              total       used       free     shared    buffers     cached
> Mem:        256520     239128      17392          0       5372      67500
> -/+ buffers/cache:     166256      90264
> Swap:       506036      21248     484788
> 
> 
> I havent yet tried rebooting and using the vm.min_free_kbytes=16384 from 
> scratch, but I think something with the default for this is wrong if it 
> results in this many page allocation errors. The machine is serving 
> files from an encrypted partition with reiserfs on it, and I obivously 
> use the e1000 driver.
> 
> ---
> John Bäckstrand
> 
> 
> ------------------------------------------------------------------------
> 
> [149649.847890] kcryptd/0: page allocation failure. order:3, mode:0x20

..

> [149649.849933] Free pages:       16148kB (0kB HighMem)

It looks like you have enough memory free - the problem is that the 
driver is allocating a block of memory with order 3, which is 8 pages. 
Quite likely there are not enough contiguous free pages to satisfy that.

That's an awful big buffer size for a packet - I assume you're using 
jumbo frames or something? Ideally the driver and hardware should be 
able to allocate a buffer for those packets in multiple chunks, but I 
have no idea if this is possible.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

