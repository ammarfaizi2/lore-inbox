Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262573AbSJBUgc>; Wed, 2 Oct 2002 16:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262574AbSJBUga>; Wed, 2 Oct 2002 16:36:30 -0400
Received: from host.greatconnect.com ([209.239.40.135]:29702 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S262573AbSJBUgY>; Wed, 2 Oct 2002 16:36:24 -0400
Message-ID: <3D9B5B8F.1060409@rackable.com>
Date: Wed, 02 Oct 2002 13:48:15 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bruce Lowekamp <lowekamp@CS.WM.EDU>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre8 swaps ide controller order on A7V266-E
References: <15570000.1033586626@chorus.cs.wm.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce Lowekamp wrote:

>
> Starting with 2.4.19 and continuing in 2.4.20-pre8, the order the 
> kernel associates with the two IDE controllers (one VIA vt8233 and one 
> PDC20265 intended for RAID use) on the A7V266-E has been reversed.  
> The BIOS and GRUB consider the VIA to be first, so root(hd0,0) loads 
> the kernel from the first device on the VIA controller.  Prior to 
> 2.4.19, the OS then booted with that drive identified as hda.  
> Beginning with 2.4.19, however, the kernel instead identifies the PDC 
> as ide0 and ide1, and puts the VIA at ide2 and ide3, resulting in the 
> boot drive being hde.
>
> I found an earlier mention of this on the mailing list, but no 
> solution or workaround was suggested.  We are using a workaround where 
> 2.4.19 and later kernels are booted with root=/dev/hde1 and earlier 
> with hda1, and fstab lists both hda2 and hde2 as swap partitions, 
> simply failing to insert one. This works, but the general ugliness and 
> maintenance headaches since this is different than the typical machine 
> config we use around here make it difficult to use in the long run.
>
> I'm not sure what the process of identifying order of controllers 
> involves, but the discrepancy between the BIOS, older kernels, and 
> newer kernels seems like something that should be fixed if possible.


  I'm not sure what the kernel issue is, but there is a simple work 
around.  Enable CONFIG_BLK_DEV_OFFBOARD (aka boot off-board chipsets 
first) in the ide section.  You can also produce the same effect via 
ide=reverse on the kernel command line (or an append statement in lilo). 
 This will reverse the order in which the chipsets are seen.


-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



