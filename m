Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWFSUI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWFSUI6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWFSUI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:08:58 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:39091 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S964876AbWFSUI5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:08:57 -0400
Mime-Version: 1.0
Message-Id: <a0623095ec0b8e87b768d@[129.98.90.227]>
In-Reply-To: <200606161031.16554.ak@suse.de>
References: <a0623094bc0b77aaeba9a@[129.98.90.227]>
 <200606161031.16554.ak@suse.de>
Date: Mon, 19 Jun 2006 16:09:02 -0400
To: Andi Kleen <ak@suse.de>
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: The "Out of IOMMU space" error and the "Please enable the
 IOMMU option" option
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.16.20 and iommu=memaper=4,

Jun 19 15:20:31 [kernel] [  103.697664] PCI-DMA: Disabling AGP.
Jun 19 15:20:31 [kernel] [  103.698226] PCI-DMA: using GART IOMMU.
Jun 19 15:20:31 [kernel] [  103.698341] PCI-DMA: Reserving 512MB of 
IOMMU area in the AGP aperture

I'm not sure why it tells me it's disabling AGP, but otherwise it looks good.

>On Thursday 15 June 2006 23:17, Maurice Volaski wrote:
>>  Occasionally,  we get errors like these:
>>
>>  Jun  9 00:56:35 [kernel] [18020.416620] PCI-DMA: Out of IOMMU space
>>  for 12288 bytes at device 0000:03:01.0
>
>
>>  and it looks like it might have something to do with these messages
>>  (after updating and setting BIOS as below):
>>
>>  Jun 15 16:38:54 [kernel] [    0.000000] Checking aperture...
>>  Jun 15 16:38:54 [kernel] [    0.000000] CPU 0: aperture @ 0 size 256 MB
>>  Jun 15 16:38:54 [kernel] [    0.000000] No AGP bridge found
>>  Jun 15 16:38:54 [kernel] [    0.000000] Your BIOS doesn't leave a
>>  aperture memory hole
>>  Jun 15 16:38:54 [kernel] [    0.000000] Please enable the IOMMU
>>  option in the BIOS setup
>>  Jun 15 16:38:54 [kernel] [    0.000000] This costs you 64 MB of RAM
>>  Jun 15 16:38:54 [kernel] [    0.000000] Mapping aperture over 65536
>>  KB of RAM @ 8000000
>>
>>  The box is a dual Opteron 250 with an Arima HDAMA Rev. D motherboard.
>
>Not directly - the kernel will create a fallback aperture if it can't
>find one provided by the BIOS. The default is 64MB, but it can be
>enlarged with iommu=memaper=4
>
>There was also a bug that might have caused this over longer uptimes.
>If you still see  it with latest 2.6.16.stable (19 or so).
>
>If it still happens with those two changes then something is likely
>leaking mappings or your have a extreme workload that needs
>a lot of mappings.
>
>
>>  First, am I correct to assume that I'm not getting the 256 MB?
>
>Yes you'll get 64MB fallback likely.
>
>>
>>  Second, is the the case the BIOS is lying?
>
>Probably yes.
>
>-Andi


-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
