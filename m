Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267235AbRGKInq>; Wed, 11 Jul 2001 04:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267234AbRGKIni>; Wed, 11 Jul 2001 04:43:38 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:60399 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S267232AbRGKInT>; Wed, 11 Jul 2001 04:43:19 -0400
Date: Wed, 11 Jul 2001 11:43:05 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Rob Landley <landley@webofficenow.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hardware testing [was Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))]
Message-ID: <20010711114305.I1419@niksula.cs.hut.fi>
In-Reply-To: <E15JIVD-0000Qc-00@the-village.bc.nu> <01070912485904.00705@localhost.localdomain> <20010710121724.Z1503@niksula.cs.hut.fi> <01071011282504.00634@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01071011282504.00634@localhost.localdomain>; from landley@webofficenow.com on Tue, Jul 10, 2001 at 11:28:25AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 11:28:25AM -0400, you [Rob Landley] claimed:
> 
> The downside of a test like gcc is that it does test many things, meaning 
> when it fails you still don't know why.

True.
 
> memtest86 is great becuase it ONLY tests memory.  

Yes, and because it also accurately tells you which memory location is bad.
(This can't be easily done from user space, I gather). You can use this
information to workaround the memory problem with the BadRam patch from Rick
Van Rein.

> CPUburn is similarly specific.  A memory bus buster would be a good tool
> to add to the mix.  (DMA is another common problem, but the more I look
> into it, the more it seems to be dependent on whatever peripheral you're
> talking to, which is more complication than I'm looking to bite off...)

True.
 
> It might be possible to put all three testers into a menu where you could 
> switch on and off what you wanted to test, and run them overnight.  That way, 
> if you are testing for three things (perhaps alternating tests every few 
> minutes?), and you get it to fail, you can switch some off to get more 
> specific tests to narrow down the problem...

Actually lilo is just about enough for a such menu system...

Something like

image = /boot/memtest86
        label = memtest86
image = /boot/vmlinux
        label = cpuburn
        root = /dev/hda2
        append = "init=/usr/local/bin/burnP6"
        read-only
image = /boot/vmlinux
        label = cpuburn
        root = /dev/hda2
        append = "init=/usr/local/bin/testDMA"
        read-only

It would take some scripting to alternate the tests automatically, but
perhaps it could be done.
 
> I've heard of ceberus but thought it was just a disk test suite...  One more 
> thing to download and look into...  (If the tests in it can be switched 
> on/off, maybe this is what I'm looking for...) 

AFAIK it's a pretty complete test suite VA uses (used?) for testing their
hw. I'm not sure, though.


-- v --

v@iki.fi
