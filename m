Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291089AbSBLOth>; Tue, 12 Feb 2002 09:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291091AbSBLOt0>; Tue, 12 Feb 2002 09:49:26 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:38645 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S291089AbSBLOtR>; Tue, 12 Feb 2002 09:49:17 -0500
From: <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <weber@nyc.rr.com>, <tom_gall@vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.4, cs46xx snd, and virt_to_bus
Date: Tue, 12 Feb 2002 15:49:16 +0100
Message-Id: <20020212144916.1889@mailhost.mipsys.com>
In-Reply-To: <E16aeHN-00020H-00@the-village.bc.nu>
In-Reply-To: <E16aeHN-00020H-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.1.1 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Would putting a range check and BUG() in the ISA macros for now help there.
>
>Reminds me - we have a request_mem_region problem to address that is sort
>of related to all this. Right now we reserve mem regions without knowing
>properly about ISA mappings. That means drivers are reserving stuff like
>0xD0000. Unfortunately on some non X86 boxes the ISA hole isnt at 640K-1M
>so it appears we want an  isa_request_mem_region and friends to handle those
>platforms ?
>-

I'd rather provide a function to obtain the base address of the ISA hole,
while would also allow us to
 - Return an error when it doesn't exist (a given kernel may or may not
have it depending on which box it's booted, it can't be a compile time
option)
 - Eventually obtain a per-PCI bus ISA hole (the "legacy one" beeing
defined as bus or with a special constant) so multi domain machines
can use multiple VGA cards (eek eek ;)

With that, at least PPC don't require isa_xxx specific functions/macros
(but I can't tell about other archs).

Ben.





