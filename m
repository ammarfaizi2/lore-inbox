Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWFPIbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWFPIbW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 04:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWFPIbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 04:31:22 -0400
Received: from cantor2.suse.de ([195.135.220.15]:9131 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751152AbWFPIbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 04:31:21 -0400
From: Andi Kleen <ak@suse.de>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: The "Out of IOMMU space" error and the "Please enable the IOMMU option" option
Date: Fri, 16 Jun 2006 10:31:16 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <a0623094bc0b77aaeba9a@[129.98.90.227]>
In-Reply-To: <a0623094bc0b77aaeba9a@[129.98.90.227]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606161031.16554.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 June 2006 23:17, Maurice Volaski wrote:
> Occasionally,  we get errors like these:
> 
> Jun  9 00:56:35 [kernel] [18020.416620] PCI-DMA: Out of IOMMU space 
> for 12288 bytes at device 0000:03:01.0

 
> and it looks like it might have something to do with these messages 
> (after updating and setting BIOS as below):
> 
> Jun 15 16:38:54 [kernel] [    0.000000] Checking aperture...
> Jun 15 16:38:54 [kernel] [    0.000000] CPU 0: aperture @ 0 size 256 MB
> Jun 15 16:38:54 [kernel] [    0.000000] No AGP bridge found
> Jun 15 16:38:54 [kernel] [    0.000000] Your BIOS doesn't leave a 
> aperture memory hole
> Jun 15 16:38:54 [kernel] [    0.000000] Please enable the IOMMU 
> option in the BIOS setup
> Jun 15 16:38:54 [kernel] [    0.000000] This costs you 64 MB of RAM
> Jun 15 16:38:54 [kernel] [    0.000000] Mapping aperture over 65536 
> KB of RAM @ 8000000
> 
> The box is a dual Opteron 250 with an Arima HDAMA Rev. D motherboard.

Not directly - the kernel will create a fallback aperture if it can't
find one provided by the BIOS. The default is 64MB, but it can be
enlarged with iommu=memaper=4 

There was also a bug that might have caused this over longer uptimes. 
If you still see  it with latest 2.6.16.stable (19 or so). 

If it still happens with those two changes then something is likely
leaking mappings or your have a extreme workload that needs
a lot of mappings.


> First, am I correct to assume that I'm not getting the 256 MB?

Yes you'll get 64MB fallback likely.

> 
> Second, is the the case the BIOS is lying?

Probably yes.
 
-Andi
