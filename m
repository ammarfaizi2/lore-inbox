Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263382AbTDWTbn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbTDWTbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:31:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35594 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263382AbTDWTbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:31:40 -0400
Date: Wed, 23 Apr 2003 20:43:41 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: DevilKin-LKML <devilkin-lkml@blindguardian.org>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.67 - 2.5.68] Hangs on pcmcia yenta_socket initialisation
Message-ID: <20030423204341.A19573@flint.arm.linux.org.uk>
Mail-Followup-To: DevilKin-LKML <devilkin-lkml@blindguardian.org>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <200304230747.27579.devilkin-lkml@blindguardian.org> <200304231454.18834.devilkin-lkml@blindguardian.org> <1051107787.4195.2.camel@teapot.felipe-alfaro.com> <200304232050.41230.devilkin-lkml@blindguardian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304232050.41230.devilkin-lkml@blindguardian.org>; from devilkin-lkml@blindguardian.org on Wed, Apr 23, 2003 at 08:50:39PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 08:50:39PM +0200, DevilKin-LKML wrote:
> Unable to handle kernel paging request at virtual address d10545c0
>  printing eip:
> c01b0368
> *pde = 0fb66067
> *pte = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c01b0368>]    Not tainted
> EFLAGS: 00010286
> EIP is at pci_bus_match+0x18/0xb0
> eax: 00000000   ebx: cf2a8800   ecx: d10545c0   edx: 00000000
> esi: cf2a884c   edi: ffffffed   ebp: c12d284c   esp: ce591e88
> ds: 007b   es: 007b   ss: 0068
> Process pcmcia/0 (pid: 388, threadinfo=ce590000 task=ce6f7300)
> Stack: d109edc8 c01d1abf cf2a884c d109edc8 d109edf8 cf2a884c c02d7ff8 c01d1b5f 
>        cf2a884c d109edc8 cf2a884c c02d7fa0 cf2a8888 c01d1d24 cf2a884c c0282ddf 
>        c02de000 cf2a884c 00000000 cf2a8888 c01d0ef0 cf2a884c cf2a8800 cffd08b4 
> Call Trace:
>  [<d109edc8>] m3_pci_driver+0x28/0xa0 [maestro3]
>  [<c01d1abf>] bus_match+0x2f/0x80
>  [<d109edc8>] m3_pci_driver+0x28/0xa0 [maestro3]
>  [<d109edf8>] m3_pci_driver+0x58/0xa0 [maestro3]
>  [<c01d1b5f>] device_attach+0x4f/0x90
>  [<d109edc8>] m3_pci_driver+0x28/0xa0 [maestro3]

I don't think this is PCMCIA related - something else is going on here.

My guess is we're trying to locate a driver for the card, and we get to
maestro3.  This works as expected, but the next driver on the chain
seems to be a module which was may have been removed but which left
its pci_driver structure behind (at 0xd10545c0.)

Decoding the attached x86 opcodes didn't reveal anything interesting to
me.

Anyone else?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

