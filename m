Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbUBRFa0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 00:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUBRFa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 00:30:26 -0500
Received: from terminus.zytor.com ([63.209.29.3]:29931 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263561AbUBRFaY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 00:30:24 -0500
Message-ID: <4032F861.3080304@zytor.com>
Date: Tue, 17 Feb 2004 21:30:09 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0402161141140.30742@home.osdl.org> <20040216202142.GA5834@outpost.ds9a.nl> <c0ukd2$3uk$1@terminus.zytor.com> <Pine.LNX.4.58.0402171910550.2686@home.osdl.org> <4032DA76.8070505@zytor.com> <Pine.LNX.4.58.0402171927520.2686@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402171927520.2686@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 17 Feb 2004, H. Peter Anvin wrote:
> 
>>Well, the reason you'd want an out-of-band mechanism is to be able to
>>display it as some kind of escapes. 
> 
> 
> I'd suggest just doing that when you convert the utf-8 format to printable 
> format _anyway_.  At that point you just make the "printable" 
> representation be the binary escape sequence (which you have to have for 
> other non-printable utf-8 characters anyway).
> 

What does "printable" mean in this context?  Typically you have to 
convert it to UCS-4 first, so you can index into your font tables, then 
you have to create the right composition, apply the bidirectional text 
algorithm, and so forth.

Rendering general Unicode text is complex enough that you really want it 
layered.  What I described what the first step of that -- mostly trying 
to show that "throwing an error" doesn't necessarily mean "produce no 
output."  What you shouldn't do, though, is alias it with legitimate input.

> And if you do things right (ie you allow user input in that same escaped 
> output format), you can allow users to re-create the exact "broken utf-8". 
> Which is actually important just so that the user can fix it up (ie 
> imagine the user noticing that the filename is broken, and now needs to do 
> a "mv broken-name fixed-name" - the user needs some way to re-create the 
> brokenness).

Indeed.  The C language has gone with \x77 for bytes and \u7777 or 
\U77777777 for Unicode characters (4 vs 8 hex digits respectively); I 
think this is a good UI for shells to follow.  The \x representation 
then doesn't stand for characters but for bytes.  It may be desirable to 
disallow encoding of *valid* UTF-8 characters this way, though.

	-hpa
