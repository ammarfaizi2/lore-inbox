Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262822AbRFGSlK>; Thu, 7 Jun 2001 14:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262823AbRFGSlA>; Thu, 7 Jun 2001 14:41:00 -0400
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:39953 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S262822AbRFGSks>; Thu, 7 Jun 2001 14:40:48 -0400
To: Ion Badulescu <ionut@cs.columbia.edu>
Subject: Re: xircom_cb problems
Message-ID: <991939245.3b1fcaada710e@eargle.com>
Date: Thu, 07 Jun 2001 14:40:45 -0400 (EDT)
From: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Tom Sightler <ttsig@tuxyturvy.com>, linux-kernel@vger.kernel.org,
        arjan@fenrus.demon.nl
In-Reply-To: <Pine.LNX.4.33.0106070118320.22593-100000@age.cs.columbia.edu>
In-Reply-To: <Pine.LNX.4.33.0106070118320.22593-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ion Badulescu <ionut@cs.columbia.edu>:

> > 2.4.4-ac11 -- mostly works fine -- minor problems awaking from sleep
> 
> Can you run some performance testing with this driver, though? The
> speed
> of ftp transfers in both directions would be a good measure. The
> reason
> I'm asking is because we saw really poor performance on 100Mb
> full-duplex,
> something like 200-300KB/s when receiving.

OK, I did some simple FTP benchmarking, transferring a 100MB to and from my 
laptop connected to a Cisco Catalyst 6509.  The other systems were a PIII 
700Mhz UP with eepro100 NIC running 2.4.2-ac11, and a PIII 1Ghz SMP (2 proc) 
with Alteon Gigabit NIC running 2.2.19.

Transferring files between the eepro100 machine running 2.4.2-ac11 and my 
laptop produced a result of 2.24MB/s for sending and 2.13MB/s recieving the 
file.

Transfering files between the Alteon Gigabit machine running 2.2.19 and my 
laptop resulted in the dismal numbers of 249KB/s sending and 185KB/s recieving, 
close to the numbers you quoted above, but actually slightly worse.

I'm not sure what would explain the 2.2.19 1GB conencted box being 10x slower 
than the 2.4.2-ac11 100MB machine.

Transferring the same file between the two other boxes gives 9.81MB/s which is 
near the theoretical maximum for 100Mb.

> > 2.4.5-ac9 -- keeps logging "Link is absent" then "Linux is 100 mbit"
> over and
> > over when trying to pull an IP address via dhcp using pump or dhcpcd.
> 
> 
> pump likes to bring the interface up and down and up and down, so those
> 
> messages are not necessarily unusual.

Yea, I've actually complained of this before, the interface up/down things that 
pump does makes it very tough to use on a large network with full spanning tree 
as pump brings the interface down and up again right about the time spanning 
tree puts the port into forwarding mode.  I can get around this by setting 
Cisco's portfast feature, but doing that on all ports somewhat defeats the 
purpose of spanning tree and I move my laptop a lot.
 
> Hmm. I have an idea though. In set_half_duplex, we shouldn't touch the
> MII 
> if the new autoneg value is the same as the old one. It should certainly
> 
> help with things like pump. Arjan, what do you think?
> 
> > Interestingly manually setting an IP address seems to work fine with
> > this driver.
> 
> That's very good to know. So most likely the repeated up/down that
> pump's 
> doing is upsetting the card.

Commenting out the set_half_duplex made the driver in 2.4.5-ac9 work with DHCP 
again so your probably right.
 
I'll apply your patch with the change to MII handling and rerun some simple 
file transfers and report the results soon.

Thanks,
Tom

