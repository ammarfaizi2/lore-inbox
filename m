Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292885AbSBVOjc>; Fri, 22 Feb 2002 09:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292883AbSBVOiT>; Fri, 22 Feb 2002 09:38:19 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:28677 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S292882AbSBVOiI>; Fri, 22 Feb 2002 09:38:08 -0500
Date: Fri, 22 Feb 2002 15:38:06 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Gadi Oxman <gadio@netvision.net.il>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020222153806.A5783@suse.cz>
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C723B15.2030409@evision-ventures.com> <00a201c1bb8d$90dd2740$0300a8c0@lemon> <3C764B7C.2000609@evision-ventures.com> <20020222150323.A5530@suse.cz> <3C7652B6.1040008@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7652B6.1040008@evision-ventures.com>; from dalecki@evision-ventures.com on Fri, Feb 22, 2002 at 03:16:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 03:16:22PM +0100, Martin Dalecki wrote:

> Will do soon. But now I don't have it at hand, it's on my home system 
> unfortunately and I would like to finish some other minor things there
> as well. I mean basically the macro games showing that somebody didn't
> understand C pointer semantics found at places like:
> 
> #ifdef CONFIG_BLK_DEV_ALI15X3
> extern unsigned int pci_init_ali15x3(struct pci_dev *, const char *);
> ...
> #define PCI_ALI15X3	&pci_init_ali15x3
> #else
> ...
> #define PCI_ALI15X3	NULL
> #endif
> 
> This should rather look like:
> 
> #ifdef CONFIG_BLK_DEV_ALI15X3
> extern unsigned int pci_init_ali15x3(struct pci_dev *);
> #else
> #define pci_init_ali15x3	NULL
> #endif
> 
> And be replaces entierly by register_chipset(...) blah blah or
> therlike ;-) as well as module initialization lists.
> 
> >>The chipset drivers will register lists of PCI-id's they can handle
> >>instead of the single only global list found in ide-pci.c.
> >>
> > 
> > I think it'd be even better if the chipset drivers did the probing
> > themselves, and once they find the IDE device, they can register it with
> > the IDE core. Same as all the other subsystem do this.
> 
> Well the lists are needed for quirk handling in the ide-pci.c code.
> But if it turns out to be possible - I'm all for it.

I don't think so. If needed we can make some generic IDE_QUIRK_XXX
defines which then the chipset drivers can use where applicable, passing
them to the generic code.

-- 
Vojtech Pavlik
SuSE Labs
