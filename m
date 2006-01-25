Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWAYASU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWAYASU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 19:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWAYASU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 19:18:20 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:15531 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750882AbWAYAST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 19:18:19 -0500
Date: Tue, 24 Jan 2006 18:13:49 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: AMD64, 4GB, mttr questions
In-reply-to: <5ywpz-49F-11@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: prakash@punnoor.de
Message-id: <43D6C2BD.50301@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5ywpz-49F-11@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash Punnoor wrote:
> I have a machine with 4GB RAM, an Athlon64 X2 and following mttr entries:
> 
> reg00: base=0x00000000 (   0MB), size=4096MB: write-back, count=1
> reg01: base=0x100000000 (4096MB), size=2048MB: write-back, count=1
> reg02: base=0x80000000 (2048MB), size=2048MB: uncachable, count=1
> 
> First of all, why is there an uncachable region? Is it the upper half of 
> memory? Or is this just a hole and the remaining 2GB are seated at 
> 0x100000000 ?

Your e820 memory map shows the first 2GB of RAM is at 0-2GB and the 
remaining 2GB is at 4-6GB, so yes there is a hole. This doesn't explain 
why all of 0-4GB is set as write-back and then the top half of it is 
also set as uncacheable. This will presumably have been set up by the 
BIOS though, I don't think the kernel does this.	

> 
> I am also wondering why the kernel doesn't propery set up write-combining 
> regions: (I noticed this on 32bit x86, as well, on various machines)

Just because there is MMIO there, does not mean it can be safely set as 
write combining. For devices that support write combining, I believe 
it's the responsibility of the driver (or in the case of a graphics 
card, X) to set this up if it wants. Generally this is only done for 
graphics cards due to the limited number of MTRR entries.

> X also comlains about this:
> 
> mtrr: type mismatch for b0000000,2000000 old: write-back new: write-combining

Sounds like X is doing something reasonable, that range shouldn't have 
been set as write-back in the first place. Presumably the fault of the 
BIOS however.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

