Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVFUB3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVFUB3q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 21:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVFUADD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:03:03 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:57767 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S261819AbVFTXjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:39:39 -0400
Message-ID: <42B753BA.8040501@pantasys.com>
Date: Mon, 20 Jun 2005 16:39:38 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: sean.bruno@dsl-only.net, koch@esa.informatik.tu-darmstadt.de,
       torvalds@osdl.org, benh@kernel.crashing.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
References: <Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org> <20050610184815.A13999@jurassic.park.msu.ru> <200506102247.30842.koch@esa.informatik.tu-darmstadt.de> <1118762382.9161.3.camel@home-lap> <20050616142039.GF21542@erebor.esa.informatik.tu-darmstadt.de> <42B1B4D3.3060600@pantasys.com> <1118955201.10529.10.camel@home-lap> <42B1E9B2.30504@pantasys.com> <20050617135400.A32290@jurassic.park.msu.ru> <20050617093410.24a58d56.peter@pantasys.com> <20050618114531.A2523@jurassic.park.msu.ru>
In-Reply-To: <20050618114531.A2523@jurassic.park.msu.ru>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jun 2005 23:36:58.0359 (UTC) FILETIME=[F3401070:01C575F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good news!

the latest 2.6.12 actually works properly. when i load the device driver 
the regions are no longer disabled and both gpus work correctly. I'm 
still a little confused as to why the first value for the BARs seem 
nonsensical...

It looks like 2.6.12 is able to relocate the BAR regions for the GPUs 
(see dump below)..

peter

--
PCI: Cannot allocate resource region 0 of device 0000:81:00.0
PCI: Cannot allocate resource region 1 of device 0000:81:00.0
PCI: Cannot allocate resource region 2 of device 0000:81:00.0
PCI: Cannot allocate resource region 0 of device 0000:41:00.0
PCI: Cannot allocate resource region 1 of device 0000:41:00.0
PCI: Cannot allocate resource region 2 of device 0000:41:00.0
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 90000000 size 65536 KB
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:08' and the driver 'system'
pnp: match found with the PnP device '00:09' and the driver 'system'
pnp: match found with the PnP device '00:0c' and the driver 'system'
pnp: 00:0c: ioport range 0xa00-0xa7f has been reserved
pnp: match found with the PnP device '00:0d' and the driver 'system'
pnp: match found with the PnP device '00:0e' and the driver 'system'
   got res [bc000000:bcffffff] bus [bc000000:bcffffff] flags 200 for BAR 
0 of 0000:81:00.0
PCI: moved device 0000:81:00.0 resource 0 (200) to bc000000
   got res [c0000000:cfffffff] bus [c0000000:cfffffff] flags 1208 for 
BAR 1 of 0000:81:00.0
PCI: moved device 0000:81:00.0 resource 1 (1208) to c0000000
   got res [bd000000:bdffffff] bus [bd000000:bdffffff] flags 200 for BAR 
2 of 0000:81:00.0
PCI: moved device 0000:81:00.0 resource 2 (200) to bd000000
   got res [98000000:98ffffff] bus [98000000:98ffffff] flags 200 for BAR 
0 of 0000:41:00.0
PCI: moved device 0000:41:00.0 resource 0 (200) to 98000000
   got res [a0000000:afffffff] bus [a0000000:afffffff] flags 1208 for 
BAR 1 of 0000:41:00.0
PCI: moved device 0000:41:00.0 resource 1 (1208) to a0000000
   got res [99000000:99ffffff] bus [99000000:99ffffff] flags 200 for BAR 
2 of 0000:41:00.0
PCI: moved device 0000:41:00.0 resource 2 (200) to 99000000

