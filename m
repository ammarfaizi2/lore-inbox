Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264472AbRFOS3t>; Fri, 15 Jun 2001 14:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264477AbRFOS3k>; Fri, 15 Jun 2001 14:29:40 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:17927 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264472AbRFOS3b>;
	Fri, 15 Jun 2001 14:29:31 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106151829.f5FITGp162144@saturn.cs.uml.edu>
Subject: Re: Client receives TCP packets but does not ACK
To: mblack@csihq.com (Mike Black)
Date: Fri, 15 Jun 2001 14:29:16 -0400 (EDT)
Cc: robert@kleemann.org (Robert Kleemann), linux-kernel@vger.kernel.org
In-Reply-To: <025c01c0f598$f04d0f30$e1de11cc@csihq.com> from "Mike Black" at Jun 15, 2001 08:44:36 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Black writes:

> I'm concerned that you're probably just overruning your IP stack:
...
> TCP is NOT a guaranteed protocol -- you can't just blast data from one port
> to another and expect it to work.

Yes you can. This is why we have TCP in fact.

> a tcp-write is NOT guaranteed -- and as you've seen -- a recv() isn't either
> (that's why you need timeouts).
> You're probably overrunning the tcp buffer on your "print" statement and
> truncating a block.
> I don't see where you're checking for        EAGAIN or EWOULDBLOCK (see man
> send).

You do have to check for partial writes due to the UNIX API.
Then check for EAGAIN and EINTR at least.

> You need a layer-7 protocol that will guarantee your transactions -- once
> you're client acks/naks your server I'll bet everything works hunky-dory.
> If you're not familiar with the OSI model
> http://www.csihq.com/~mike/students/networking/iso/isomodel.html

You don't need that crap. TCP/IP doesn't even fit the OSI model,
and we're missing much of the OSI stack AFAIK. (Do we have that
thing with 10-byte addresses? I think not.)
