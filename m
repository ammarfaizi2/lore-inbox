Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269135AbUJESVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269135AbUJESVk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 14:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269134AbUJESVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 14:21:39 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:62442 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269132AbUJESV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 14:21:26 -0400
Message-ID: <4162E5F0.30104@sgi.com>
Date: Tue, 05 Oct 2004 13:20:32 -0500
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C647@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0221C647@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony wrote:
> I'm ok with the delete/add of most of the SGI
> specific files (maybe it still isn't perfect yet,
> but it may be close enough to take it, and then
> clean up with some small patches).
> 
> But you seem to be touching some files outside of pure SGI
> stuff.  These two are a bit of a concern:
> 
>   include/asm-ia64/io.h


>   arch/ia64/pci/pci.c
> 

Most of this is Lindent changes. The only mod is we need pci_root_ops to be non-static.


> These others are outside of my area (well I *might* push
> the drivers that are only used by SGI ... but hotplug
> and qla1280 are definitely not mine).  So they need to be
> split out into separate patches.
> 

As a general comment, the changes to these files are because of mods in the reorg code - so they are 
needed for this base but not in the older code. So, in my mind, it is a package - or should be taken 
as a whole. I can break them out, but I think they need to go together.


>   drivers/char/mmtimer.c

This is Jesse's code. We made an include file change. Is this OK Jesse ?


>   drivers/char/snsc.c

This is Greg Howard's code - he's reviewed and approved the mod. Should I add him as a signed-off ?

>   drivers/ide/pci/sgiioc4.c

More Lindent mods. We took out the endian code - not needed anymore.


>   drivers/pci/hotplug/Kconfig

Took out SGI PCI Hotplug. Since there isn't any code behind it - we will add it back in when we 
submit the code for it.

>   drivers/scsi/qla1280.c

Again more Lindent mods. Took out the vchan definition hack.

>   drivers/serial/sn_console.c
> 

This is my driver.
