Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318519AbSH1Axy>; Tue, 27 Aug 2002 20:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318529AbSH1Axy>; Tue, 27 Aug 2002 20:53:54 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:52749 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S318519AbSH1Axs>; Tue, 27 Aug 2002 20:53:48 -0400
Date: Wed, 28 Aug 2002 04:58:02 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
Message-ID: <20020828045802.A31036@jurassic.park.msu.ru>
References: <20020826175747.A27952@jurassic.park.msu.ru> <Pine.LNX.4.33.0208261038440.15474-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0208261038440.15474-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Aug 26, 2002 at 10:42:34AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 10:42:34AM -0700, Linus Torvalds wrote:
> Please don't do it like this: I hate code that changes standard PCI data 
> structure meaning (in this case the "class" thing) behind peoples back.. 

Fairly speaking, I wasn't happy about that either - that's why
I tried to change only a single bit in the first patch.
Note that this stuff was intended for 2.4 in the first place :-)

> So instead, I would suggest that you add a single-bit "transparent" field
> to the PCI structure, and initialize it to "(class & 0xff) == 1" when
> initializing the device data. Then, any fixup can just set the transparent
> bit to 1.
> 
> That would make the code more robust, and more readable in my opionion.
> 
> Ok?

Agreed.
I would even go further and add a "quirks" field to the struct
pci_dev (probably 16 bits would be enough). Thus we can define
specific bits for common PCI bugs - not only QUIRK_TRANSPARENT_BRIDGE
but also things like QUIRK_BROKEN_MWI or even
QUIRK_SOME_COMMON_PCI_IDE_BUG and so on. This would allow generic code
to check a single bit instead of looking through several
vendor/device ID lists.

Thoughts?

Ivan.
