Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWHPWR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWHPWR5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWHPWR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:17:56 -0400
Received: from pat.qlogic.com ([198.70.193.2]:12324 "EHLO avexch1.qlogic.com")
	by vger.kernel.org with ESMTP id S932276AbWHPWRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:17:55 -0400
Date: Wed, 16 Aug 2006 15:17:51 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: qlogic 2312 problems on 2.6.16.22, 2.6.18rc4
Message-ID: <20060816221751.GW3674@andrew-vasquezs-computer.local>
References: <200608140946.50411.arekm@pld-linux.org> <200608151429.09082.arekm@pld-linux.org> <20060816181445.GU3674@andrew-vasquezs-computer.local> <200608162310.26541.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608162310.26541.arekm@pld-linux.org>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.12-2006-07-14
X-OriginalArrivalTime: 16 Aug 2006 22:17:55.0011 (UTC) FILETIME=[D2511930:01C6C181]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006, Arkadiusz Miskiewicz wrote:

> On Wednesday 16 August 2006 20:14, Andrew Vasquez wrote:
> 
> > > Everything works fine on 32-bit dual xeon machine with card inserted into
> > > PCI slot. Here in new dual core opteron machine the card sits in PCI-X
> > > slot. It's Thunder K8SRE S2891 mainboard, Transport GT24 B2891 1U
> > > barebone, Tyan M2075 riser card, 2 x Opteron 270, 6GB ram.
> >
> > Have you ruled out motherboard/memory issues?  We've run 23xx and 24xx
> > boards on a variety of AMD64 motherboards with more than 4GB of
> > memory.
> Not exactly. I have three such servers (the same board, cpu, ram).
> 
> One of these has PCI-E scsi raid controller and works without any problem. 
> 
> Second one (which I'm using for testing) has Adaptec SCSI controller 
> in Tyan specific TARRO slot (which afaik sits on the same PCI-X bus as PCI-X slot).
> I had an array on that adaptec for some time and there were no problems.
> The second one also got own qlogic 2312 card.
> 
> Third machine has other qlogic 2312 card and I tried it two times,
> too - the same issues observed.
> 
> So mainboards and memory should be fine but I guess there is possibility
> that PCI-X slot is somehow broken there. I'll test that in several weeks
> (unfortunately I have no physical access to these now) by putting some
> typical scsi controller into that pci-x slot.
> 
> > > Note that booting with 32-bit kernel (which works fine on Xeon system)
> > > doesn't cure the problem on Opteron system. Booting 64bit 2.6.18rc4
> > > kernel with mem=3G also doesn't fix anything.
> >
> > Hmm...  Can you send your dmesg output post boot and driver load?
> 
> dmesg and lspci -vvv attached.
> 
> There is one thing that worries me:
>   QLogic QLA2340 - 
>   ISP2312: PCI-X (133 MHz) @ 0000:09:08.0 hdma+, host#=0, fw=3.03.20 IPX
> Why it's showing 133MHz here? 
> 
> Tyan manual ftp://ftp.tyan.com/manuals/m_s2891_100.pdf says on page 4
> ,,One PCI-X 100MHz slot (PCI-X B)''.
> 
> Hm, while looking at that manual I see that on page 13 it says ,,one pci-x 100MHz device''.
> Maybe that's the problem since I didn't remove Adaptec TARO controller. I should be able to
> get this tested again without adaptec sooner than several weeks. Maybe I misunderstand
> what documentation says here.
> 
> Anyway still don't know why driver displays 133Mhz while manual says about
> 100MHz one pci-x slot.

that is odd... I'm just dumping the bits from the control-register
which are set by hardware to indicate which type of slot the HBA is
connected to...

> > > /t is on tmpfs, /dev/sda2 in on FC array. Reading the same data several
> > > times and I get different md5sum results each time, see below.
> > >
> > > How I can track where corruption occurs?
> 
> I started dd'ing text file onto /dev/sda2, then back to tmpfs and diffing these. Corruption
> is one byte, several not corrupted bytes and again one corrupted byte. Some regular pattern.

Could you send me the a snippet (2 to 4KB) of the good and bad data?

Regards,
Andrew Vasquez
