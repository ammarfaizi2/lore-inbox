Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292871AbSBVORZ>; Fri, 22 Feb 2002 09:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292872AbSBVORR>; Fri, 22 Feb 2002 09:17:17 -0500
Received: from [195.63.194.11] ([195.63.194.11]:57609 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292871AbSBVORE>; Fri, 22 Feb 2002 09:17:04 -0500
Message-ID: <3C7652B6.1040008@evision-ventures.com>
Date: Fri, 22 Feb 2002 15:16:22 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Gadi Oxman <gadio@netvision.net.il>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C723B15.2030409@evision-ventures.com> <00a201c1bb8d$90dd2740$0300a8c0@lemon> <3C764B7C.2000609@evision-ventures.com> <20020222150323.A5530@suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Fri, Feb 22, 2002 at 02:45:32PM +0100, Martin Dalecki wrote:
> 
> 
>>See above that is *not* the proper interface for implementation choice,
>>which is *user* policy anyway and can be handled fine by the
>>existing generic module interface infrastructure.
>>
>>For the sake of modularization. I have already at home a version
>>of ide-pci.c, where the signatures of chipset initialization
>>source code modules match the singature of a normal pci device
>>initialization hook. This should enable it to make them true modules
>>RSN.
>>
> 
> If you can, please send this to me - I'd like to take a look.

Will do soon. But now I don't have it at hand, it's on my home system 
unfortunately and I would like to finish some other minor things there
as well. I mean basically the macro games showing that somebody didn't
understand C pointer semantics found at places like:

#ifdef CONFIG_BLK_DEV_ALI15X3
extern unsigned int pci_init_ali15x3(struct pci_dev *, const char *);
...
#define PCI_ALI15X3	&pci_init_ali15x3
#else
...
#define PCI_ALI15X3	NULL
#endif

This should rather look like:

#ifdef CONFIG_BLK_DEV_ALI15X3
extern unsigned int pci_init_ali15x3(struct pci_dev *);
#else
#define pci_init_ali15x3	NULL
#endif

And be replaces entierly by register_chipset(...) blah blah or
therlike ;-) as well as module initialization lists.

>>The chipset drivers will register lists of PCI-id's they can handle
>>instead of the single only global list found in ide-pci.c.
>>
> 
> I think it'd be even better if the chipset drivers did the probing
> themselves, and once they find the IDE device, they can register it with
> the IDE core. Same as all the other subsystem do this.

Well the lists are needed for quirk handling in the ide-pci.c code.
But if it turns out to be possible - I'm all for it.

