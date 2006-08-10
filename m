Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWHJVJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWHJVJF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 17:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWHJVJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 17:09:04 -0400
Received: from poesci.dolphinics.no ([193.71.152.8]:32445 "EHLO
	poesci.dolphinics.no") by vger.kernel.org with ESMTP
	id S932209AbWHJVJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 17:09:03 -0400
Message-ID: <44DBA06E.40104@dolphinics.no>
Date: Thu, 10 Aug 2006 23:09:02 +0200
From: Simen Thoresen <simentt@dolphinics.no>
Organization: Dolphin ICS
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: gmu 2k6 <gmu2006@gmail.com>
Cc: Joel Jaeggli <joelja@uoregon.edu>, linux-kernel@vger.kernel.org
Subject: Re: Only 3.2G ram out of 4G seen in an i386 box
References: <20060808101504.GJ2152@stingr.net>	 <MDEHLPKNGKAHNMBLJOLKKEDCNKAB.davids@webmaster.com>	 <f96157c40608082351j301efa57n412284f8d28124ef@mail.gmail.com>	 <20060809074815.bec7f32c.joelja@uoregon.edu> <f96157c40608090754m1f10e0f2h5fbf3b256d2e55e1@mail.gmail.com>
In-Reply-To: <f96157c40608090754m1f10e0f2h5fbf3b256d2e55e1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gmu 2k6 wrote:
...
> so what does it mean that one of Xeons here shows me the full 4GiB as
> total physical memory via `free`?
> 
> btw, the box I'm getting will have the 975X chip and include 4GiB RAM
> and if I understood the problem correctly even with 3GiB there will be
> some memory lost to mapping-issues besides the HI/LO mem
> kernel-reserving issue.
> this is what I get on ia32 P4 with 3GiB
>             total       used       free     shared    buffers     cached
> Mem:       3116108    2608196     507912          0     246652    2039708
> and this is what I get on ia32 Xeon with 4GiB
>             total       used       free     shared    buffers     cached
> Mem:       4087660     268828    3818832          0      57168     103568

Hi Gmu,

This is a bit divergent from the discussion, but will hopefully provide some 
background.

The hardware my employer manufactures asks the BIOS to reserve several 
largeish ranges (16M and 16M to 512M), and it's been used in various HPC 
projects where machines typically have a lot of memory installed.

 From my experience, most pre 750x-P4-Xeon chipsets did not support any kind 
of memory remapping, so often the top 0.5-1.5G of ram would be 'lost'. Great 
fun.
Since then, this functionality has started appearing, more or less randomly. 
I believe it should be present on all later 75xx chipsets (probably the Core 
2 Xeon chipsets as well), but implementation depends on the BIOS (ie the 
motherboard vendors), and their grasp of what people do with their boards is 
often quite limited.

On the P4 boards (and again the Core 2 boards as well), this is probably 
even less ordered as they are 'desktop' boards rather than the more costly 
'server' boards.

I'm pretty sure the Athlon64 and Opteron CPUs should support this, but they 
too depend on BIOS functionality to rearrange the memory tables.

Just out of interest - what chipset does your Xeon system use?

Yours,
-S

-- 
Simen Thoresen, Dolphin ICS
