Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262304AbSJNVOV>; Mon, 14 Oct 2002 17:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262323AbSJNVOV>; Mon, 14 Oct 2002 17:14:21 -0400
Received: from verlaine.noos.net ([212.198.2.73]:43036 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id <S262304AbSJNVOQ>;
	Mon, 14 Oct 2002 17:14:16 -0400
Date: Mon, 14 Oct 2002 23:20:00 +0200
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: David Brownell <david-b@pacbell.net>
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] 2.5.42-ac1, 2.5.42, 2.5.41 boot hang with CONFIG_USB_DEBUG=n
Message-ID: <20021014212000.GA1002@rousalka.noos.fr>
References: <20021013172557.GA890@rousalka.noos.fr> <3DAAF67F.1080504@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3DAAF67F.1080504@pacbell.net>; from david-b@pacbell.net on lun, oct 14, 2002 at 18:53:19 +0200
X-Mailer: Balsa 2.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002.10.14 18:53 David Brownell wrote:
>> Now it turns out I didn't do such a piss-poor of configuring my 2.5 
>> kernel, since the only option I could find that make a difference 
>> was CONFIG_USB_DEBUG. When I accept flooding my system logs with 
>> obscure usb incantations the system boots:(.   ...
>> 
>>     Can an helpful soul help me bring my system some relief  ? I'd 
>> really like not to boot in debug mode.
> 
> That's a new failure mode!   Can you help narrow this down?
> 
> You're using the OHCI driver, so you can just tweak the lines at the
> top of drivers/usb/host/ohci-hcd.c that can #define DEBUG.  If you
> comment out that #define, and leave CONFIG_USB_DEBUG on (and then
> rebuild and re-init with the new OHCI driver), does that work or not?

As requested, I changed the defines in this file to :

/*#ifdef CONFIG_USB_DEBUG
#       define DEBUG
#else*/
#       undef DEBUG
/*#endif*/

rebuild a kernel, and started rebooting like mad.

Procedure was following :
1. reboot the computer (software reboot if ok kernel, else reset)
2. go through bios (long initiation with memory testing)
3. when the bootloader shows up (might hang just before, my disks 
really do not like being stopped before reboot) / when the system 
hangs, press reset
4. go through bios initialization (bis)
5. when grub shows up, play a bit in the menus (up-down...) then choose 
a kernel

With this protocol I got a 100% boot rate on the original kernel and an 
almost-always hang with the kernel where debuging was undefed in 
drivers/usb/host/ohci-hcd.c. It did boot two times (out of maybe 10-15 
tries) but that doesn't count since both times the keyboard was dead. 
Since I can't do a lost of things with only the mouse, I clicked reboot 
in gdm these two times.

> If that works, it'd be time to see which OHCI printk()s morph init (?)
> timing enough to matter to your K7 box.   Looked to me like they were
> all either before or after the timing-critical bits (chip init), so
> disabling just the OHCI messages "should" not change your failure 
> mode.

No such luck. It really looks like ohci is the culprit:(
I guess I'm lucky it's got a maintainer as responsive as you:)

Any other ideas ?

Regards,

P.S.

	I don't know if it's important, but I had to enable usb 
keyboard legacy mode in the bios to have keyboard support in the 
bootloader stage. I had a bad feeling about the option though, a good 
bios is a lean bios.

--
Nicolas Mailhot
