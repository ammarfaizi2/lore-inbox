Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266023AbUBQGG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 01:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266029AbUBQGGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 01:06:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:30124 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266023AbUBQGGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 01:06:53 -0500
Date: Mon, 16 Feb 2004 22:06:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: vrajesh@umich.edu, linux-kernel@vger.kernel.org, Linux-MM@kvack.org
Subject: Re: [PATCH] mremap NULL pointer dereference fix
In-Reply-To: <20040216220031.16a2c0c7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0402162203230.2154@home.osdl.org>
References: <Pine.SOL.4.44.0402162331580.20215-100000@blue.engin.umich.edu>
 <Pine.LNX.4.58.0402162127220.30742@home.osdl.org>
 <Pine.LNX.4.58.0402162144510.30742@home.osdl.org> <20040216220031.16a2c0c7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Feb 2004, Andrew Morton wrote:
> 
> This saves a goto.   It works, but I wasn't able to trigger
> the oops without it either.

To trigger the bug you have to have _just_ the right memory usage, I 
suspect. You literally have to have the destination page directory 
allocation unmap the _exact_ source page (which has to be clean) for the 
bug to hit. 

So I suspect the oops only triggers on the machine that the trigger
program was written for.

Your version of the patch saves a goto in the source, but results in an 
extra goto in the generated assembly unless the compiler is clever enough 
to notice the double test for NULL.

Never mind, that's a micro-optimization, and your version is cleaner. 
Let's go with it if Rajesh can verify that it fixes the problem for him.

Rajesh?

		Linus
