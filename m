Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272053AbTHRRGU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 13:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272118AbTHRRGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 13:06:20 -0400
Received: from [209.195.52.120] ([209.195.52.120]:54928 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S272053AbTHRRGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 13:06:18 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andreas Dilger <adilger@clusterfs.com>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, tytso@mit.edu, jmorris@intercode.com.au,
       linux-kernel@vger.kernel.org, davem@redhat.com
Date: Mon, 18 Aug 2003 10:03:58 -0700 (PDT)
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
In-Reply-To: <20030818115954.GA7147@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0308180956350.21012-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it depends on how strang your requirements are for uniqueness. worst case
you form your new ID and then check it against all others that have been
formed.

also it depends on if you are concerned about just the local machine or
global uniqueness.

if you are just concerned about the local machine you can just increment a
counter (with the appropriate locking and a large enough field to not
wrap)

if you care about global uniqueness then you add in config values that the
sysasmin sets to make it unique (could be MAC address, IP address, machine
name, GPS coordinates, etc)

the only reason to add in a random value is if you are trying to protect
yourself from a malicious sysadmin and there are security problems that
will arise for other machines if a sysadmin can duplicate this ID.

David Lang

 On Mon, 18 Aug 2003, Jamie Lokier wrote:

> Date: Mon, 18 Aug 2003 12:59:54 +0100
> From: Jamie Lokier <jamie@shareable.org>
> To: David Lang <david.lang@digitalinsight.com>
> Cc: Andreas Dilger <adilger@clusterfs.com>, Matt Mackall <mpm@selenic.com>,
>      Andrew Morton <akpm@osdl.org>, tytso@mit.edu, jmorris@intercode.com.au,
>      linux-kernel@vger.kernel.org, davem@redhat.com
> Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
>
> David Lang wrote:
> > > It wasn't even vanishingly small...  We had a problem in our code where
> > > two readers got the same 64-bit value calling get_random_bytes(), and
> > > we were depending on this 64-bit value being unique.  This problem was
> > > fixed by putting a spinlock around the call to get_random_bytes().
> >
> > if the number is truely random then there should be a (small but finite)
> > chance that any two reads will return the same data. counting on a random
> > number to be unique is not a good idea.
>
> The whole field of modern cryptography is based on things with a small
> but finite chance of failure.  The point is to mathematically engineer
> that chance to be _vanishingly_ small, such as probabilities like 2^-256.
>
> When the "random" number is 64 bits wide, the probability is so small
> that if you _do_ see two numbers the same you should be very
> suspicious.  But it is not so small to be out of the question.
>
> When you fetch 128 bits or more and see two numbers the same, then you
> should be very suspicious indeed.  But even that is not out of the
> question if you have many machines generating numbers night and day.
>
> At 256 bits, there is a real fault in your random number generator if
> you manage to generate two numbers the same.
>
> > now if you can repeatably get the same number then you probably have a bug
> > in the random number code, but if you need uniqueness you need something
> > else.
>
> Can you think of another, reliable, source of uniqueness?
>
> -- Jamie
>
