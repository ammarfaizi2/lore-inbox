Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267256AbTAGAGU>; Mon, 6 Jan 2003 19:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbTAGAGT>; Mon, 6 Jan 2003 19:06:19 -0500
Received: from palrel11.hp.com ([156.153.255.246]:60042 "HELO palrel11.hp.com")
	by vger.kernel.org with SMTP id <S267256AbTAGAGS>;
	Mon, 6 Jan 2003 19:06:18 -0500
Date: Mon, 6 Jan 2003 16:13:32 -0800
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
Message-ID: <20030107001332.GJ26790@cup.hp.com>
References: <20030106215210.GE26790@cup.hp.com> <Pine.LNX.4.44.0301061515530.10086-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301061515530.10086-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
From: grundler@cup.hp.com (Grant Grundler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 03:19:09PM -0800, Linus Torvalds wrote:
> In particular, we can make the first phase disable DMA on the devices we 
> find, which means that we know they won't be generating PCI traffic during 
> the second phase - so now the second phase (which does the BAR sizing) can 
> do sizing and be safe in the knowledge that there should be no random PCI 
> activity ongoing at the same time.

Did you expect the PCI_COMMAND_MASTER disabled in the USB Controller
or something else in the controller turned off?

Turning off MASTER will also disable the controller from responding
to MMIO ...ie USB subsystem can't touch the USB controller until
it's re-enabled (no USB interrupts). That's ok if PCI will re-enable
USB controller in a later PCI setup phase. In general I expect a driver
to call pci_enable_device() but I don't know anything about USB intialization
when it's part of the "console" (HID).

BTW, I wasn't thinking of USB.  I'm just trying to understand if the "fix"
is exclusively in the PCI code or will require changes to other subsystems.

> It's fine to temporarily disable memory on the northbridge, as long as
> nothign else tries to _access_ that memory at the same time.

The implemention to enforce that is what I meant with "arch specific code".

I still have no idea which bridge implementations (vendor/model)
have this problem and thus no idea what the i386 code would need 
to look like. I was hoping Ivan (or someone) might know.

thanks,
grant
