Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268000AbUBRUKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268003AbUBRUKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:10:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20229 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S268000AbUBRUJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:09:05 -0500
Message-ID: <4033C63F.5020502@zytor.com>
Date: Wed, 18 Feb 2004 12:08:31 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0402161141140.30742@home.osdl.org> <20040216202142.GA5834@outpost.ds9a.nl> <c0ukd2$3uk$1@terminus.zytor.com> <Pine.LNX.4.58.0402171910550.2686@home.osdl.org> <20040218113338.GH28599@mail.shareable.org> <Pine.LNX.4.58.0402181154290.2686@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402181154290.2686@home.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> But that's what you _want_. Having a real out-of-band signal that says 
> "this stuff is wrong, because it was wrong at some point in the past", and 
> not allowing concatenation of blocks of utf-8 bytes would be _bad_.
> 

Indeed.  What it does mean, however, is that you have to consider your
concatenation issues if you perform the concatenation in UCS-4 space,
for example, a string that ends in whatever code you have chosen for
<BOGUS-C8> that gets concatenated with <BOGUS-80> needs to get converted
to a valid <U+0200>.  This is of course not an issue if you do the
concatenation in UTF-8 space and don't do round-trip conversion.

None of this is hard, it just takes thinking about rather than
automatically do the obvious things.

> The thing, concatenating two malformed UTF-8 strings is normal behaviour 
> in a variety of circumstances, all basically having to do with lower 
> levels now knowing about higer-level concepts.

Indeed.

	-hpa

