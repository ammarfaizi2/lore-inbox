Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266583AbUBQUwZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUBQUwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:52:24 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:9600 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266583AbUBQUvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:51:14 -0500
Date: Tue, 17 Feb 2004 20:50:21 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402172050.i1HKoLPG000210@81-2-122-30.bradfords.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Linus Torvalds <torvalds@osdl.org>,
       Marc <pcg@goof.com>, Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040217204024.GE24311@mail.shareable.org>
References: <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
 <20040216222618.GF18853@mail.shareable.org>
 <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
 <20040217071448.GA8846@schmorp.de>
 <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
 <20040217163613.GA23499@mail.shareable.org>
 <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk>
 <20040217192917.GA24311@mail.shareable.org>
 <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk>
 <200402172035.i1HKZM4j000154@81-2-122-30.bradfords.org.uk>
 <20040217204024.GE24311@mail.shareable.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Jamie Lokier <jamie@shareable.org>:
> John Bradford wrote:
> > However, I don't see why it is any more logical to make the suggestion
> > that filenames generally be treated as UTF-8, IFF they are text at
> > all, than it is to suggest that filename should be arbitrary strings
> > of 32-bit words.
> 
> Ok, but... why?  What does 32-bit words get you that UTF-8 does not?
> I can't think of a single advantage, just lots of disadvantages.

The advantage is that you can use them to store UCS-4.

Now, for file _contents_ this would be a compatibility disaster, which
is why UTF-8 is so convenient, but for file_names_ UCS-4 lets you
unambiguously represent any string of Unicode characters.  Basically -
no more multiple representations of the same thing.  No more funny
corner cases where several different strings of bytes eventually
resolve to the same name being presented to the user.

Of course, there is still the issue where the same glyphs could be
displayed on the screen for two files, for example, one called
"vertical bar", and the other one called "pipe", which is confusing,
but that's a _completely_ different issue.

As far as I can see, storing all filenames as either 7-bit ASCII or
flat UCS-4 simply eliminates the whole lot of security issues you're
thinking of.  If you never use non 7-bit ASCII, legacy applications
continue to work exactly as before.

John.
