Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131436AbRA0SkO>; Sat, 27 Jan 2001 13:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbRA0SkE>; Sat, 27 Jan 2001 13:40:04 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:20488 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131436AbRA0Sj5>;
	Sat, 27 Jan 2001 13:39:57 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101271839.VAA02790@ms2.inr.ac.ru>
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
To: ionut@cs.columbia.edu (Ion Badulescu)
Date: Sat, 27 Jan 2001 21:39:44 +0300 (MSK)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101261648280.20615-100000@age.cs.columbia.edu> from "Ion Badulescu" at Jan 26, 1 04:55:05 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> verify this? The only way I can think of is to verify that the checksum
> field is zero initially, correct?

It is not zero. It contains checksum of pseudoheader.


> fits the new Linux model a bit better, as it has one descriptor per
> packet, not one per fragment (like the current implementation).

Yes. Absence of such mode with acenic is big pain in ass.


> tinygrams. A TCP packet whose second fragment is 1-byte long usually goes
> over the wire with the wrong checksum. If the second fragment is 3-byte
> long, it is checksummed correctly (so it's not an even/odd problem).

Seems, this is pretty common bug. At least, perfect checksumming
of chunks with any size and alignment is so big boast of
alteon people, that it is clearly rather exception than rule. 8)8)

I think you have to check for wrong combination of alignment/size and
to call skb_checksum_help() and to disable checksumming if combination
is bad.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
