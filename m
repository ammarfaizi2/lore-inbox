Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131630AbRA0Azo>; Fri, 26 Jan 2001 19:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131732AbRA0Az0>; Fri, 26 Jan 2001 19:55:26 -0500
Received: from cs.columbia.edu ([128.59.16.20]:40447 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S131630AbRA0AzK>;
	Fri, 26 Jan 2001 19:55:10 -0500
Date: Fri, 26 Jan 2001 16:55:05 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: "David S. Miller" <davem@redhat.com>
cc: <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
In-Reply-To: <Pine.LNX.4.30.0101261217260.20615-100000@age.cs.columbia.edu>
Message-ID: <Pine.LNX.4.30.0101261648280.20615-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001, Ion Badulescu wrote:

> Besides, I've done some more testing last night, and there are some
> problems. The FP doesn't seem to like tinygrams too much, every once in a
> while (but *not* always) it decides to send one with a bad checksum. I'm
> talking especially about telnet tinygrams, where the second fragment is 1
> byte. What's worse, it will also resend it with a bad checksum,
> effectively killing the connection.
>
> Could this be a bug in the upper layers, instead? How would I go about to
> verify this? The only way I can think of is to verify that the checksum
> field is zero initially, correct?

[...]

> So I want to try and switch the transmit descriptor to the one used by
> Netware, maybe the firmware was only tested with that descriptor. It also
> fits the new Linux model a bit better, as it has one descriptor per
> packet, not one per fragment (like the current implementation).

So, I've re-implemented the Tx code to use the type0 Tx descriptor, and
the code is definitely cleaner. However, the card still has an issue with
tinygrams. A TCP packet whose second fragment is 1-byte long usually goes
over the wire with the wrong checksum. If the second fragment is 3-byte
long, it is checksummed correctly (so it's not an even/odd problem).

Any ideas? Is there even the slightest chance that something might not be
ok in the skb received from above?

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
