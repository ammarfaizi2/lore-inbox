Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbUBRDIW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUBRDIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:08:22 -0500
Received: from hera.kernel.org ([63.209.29.2]:43144 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262603AbUBRDIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:08:17 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Date: Wed, 18 Feb 2004 03:07:48 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c0uku4$43t$1@terminus.zytor.com>
References: <200402150107.26277.robin.rosenberg.lists@dewire.com> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217163613.GA23499@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1077073668 4222 63.209.29.3 (18 Feb 2004 03:07:48 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 18 Feb 2004 03:07:48 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040217163613.GA23499@mail.shareable.org>
By author:    Jamie Lokier <jamie@shareable.org>
In newsgroup: linux.dev.kernel
>
> Linus Torvalds wrote:
> > Which flies in the face of "Be strict in what you generate, be liberal in 
> > what you accept". A lot of the functions are _not_ willing to be liberal 
> > in what they accept. Which sometimes just makes the problem worse, for no 
> > good reason.
> 
> Unicode specifies that a program claiming to read UTF-8 _must_ reject
> malformed UTF-8.
> 
> Ok, we can just ignore Unicode. :)
> 
> But the reason they cite is security: when applications allow
> malformed UTF-8 through, there's plenty of scope for security holes
> due to multiple encodings of "/" and "." and "\0".
> 
> This is a real problem: plenty of those Windows worms that attack web
> servers get in by using multiple-escaped funny characters and
> malformed UTF-8 to get past security checks for ".." and such.
> 

Actually, the kernel is 100% compliant in that respect.

The only byte sequences the kernel interpret:

00
2E
2E 2E
2F

.. and it correctly rejects (in the sense that it doesn't alias) any
other possible byte stream that could be interpreted as the same
sequences by a naïvely incorrect UTF-8 encoder.

	-hpa
