Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291087AbSBLOiZ>; Tue, 12 Feb 2002 09:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291085AbSBLOiP>; Tue, 12 Feb 2002 09:38:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2060 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291086AbSBLOh7>; Tue, 12 Feb 2002 09:37:59 -0500
Subject: Re: 2.5.4, cs46xx snd, and virt_to_bus
To: davem@redhat.com (David S. Miller)
Date: Tue, 12 Feb 2002 14:51:33 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, weber@nyc.rr.com, tom_gall@vnet.ibm.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020211.184316.70218682.davem@redhat.com> from "David S. Miller" at Feb 11, 2002 06:43:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16aeHN-00020H-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However, for "purely x86 ISA" devices one may use
> isa_bus_to_virt and isa_virt_to_bus.
> 
> I hesitate to even mention this because what people should _not_ do is
> just put "isa_" in front of the virt_to_bus et al. calls in all the
> PCI drivers that stopped to link now.

Would putting a range check and BUG() in the ISA macros for now help there.

Reminds me - we have a request_mem_region problem to address that is sort
of related to all this. Right now we reserve mem regions without knowing
properly about ISA mappings. That means drivers are reserving stuff like
0xD0000. Unfortunately on some non X86 boxes the ISA hole isnt at 640K-1M
so it appears we want an  isa_request_mem_region and friends to handle those
platforms ?
