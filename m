Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131373AbRBAR5y>; Thu, 1 Feb 2001 12:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131350AbRBAR5p>; Thu, 1 Feb 2001 12:57:45 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51983 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131394AbRBAR5Y>; Thu, 1 Feb 2001 12:57:24 -0500
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
To: hch@caldera.de (Christoph Hellwig)
Date: Thu, 1 Feb 2001 17:58:09 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hch@caldera.de (Christoph Hellwig),
        sct@redhat.com (Stephen C. Tweedie), lord@sgi.com (Steve Lord),
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <20010201184950.A448@caldera.de> from "Christoph Hellwig" at Feb 01, 2001 06:49:50 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ONzo-0004kq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Linus basically designed the original kiobuf scheme of course so I guess
> > he's allowed to dislike it. Linus disliking something however doesn't mean
> > its wrong. Its not a technically valid basis for argument.
> 
> Sure.  But Linus saing that he doesn't want more of that (shit, crap,
> I don't rember what he said exactly) in the kernel is a very good reason
> for thinking a little more aboyt it.

No. Linus is not a God, Linus is fallible, regularly makes mistakes and
frequently opens his mouth and says stupid things when he is far too busy.

> Espescially if most arguments look right to one after thinking more about
> it...

I agree with the issues about networking wanting lightweight objects, Im
unconvinced however the existing setup for networking is sanely applicable
for real world applications in other spaces.

Take video capture. I want to stream 60Mbytes/second in multi-megabyte
chunks between my capture cards and a high end raid array. The array wants
1Mbyte or large blocks per I/O to reach 60Mbytes/second performance.

This btw isnt benchmark crap like most of the zero copy networking, this is
a real world application..

The current buffer head stuff is already heavier than the kio stuff. The
networking stuff isnt oriented to that kind of I/O and would end up
needing to do tons of extra processing.

> For disk I/O it makes the handling a little easier for the cost of the
> additional offset/length fields.

I remain to be convinced by that. However you do get 64bytes/cacheline on
a real processor nowdays so if you touch any of that 64byte block you are
practically zero cost to fill the rest. 

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
