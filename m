Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129041AbRBBBpP>; Thu, 1 Feb 2001 20:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129053AbRBBBpF>; Thu, 1 Feb 2001 20:45:05 -0500
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:60428 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S129041AbRBBBoz>; Thu, 1 Feb 2001 20:44:55 -0500
Message-ID: <001a01c08bf0$74c47d60$02c8a8c0@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Michael Pacey" <michael@wd21.co.uk>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20010201193250.B340@kermit.wd21.co.uk> <E14ORB4-000571-00@the-village.bc.nu> <20010201220624.E340@kermit.wd21.co.uk>
Subject: Re: 3Com 3c523 in IBM PS/2 9585: Can't load module in kernel 2.4.1
Date: Wed, 31 Jan 2001 20:44:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > eth0: memprobe, Can't find memory at 0xc0000!
> > > 3c523.c: No 3c523 cards found
> >
> > Yep. Most probably it needs munging to use isa_memcpy_fromio and the
like
> > or ioremap.
>
> Right... OK.... I'll leave that to someone else

I have patches that I believe fix this, but their own my box at home that I
can't get do right now.  When I get back from LinuxWorld tomorrow I'll pull
them off and post them.

> > Are you willing to be test victim for fixes ?
>
> Yes.
> And if you think the NFS problems might be fixable, I'll be pleased to
> keep the card out of the bucket.

My patches also include changes that should improve this, but I doubt it
will eliminate the problem.  The basic thing here is that it's a horrid card
in regards to performance and most of them only have 8K of buffer, it's just
too easy to overrun the buffer, especially since the default is to allocate
4 transmit and 1 receive buffer (or 6 receive buffers it your lucky enough
to have a 16K card).  Because of this the card drops packets like crazy,
which is bad for NFS, especially over UDP.  My patches basically change the
buffer allocation to only a single transmit buffer and whatever is left to
receive buffers, this puts the card in a different mode of operation which
seems to allow it to almost keep up.  For me, this made the card usable, I
still get drops, but their now much lower.

I'm not sure this is your problem, but I bet if you look at you ifconfig
stats when your having the problem you'll see lots of dropped packets.

Even if you don't use the card, it's be nice to have another user test it
out before I submit the patch.

Later,
Tom


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
