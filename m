Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUBRDbO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbUBRDbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:31:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:60391 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261928AbUBRDbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:31:11 -0500
Date: Tue, 17 Feb 2004 19:30:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
In-Reply-To: <4032DA76.8070505@zytor.com>
Message-ID: <Pine.LNX.4.58.0402171927520.2686@home.osdl.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
 <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.58.0402161141140.30742@home.osdl.org> <20040216202142.GA5834@outpost.ds9a.nl>
 <c0ukd2$3uk$1@terminus.zytor.com> <Pine.LNX.4.58.0402171910550.2686@home.osdl.org>
 <4032DA76.8070505@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, H. Peter Anvin wrote:
> 
> Well, the reason you'd want an out-of-band mechanism is to be able to
> display it as some kind of escapes. 

I'd suggest just doing that when you convert the utf-8 format to printable 
format _anyway_.  At that point you just make the "printable" 
representation be the binary escape sequence (which you have to have for 
other non-printable utf-8 characters anyway).

And if you do things right (ie you allow user input in that same escaped 
output format), you can allow users to re-create the exact "broken utf-8". 
Which is actually important just so that the user can fix it up (ie 
imagine the user noticing that the filename is broken, and now needs to do 
a "mv broken-name fixed-name" - the user needs some way to re-create the 
brokenness).

		Linus
