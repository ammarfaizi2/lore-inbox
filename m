Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbTJQILA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 04:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbTJQILA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 04:11:00 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2688 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263336AbTJQIK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 04:10:58 -0400
Date: Fri, 17 Oct 2003 09:11:22 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310170811.h9H8BMpV000171@81-2-122-30.bradfords.org.uk>
To: Eric Sandall <eric@sandall.us>, linux-kernel@vger.kernel.org
In-Reply-To: <1066355235.3f8f4a2395fa0@horde.sandall.us>
References: <1066163449.4286.4.camel@Borogove>
 <20031015133305.GF24799@bitwizard.nl>
 <3F8D6417.8050409@pobox.com>
 <20031016162926.GF1663@velociraptor.random>
 <20031016172930.GA5653@work.bitmover.com>
 <20031016174927.GB25836@speare5-1-14>
 <20031016230448.GA29279@pegasys.ws>
 <20031017013245.GA6053@ncsu.edu>
 <1066355235.3f8f4a2395fa0@horde.sandall.us>
Subject: Re: Transparent compression in the FS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > But at the same time we rely on TCP/IP which uses a hash (checksum)
> > to detect back packets.  It seems to work well in practice even
> > though the hash is weak and the network corrupts a lot of packets.
> > 
> > Lots of machines dont have ECC ram and seem to work reasonably well.
> > 
> > It seems like these two are a lot more likely to bit you than hash
> > collisions in MD5.  But Ill have to go read the paper to see what
> > Im missing.
> 
> It doesn't really matter that the hash collision is /less/ likely to ruin data
> than something in hardware as it adds an /extra/ layer of possible corruption,
> so you have a net gain in the possible corruption of your data.  Now, if you
> could write it so that there was /no/ possibility of data corruption, than it
> would be much more acceptable as it wouldn't add any extra likeliness of
> corruption than already exists.

Comparing the reliability of the hash function to the reliability of
hardware is an apples to oranges comparison.  Far more interesting
would be to compare the correlation between reliability of each of
them to the input data.

I.E.:

The hash function scores 100% on this - certain patters will _always_
trigger a fault.  Once you find a way to make it corrupt data, it will
be 100% reproducable using the same dataset.

The hardware will typically score less than 100% - certain patterns of
data in memory are more likely to make a weak RAM chip flip a bit, we
have seen many examples of that where a machine dies quickly running
memtest86, but will run Linux apparently fine for at least a while.
However, other things such as the temperature affect this.  It's rare
to find a memory access pattern that will 100% reliably lock up a
machine in exactly the same way.

John.
