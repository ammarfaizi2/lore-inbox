Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271232AbRHOPm1>; Wed, 15 Aug 2001 11:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271234AbRHOPmS>; Wed, 15 Aug 2001 11:42:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:47491 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S271232AbRHOPmK>; Wed, 15 Aug 2001 11:42:10 -0400
Date: Wed, 15 Aug 2001 11:42:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Steve Hill <steve@navaho.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <Pine.LNX.4.21.0108151622570.2107-100000@sorbus.navaho>
Message-ID: <Pine.LNX.3.95.1010815113613.28526A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2001, Steve Hill wrote:

> On Wed, 15 Aug 2001, Richard B. Johnson wrote:
> 
> > Same problem on 2.4.1. The first 512 bytes comes right away if
> > /dev/random hasn't been accessed since boot, then the rest trickles
> > a few words per second.
> 
> Hmm...  Well, ATM I've kludged a fix by using /dev/urandom instead, but
> it's not ideal because it's being used to generate cryptographic keys, and
> urandom isn't cryptographically secure.
> 
> Are you seeing the problem on a normal machine? (I assumed I was seeing it
> because I'm using Cobalt hardware that's not going to get much entropy
> data due to the lack of keyboard, etc)...  although when I'm generating
> this data I'm using a root NFS filesystem, so there should be plenty of
> network interrupts happening,which should generate some entropy...
> 
> I might have a look into increasing the size of the entropy pool so
> there's more data to access at once...
> 
Well here's what happends here:

Script started on Wed Aug 15 11:21:53 2001
# od /dev/random
0000000 130674 116756 132001 007612 006026 172713 104065 064656
0000020 116442 062343 121475 137430 055664 120262 026123 163564
0000040 033327 150202 024063 171506 057577 076666 032573 136163
0000060 065715 044033 106023 170742 113116 165162 174552 030442
0000100 120516 015667 067741 024013 074131 167165 046440 174337
0000120 024433 173272 174077 166252 061222 165164 101233 067027
0000140 105137 142465 053441 102473 105611 047232 012244 007461
0000160 022153 174254 147632 150762 065452 057635 007715 127427
0000200 030603 120467 036735 010661 177320 107643 101210 037421
0000220 032771 022570 110575 116457 016235 020242 063455 121261
0000240 011150 104011 167330 065547 176443 041525 132551 030143
0000260 111676 057565 057406 046766 076027 041337 032770 140766

# exit
exit

Script done on Wed Aug 15 11:23:51 2001

I finally ^C  out of it. Look at the start and stop times of
the script!

Script started on Wed Aug 15 11:21:53 2001
Script done on Wed Aug 15 11:23:51 2001
That's almost 3 minutes I waited for the data displayed above.

In the meantine, I've gotten hundreds, perhaps thousands of
network interrupts because there is a lot of broadcast traffic
on the LAN. This should have added enough stuff to the pool.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


