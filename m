Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBHLxc>; Thu, 8 Feb 2001 06:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129031AbRBHLxW>; Thu, 8 Feb 2001 06:53:22 -0500
Received: from cs.columbia.edu ([128.59.16.20]:41360 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129032AbRBHLxN>;
	Thu, 8 Feb 2001 06:53:13 -0500
Date: Thu, 8 Feb 2001 03:53:10 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Augustin Vidovic <vido@ldh.org>
cc: Alan Cox <alan@redhat.com>, Andrey Savochkin <saw@saw.sw.com.sg>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eepro100.c, kernel 2.4.1
In-Reply-To: <20010208204415.A19308@ldh.org>
Message-ID: <Pine.LNX.4.30.0102080346150.31024-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Augustin Vidovic wrote:

> This suppression of thousands of lines was described as a DOS-protection
> in the docs I read.

Still, there should be something before these suppressed messages started.

> With my patch, the test becomes (eeprom[3] & 0x03), which is not null
> for every possible non-null value of the two lower bits :
> 
> 	bit1	bit0	[bit1,bit0]&[1,1]
> 	0	0	00
> 	0	1	01
> 	1	0	10
> 	1	1	11
> 
> Whereas the other test is more restrictive, because it excludes the "11"
> from the results.
> The old cards still get the workaround enabled this this wider test.

No, they don't.

It goes like this:

bit0 = 1 means the workaround may be omitted when operating at 10 Mbit
bit1 = 1 means the workaround may be omitted when operating at 100 Mbit

So the workaround needs to be activated when at least one bit is zero, and 
may be omitted when both bits are 1. That's exactly what the original code 
does.

> > So your patch did not do you any good. Case closed, as far as the work-around
> > is concerned.
> 
> To the contrary, it seems to do a lot of good, because the NET subsystem
> does not send any more panic messages to the kernel, and the cluster has
> not meltdown again so far.

"Yesterday, a brick fell upon my head while I was walking on the street. 
Today, I put my hat on before leaving home, and no brick fell on my head 
anymore. So the hat must have helped!"

Please read the code if you don't believe me.


Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
