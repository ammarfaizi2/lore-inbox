Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWBJQUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWBJQUK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWBJQUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:20:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28373 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932110AbWBJQUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:20:08 -0500
Date: Fri, 10 Feb 2006 08:19:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
In-Reply-To: <43EC8A06.40405@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0602100815580.19172@g5.osdl.org>
References: <20060209071832.10500.qmail@science.horizon.com>
 <20060209001850.18ca135f.akpm@osdl.org> <43EAFEB9.2060000@yahoo.com.au>
 <20060209004208.0ada27ef.akpm@osdl.org> <43EB3801.70903@yahoo.com.au>
 <20060209094815.75041932.akpm@osdl.org> <43EC0A44.1020302@yahoo.com.au>
 <20060209195035.5403ce95.akpm@osdl.org> <43EC0F3F.1000805@yahoo.com.au>
 <20060209201333.62db0e24.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au>
 <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au>
 <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au>
 <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au>
 <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au>
 <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au>
 <20060209231432.03a09dee.akpm@osdl.org> <43EC8A06.40405@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Feb 2006, Nick Piggin wrote:
> 
> It may be a very useful operation in kernel, but I think userspace either
> wants to definitely know the data is on disk (WRITE_SYNC), or give a hint
> to start writing (WRITE_ASYNC).

Only from a _stupid_ user standpoint.

The fact is, "start writing and wait for the result" is fundamentally a 
totally broken operation.

Why?

Because a smart user actually would want to do

 - start writing this
 - start writing that
 - start writing that-other-thing
 - wait for them all.

The reason synchronous write performance is absolutely disgusting is 
exactly that people think "start writing" should be paired up with "wait 
for it".

So the kernel internally separates "start writing" and "wait for it" for 
very good reasons. Reasons that in no way go away just because you use to 
user space.

And yes, there very much is a third operation too: "mark dirty". That's 
the _common_ one. That's the fundamental one. That's the one that we use 
every single day, without even realizing. The "start writing" and "wait 
for it" operations are actually the rare ones.

		Linus
