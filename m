Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266323AbUBQQg2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 11:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUBQQg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 11:36:28 -0500
Received: from mail.shareable.org ([81.29.64.88]:56452 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266323AbUBQQgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 11:36:24 -0500
Date: Tue, 17 Feb 2004 16:36:13 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marc <pcg@goof.com>, Marc Lehmann <pcg@schmorp.de>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040217163613.GA23499@mail.shareable.org>
References: <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Which flies in the face of "Be strict in what you generate, be liberal in 
> what you accept". A lot of the functions are _not_ willing to be liberal 
> in what they accept. Which sometimes just makes the problem worse, for no 
> good reason.

Unicode specifies that a program claiming to read UTF-8 _must_ reject
malformed UTF-8.

Ok, we can just ignore Unicode. :)

But the reason they cite is security: when applications allow
malformed UTF-8 through, there's plenty of scope for security holes
due to multiple encodings of "/" and "." and "\0".

This is a real problem: plenty of those Windows worms that attack web
servers get in by using multiple-escaped funny characters and
malformed UTF-8 to get past security checks for ".." and such.

In theory these are not problems; all programs should be liberal in
what they accept, and robust in handling data from the outside world.

In practice, programs quickly lose track of which text is from the
outside world and which is from a trusted source or checked source.
These worms are quite successful at exploiting things the programmers
didn't think of.  Being _conservative_ at all places which scan UTF-8
does seem like it might help a little.

-- Jamie
