Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292886AbSBVPB5>; Fri, 22 Feb 2002 10:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292887AbSBVPBs>; Fri, 22 Feb 2002 10:01:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26377 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292886AbSBVPBi>;
	Fri, 22 Feb 2002 10:01:38 -0500
Message-ID: <3C765D50.D4A1D2D0@mandrakesoft.com>
Date: Fri, 22 Feb 2002 10:01:36 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Vojtech Pavlik <vojtech@suse.cz>, Gadi Oxman <gadio@netvision.net.il>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C723B15.2030409@evision-ventures.com> <00a201c1bb8d$90dd2740$0300a8c0@lemon> <3C764B7C.2000609@evision-ventures.com> <20020222150323.A5530@suse.cz> <3C7652B6.1040008@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> Will do soon. But now I don't have it at hand, it's on my home system
> unfortunately and I would like to finish some other minor things there
> as well. I mean basically the macro games showing that somebody didn't
> understand C pointer semantics found at places like:
> 
> #ifdef CONFIG_BLK_DEV_ALI15X3
> extern unsigned int pci_init_ali15x3(struct pci_dev *, const char *);
> ...
> #define PCI_ALI15X3     &pci_init_ali15x3
> #else
> ...
> #define PCI_ALI15X3     NULL
> #endif
> 
> This should rather look like:
> 
> #ifdef CONFIG_BLK_DEV_ALI15X3
> extern unsigned int pci_init_ali15x3(struct pci_dev *);
> #else
> #define pci_init_ali15x3        NULL
> #endif

For what the code is trying to accomplish, the code is correct.

I agree the above change is also correct... probably the author wanted
to reduce the size of the -huge- data table where PCI_ALI15X3 symbol is
used.


> And be replaces entierly by register_chipset(...) blah blah or
> therlike ;-) as well as module initialization lists.

When we have "modprobe piix4_ide" loading the IDE subsystem, you are
correct.

IDE is currently driven by an inward->outward setup of module
initialization, which is fundamentally the opposite of what we want,
which is chipset_drvr -> core initialization.

	Jeff



-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
