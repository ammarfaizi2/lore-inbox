Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265791AbUBPT1U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 14:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265816AbUBPT1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 14:27:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60546 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265791AbUBPT1G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 14:27:06 -0500
Message-ID: <4031197C.1040909@pobox.com>
Date: Mon, 16 Feb 2004 14:26:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Lehmann <pcg@schmorp.de>
CC: Linus Torvalds <torvalds@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402161040310.30742@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> In short: filenames are byte streams. Nothing more. They don't even have a 
> "character set". They literally are just a series of bytes.
> 
> And when I say that you have to talk to the kernel using UTF-8, I'm only 
> claiming that it is the only sane way to encode extended characters in a 
> byte stream. Nothing more.


Nod.  Maybe it helps Marc to point out the key difference between 
characters and bytes, in UTF8.

In UTF8, the number of characters in a string is less-than-or-equal-to 
the number of bytes in the string.

And the kernel just cares about bytes.

This is the whole benefit to UTF8, right here in this thread.  UTF8 was 
designed such that ten-year-old C code using standard C strings would 
function just fine.  No need to rip up large swaths of your code just to 
call multi-byte versions of the standard string functions.  Most code 
that doesn't deal with locale-specific details like uppercase/lowercase 
Just Works(tm).

	Jeff



