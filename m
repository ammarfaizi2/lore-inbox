Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266546AbUBQVE0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266572AbUBQVE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:04:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:13251 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266546AbUBQVEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:04:24 -0500
Date: Tue, 17 Feb 2004 13:04:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: John Bradford <john@grabjohn.com>
cc: Jamie Lokier <jamie@shareable.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Marc <pcg@goof.com>, Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
 JFS default behavior)
In-Reply-To: <200402172050.i1HKoLPG000210@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.58.0402171259440.2154@home.osdl.org>
References: <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
 <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
 <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
 <20040217163613.GA23499@mail.shareable.org> <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk>
 <20040217192917.GA24311@mail.shareable.org> <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk>
 <200402172035.i1HKZM4j000154@81-2-122-30.bradfords.org.uk>
 <20040217204024.GE24311@mail.shareable.org> <200402172050.i1HKoLPG000210@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, John Bradford wrote:

> > Ok, but... why?  What does 32-bit words get you that UTF-8 does not?
> > I can't think of a single advantage, just lots of disadvantages.
> 
> The advantage is that you can use them to store UCS-4.

Wrong. UTF-8 can store UCS-4 characters just fine.

Admittedly you might need up to six octets for the worst case, but hey, 
since you only need one for the most common case (by _far_), who cares?

And with the same UTF-8 encoding, you could some day encode UCS-8 too if
the idiotic standards bodies some day decide that 4 billion characters 
isn't enough because of all the in-fighting. 

> Now, for file _contents_ this would be a compatibility disaster, which
> is why UTF-8 is so convenient, but for file_names_ UCS-4 lets you
> unambiguously represent any string of Unicode characters.

Why do you think UTF-8 can't do this? Did you read some middle-aged text
written by monks in a monestary that said that UTF-8 encodes a 16-bit
character set?

> Basically - no more multiple representations of the same thing.  No more
> funny corner cases where several different strings of bytes eventually
> resolve to the same name being presented to the user.

Welcome to normalized UTF-8. And realize that the "non-normalized" broken 
stuff is what allows us backwards compatibility.

Of course, since you like UCS-4, you don't care about backwards 
compatibility. 

			Linus
