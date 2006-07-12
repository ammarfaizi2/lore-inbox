Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWGLPSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWGLPSg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 11:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWGLPSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 11:18:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15580 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751394AbWGLPSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 11:18:35 -0400
Date: Wed, 12 Jul 2006 08:18:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alessio Sangalli <alesan@manoweb.com>
cc: Daniel Ritz <daniel.ritz-ml@swissonline.ch>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cardbus: revert IO window limit
In-Reply-To: <44B4AAF9.1000706@manoweb.com>
Message-ID: <Pine.LNX.4.64.0607120816070.5623@g5.osdl.org>
References: <200607010003.31324.daniel.ritz-ml@swissonline.ch>
 <Pine.LNX.4.64.0606301516140.12404@g5.osdl.org> <200607010109.40486.daniel.ritz-ml@swissonline.ch>
 <Pine.LNX.4.64.0606301614470.12404@g5.osdl.org> <44B4AAF9.1000706@manoweb.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jul 2006, Alessio Sangalli wrote:
>
> Linus Torvalds wrote:
> 
> > Alessio, try Daniel's patch. We'd love to hear if it works, and in 
> > particular what the dmesg output is (if it does work, it should print out 
> > something like
> > 
> > 	PIIX4 ACPI PIO at 2000-203f
> > 	PIIX4 SMB PIO at 2040-204f
> > 
> > and perhaps even a few "PIIX4 devres X" lines..)
> 
> this is the relevat dmesg output:
> 
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI quirk: region 1000-103f claimed by PIIX4 ACPI
> PCI quirk: region 1400-140f claimed by PIIX4 SMB
> PIIX4 devres C PIO at 0398-0399

Thanks, that explains it. Anybody who allocated region 1000 and 1400 would 
clash with the built-in PIIX magic IO regions, and any driver that tried 
to access those regions would instead end up accessing magic SMBus or ACPI 
registers.

So your lock-ups are very understandable indeed, and I'll apply this to 
the standard kernel. MUCH better than reverting the IO window limits.

		Linus
