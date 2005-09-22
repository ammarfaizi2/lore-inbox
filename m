Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVIVTUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVIVTUG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbVIVTUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:20:06 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:63762 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751147AbVIVTUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:20:05 -0400
Message-ID: <433303A9.6050909@tmr.com>
Date: Thu, 22 Sep 2005 15:19:05 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
CC: sean.bruno@dsl-only.net, ak@suse.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: The system works (2.6.14-rc2): functional k8n-dl
References: <20050922155254.GE5910@us.ibm.com>
In-Reply-To: <20050922155254.GE5910@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan wrote:
> Hello all,
> 
> Some background: I had been wanting to build a dual-opteron box for a
> solid development environment at home and did some perusing of possible
> MoBos (including seeing what LKML'ers thought. I saw both Karim's and
> Sean's postings regarding issues with the ASUS K8N-DL (pretty negative),
> but also found
> http://gentoo-wiki.com/ASUS_K8N-DL_dual_Opteron_motherboard (I don't run
> Gentoo, mind you), which gave me some hope. So I went ahead and bought
> the K8N-DL, two Opteron 244s, 2 GB of RAM and 2 WD Caviar 250GB SATA
> disks. Enough about the box.
> 
> First of all, I was able to install Ubuntu Breezy Badger straight away.
> Everything worked (factory installed BIOS 1003), including the network
> adapter (via the tg3 driver) and my new wireless keyboard and mouse over
> USB! The only trickery was that I needed to boot with "noapic nolapic
> pci=noacpi" to get all the IRQs to show up properly and get a clean
> boot.
> 
> I decided to try and update the BIOS (which you can handily do off a
> CDRW :) There are two versions available, 1004 and 1006, beyond the
> factory default one.
> 
> With 1004, I still needed the custom boot options in 2.6.13.2,
> 2.6.14-rc1 and 2.6.14-rc2.
> 
> But, with 1006, I need no options with 2.6.14-rc2 (I have not gone back
> to verify that it is also the case with 2.6.13.2) and I get a flawless
> boot! In fact, if I do boot with 2.6.14-rc2 and noapic nolapic
> pci=noacpi, I get IRQ 7 disabled. I have included my .config below[1] as
> well as the output of dmesg in 2.6.14-rc2 with no special command-line
> parameters[2] and the diff relative to the boot of 2.6.14-rc2 with
> "noapic nolapic pci=noacpi"[3].
> 
> Also, please note that I had some issues install Breezy to the SATA
> drives when attached to the Silicon Image controller on the motherboard.
> I could not get the partitioner to set up more than a ~140 GB partition
> on the drive (it would hang for a bit and then report disconnect events,
> if I remember correctly). I checked the cable, etc. So, I have both
> disks connected to the nForce4 SATA controller and it is working
> flawless with sata_nv.
> 
> I just wanted to thank Andi and the other x86_64 folks for getting the
> code in such a solid state. I have had only one complaint so far: it
> seems that the the "Broadcom Corporation NetXtreme BCM5751 Gigabit
> Ethernet PCI Express" adapter, with the tg3 driver, downs and ups the
> iface on MTU changes. Unfortunately, with some VPN software I use, it is
> sometimes necessary to drop the MTU to 1300 or so to get consistent
> connections. When I do this, though, ssh through the tunnel tends to not
> function. I have a workaround, where I bounce over a different laptop,
> but that's a bit of a pain (and that network adapter seems to be able to
> transiently change the MTU). Not a big deal, in any case.

You can (or could in 2.4) sometimes play with the size for an individual 
IP by using the "mss" option of the old "route" command. That shouldn't 
glitch anything, it just should use little packets.
> 
> The only other thing I have seen is that on shutdown, powernowd tends to
> segfault.
> 
> So, at least one success story. I do have logs of the boots with all
> combinations of BIOS 1003, 1004 and 1006 and kernels 2.6.13.2,
> 2.6.14-rc1 and 2.6.14-rc2, if anyone is interested. I am more than happy
> to test patches, .configs, etc.
> 
> Thanks,
> Nish

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
