Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbUBRDOC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUBRDOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:14:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:54747 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262055AbUBRDN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:13:59 -0500
Date: Tue, 17 Feb 2004 19:13:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
In-Reply-To: <c0ukd2$3uk$1@terminus.zytor.com>
Message-ID: <Pine.LNX.4.58.0402171910550.2686@home.osdl.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
 <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.58.0402161141140.30742@home.osdl.org> <20040216202142.GA5834@outpost.ds9a.nl>
 <c0ukd2$3uk$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004, H. Peter Anvin wrote:
> 
> Those of us who have been involved with the issue have fought
> *extremely* hard against DWIM decoders which try to decode the latter
> sequences into ".." -- it's incorrect, and a security hazard.  The
> only acceptable decodings is to throw an error, or use an out-of-band
> encoding mechanism to denote "bad bytecode."

Somebody correctly pointed out that you do not need any out-of-band 
encoding mechanism - the very fact that it's an invalid sequence is in 
itself a perfectly fine flag. No out-of-band signalling required.

The only thing you should make sure of is to not try to normalize it (that 
would hide the error). Just keep carrying the bad sequence along, and 
everybody is happy. Including the filesystem functions that get the "bad" 
name and match it exactly to what it should be matched against.

		Linus
