Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292892AbSBVPNi>; Fri, 22 Feb 2002 10:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292893AbSBVPNT>; Fri, 22 Feb 2002 10:13:19 -0500
Received: from [195.63.194.11] ([195.63.194.11]:43530 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292892AbSBVPNH>; Fri, 22 Feb 2002 10:13:07 -0500
Message-ID: <3C765FD3.2060000@evision-ventures.com>
Date: Fri, 22 Feb 2002 16:12:19 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Vojtech Pavlik <vojtech@suse.cz>, Gadi Oxman <gadio@netvision.net.il>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C723B15.2030409@evision-ventures.com> <00a201c1bb8d$90dd2740$0300a8c0@lemon> <3C764B7C.2000609@evision-ventures.com> <20020222150323.A5530@suse.cz> <3C7652B6.1040008@evision-ventures.com> <3C765D50.D4A1D2D0@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>>#ifdef CONFIG_BLK_DEV_ALI15X3
>>extern unsigned int pci_init_ali15x3(struct pci_dev *, const char *);
>>...
>>#define PCI_ALI15X3     &pci_init_ali15x3
>>#else
>>...
>>#define PCI_ALI15X3     NULL
>>#endif
>>
>>This should rather look like:
>>
>>#ifdef CONFIG_BLK_DEV_ALI15X3
>>extern unsigned int pci_init_ali15x3(struct pci_dev *);
>>#else
>>#define pci_init_ali15x3        NULL
>>#endif
>>
> 
> For what the code is trying to accomplish, the code is correct.

Of course it's semantically correct. But the usage of an explicitly 
taken function pointer refference is usually a shure sign for a C 
beginner at work. I know and you know that this &xxx == xxx semantics is 
a workarount for pure K&R C implementation quriks.

> I agree the above change is also correct... probably the author wanted
> to reduce the size of the -huge- data table where PCI_ALI15X3 symbol is
> used.

Yes but he just didn't recognize that the whole huge list is the true
cause of grief ;-).

>>And be replaces entierly by register_chipset(...) blah blah or
>>therlike ;-) as well as module initialization lists.
>>
> 
> When we have "modprobe piix4_ide" loading the IDE subsystem, you are
> correct.

That's the intention yes.

> IDE is currently driven by an inward->outward setup of module
> initialization, which is fundamentally the opposite of what we want,
> which is chipset_drvr -> core initialization.

Just one word: Amen.

