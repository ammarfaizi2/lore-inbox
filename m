Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSD2PYJ>; Mon, 29 Apr 2002 11:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSD2PYJ>; Mon, 29 Apr 2002 11:24:09 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:20428 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S312558AbSD2PYH>;
	Mon, 29 Apr 2002 11:24:07 -0400
Date: Mon, 29 Apr 2002 11:24:04 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: Andi Kleen <ak@suse.de>
Cc: Bryan Rittmeyer <bryan@ixiacom.com>, <warchild@spoofed.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: remote memory reading using arp?
In-Reply-To: <p73znzom2kv.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.33L2.0204291121420.26604-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Apr 2002, Andi Kleen wrote:

> Bryan Rittmeyer <bryan@ixiacom.com> writes:
>
> > It's not the ARP layer that's causing the padding... Ethernet has a
> > minimum transmit size of 64 bytes (everything below that is disgarded
> > by hardware as a fragment), so the network device driver or
> > the hardware itself will pad any Linux skb smaller than 60 bytes up to
> > that size (so that it's 64 bytes after appending CRC32). Apparently, in
> > some cases that's done by just transmitting whatever uninitialized
> > memory follows skb->data, which, after the system has been running
> > for a while, may be inside a page previously used by userspace.
>
> The driver should be fixed in that case. I would consider it a driver
> bug. The cost of clearing the tail should be minimal, it is at most

Yes, I wholeheartedly agree.  Also, the notion that it's userspace's
responsibility to clear memory before exiting is preposterous.  That would
involve just about every piece of software ever made to be rewritten (you
could change glibc to clear memory on free()s but what about the stack?).


> two cache lines.
>
> Is it known which driver caused this?
>
> >
> > This is NOT a "remote memory reading" exploit, since there is no way to
>
> It really is.

Yes.  If you snoop long enough, it becomes possible to read passords and
other sensitive data.  Granted, this is only on the local network, but
it is still a major hole.

>
>
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

