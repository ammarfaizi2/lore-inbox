Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136484AbRD3I5p>; Mon, 30 Apr 2001 04:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136485AbRD3I5g>; Mon, 30 Apr 2001 04:57:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17002 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S136484AbRD3I5b>; Mon, 30 Apr 2001 04:57:31 -0400
To: Steffen Persvold <sp@scali.no>
Cc: nick@snowman.net, Girard Roudier <groudier@club-internet.fr>,
        lkml <linux-kernel@vger.kernel.org>, davej@suse.de, troels@thule.no
Subject: Re: ServerWorks LE and MTRR
In-Reply-To: <Pine.LNX.4.21.0104291813490.32327-100000@ns> <3AEC9823.EEC8EC46@scali.no>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Apr 2001 02:55:26 -0600
In-Reply-To: Steffen Persvold's message of "Sun, 29 Apr 2001 17:39:31 -0500"
Message-ID: <m1bspercld.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Persvold <sp@scali.no> writes:

> nick@snowman.net wrote:
> > On Sun, 29 Apr 2001, Steffen Persvold wrote:
> > 
> > > I've learned it the hard way, I have two types : Compaq DL360 (rev 5) and a
> > > Tyan S2510 (rev 6). On the compaq machine I constantly get data corruption
> on
> 
> > > the last double word (4 bytes) in a 64 byte PCI burst when I use write
> > > combining on the CPU. On the Tyan however the transfer is always ok.
> > >
> > 
> > Are you sure that is not due to board design differences?
> 
> No I can't be 100% certain that the layout of the board isn't the reason since
> I haven't asked ServerWorks about this and it doesn't say anything in their
> docs (yes my company has the NDA, so I shouldn't get to much in detail here),
> but if this was the case it would be totally wrong to disable write combining
> on any LE chipset.
> 
> The test case that I have been using to trigger this is sort of special because
> we are using SCI shared memory adapters to write (with PIO) into remote nodes
> memory, and the bandwidth tends to get quite high (approx 170 MByte/sec on LE
> with write combining). I've been able to run this case on 5 different
> motherboards using the LE and HE-SL ServerWorks chipsets, but only two of them
> are LE (the DL360 and the S2510). Everything works fine with write-combining on
> every motherboard except the DL360 (which has rev 5).
> 
> One basic test case that I haven't tried, could be to enable write-combining on
> your PCI graphics adapter memory and see if the X display gets screwed up.
> 
> I will try to get some information from ServerWorks about this problem, but I'm
> not sure if ServerWorks would be happy if I told you the answer (because of the
> NDA).

I'd like to put my small plug in that this make me a little nervous.
It could also be a problem with the firmware (aka BIOS) missetting
something up.  Working with linuxBIOS I have seen burst-writes
(enabled with write-combining or write-back) cause data corruption
when non-burst-writes to memory don't cause problems, when the memory
controller is setup wrong.  (This is was with intel 440GX & 440BX
chipsets).

Eric
