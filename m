Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUBQTv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUBQTv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:51:58 -0500
Received: from mail.shareable.org ([81.29.64.88]:65412 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266560AbUBQTvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:51:54 -0500
Date: Tue, 17 Feb 2004 19:51:31 +0000
From: Jamie Lokier <jamie@shareable.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, Marc <pcg@goof.com>,
       Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040217195131.GB24311@mail.shareable.org>
References: <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217163613.GA23499@mail.shareable.org> <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk> <20040217192917.GA24311@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217192917.GA24311@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Understand, this isn't a kernel problems; it is simply a good reason
> to reject malformed UTF-8 by programs which parse UTF-8.

I should make clear: since the kernel _doesn't_ parse UTF-8, the
kernel _isn't_ an appropriate place to reject it.

Any userspace program which treats the result of readdir() as UTF-8
characters for any purpose should reject malformed names.  The tough
design decisions are: where in the program to do it, and how to ensure
it will always be done.

You have to reject or escape malformed names at _some_ stage when they
are going to appear in a text context.  The trouble is doing it too
soon (where the program calls readdir()) prevents operating on some
files, and doing it later (where the program is going to use it in a
text context) is easy to forget because by the time a string from
readdir() has travelled through many layers of abstraction between
libraries, it's easy to forget its byteish properties.

-- Jamie
