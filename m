Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTDXH2O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 03:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTDXH2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 03:28:14 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.46]:59858 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261292AbTDXH2M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 03:28:12 -0400
From: DevilKin-LKML <devilkin-lkml@blindguardian.org>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [2.5.67 - 2.5.68] Hangs on pcmcia yenta_socket initialisation
Date: Thu, 24 Apr 2003 09:40:18 +0200
User-Agent: KMail/1.5
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>, devilkin-lkml@blindguardian.org
References: <200304230747.27579.devilkin-lkml@blindguardian.org> <200304232050.41230.devilkin-lkml@blindguardian.org> <20030423204341.A19573@flint.arm.linux.org.uk>
In-Reply-To: <20030423204341.A19573@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304240940.21553.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 23 April 2003 21:43, Russell King wrote:
> On Wed, Apr 23, 2003 at 08:50:39PM +0200, DevilKin-LKML wrote:
> > Unable to handle kernel paging request at virtual address d10545c0
> >  printing eip:
> > c01b0368
> > *pde = 0fb66067
> > *pte = 00000000
> > Oops: 0000 [#1]
> > CPU:    0
> > EIP:    0060:[<c01b0368>]    Not tainted
> > EFLAGS: 00010286
> > EIP is at pci_bus_match+0x18/0xb0
> > eax: 00000000   ebx: cf2a8800   ecx: d10545c0   edx: 00000000
> > esi: cf2a884c   edi: ffffffed   ebp: c12d284c   esp: ce591e88
> > ds: 007b   es: 007b   ss: 0068
> > Process pcmcia/0 (pid: 388, threadinfo=ce590000 task=ce6f7300)
> > Stack: d109edc8 c01d1abf cf2a884c d109edc8 d109edf8 cf2a884c c02d7ff8
> > c01d1b5f cf2a884c d109edc8 cf2a884c c02d7fa0 cf2a8888 c01d1d24 cf2a884c
> > c0282ddf c02de000 cf2a884c 00000000 cf2a8888 c01d0ef0 cf2a884c cf2a8800
> > cffd08b4 Call Trace:
> >  [<d109edc8>] m3_pci_driver+0x28/0xa0 [maestro3]
> >  [<c01d1abf>] bus_match+0x2f/0x80
> >  [<d109edc8>] m3_pci_driver+0x28/0xa0 [maestro3]
> >  [<d109edf8>] m3_pci_driver+0x58/0xa0 [maestro3]
> >  [<c01d1b5f>] device_attach+0x4f/0x90
> >  [<d109edc8>] m3_pci_driver+0x28/0xa0 [maestro3]
>
> I don't think this is PCMCIA related - something else is going on here.
>
> My guess is we're trying to locate a driver for the card, and we get to
> maestro3.  This works as expected, but the next driver on the chain
> seems to be a module which was may have been removed but which left
> its pci_driver structure behind (at 0xd10545c0.)

I have a Maestro3 in the laptop (which is also why the module is loaded), but 
I never unload it once it's loaded at bootup...

Anything else I can try?

Jan
- -- 
To be sure of hitting the target, shoot first and, whatever you hit,
call it the target.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+p5TlpuyeqyCEh60RAuAuAJ9WByWWm+pwMNT3HrarHxiW/6HfKACeMOPZ
2d2+dnUbdZhDG2A3vfVNHoI=
=rw/c
-----END PGP SIGNATURE-----

