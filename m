Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265985AbUBPWya (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265984AbUBPWy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:54:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:41345 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265989AbUBPWxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:53:19 -0500
Date: Mon, 16 Feb 2004 14:52:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Marc Lehmann <pcg@schmorp.de>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
 JFS default behavior)
In-Reply-To: <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0402161447450.30742@home.osdl.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
 <200402150006.23177.robin.rosenberg.lists@dewire.com>
 <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk>
 <200402150107.26277.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de>
 <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de>
 <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org>
 <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Feb 2004, Linus Torvalds wrote:
> 
> Which, if you think about is, is 100% EXACTLY equivalent to what a UTF-8
> program should do when it sees broken UTF-8. It can still access the file, 
> it can still do everything else with it, but it can't print out the 
> filename, and it should use some kind of escape sequence to show that 
> fact.

Side note: a UTF-8 program needs to do escape handling _anyway_, because 
even if the filename is 100% UTF-8 compliant, you still can't print out 
all the characters as such. In particular, charcters like '\n' etc are 
obviously perfectly fine UTF-8, yet they need to be escaped when printing 
out filenames in a file selector.

So I claim (and yes, people are free to disagree with me) that a
well-written UTF-8 program won't even have any real extra code to handle
the "broken UTF-8" code. It's just another set of bytes that needs
escaping, and they need escaping for _exactly_ the same reason some 
regular utf-8 characters need escaping: because they can't be printed.

So it's all the same thing - it's just the reasons for "unprintability"  
that are slightly different.

Now, I'll agree that getting the escaping right (whether for things like 
'\n' or for byte sequences that are invalid UTF-8) can be painful. I just 
don't think that the pain is in any way specific for "invalid UTF-8". It's 
just _hard_ to think of all the special cases, and most programs have bugs 
because somebody forgot something.

		Linus
