Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266841AbUBQXVo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266866AbUBQXUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:20:49 -0500
Received: from dp.samba.org ([66.70.73.150]:50358 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266841AbUBQXUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:20:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16434.39473.822318.998268@samba.org>
Date: Wed, 18 Feb 2004 09:48:17 +1100
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <16433.53708.264048.307137@notabene.cse.unsw.edu.au>
References: <16433.38038.881005.468116@samba.org>
	<Pine.LNX.4.58.0402162034280.30742@home.osdl.org>
	<16433.47753.192288.493315@samba.org>
	<16433.53708.264048.307137@notabene.cse.unsw.edu.au>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil,

 > I thought the value of a case-insensitive filenames was for
 > legacy applications which have been written to the WIN32 API and took
 > lots of liberties with "pretty-casing" filenames between readdir and
 > open. 

No, thats a common misconception. It does happen (the "pretty-casing")
but its relatively rare these days. The real problem is *proving* that
a file doesn't exist. If a file does exist then there are all sorts of
heuristic and cache mechanisms that can be used to get the real
filename quickly on average, but if you have to prove absolutely that
a file does not exist then all of that stuff is pretty much useless.

Samba (and any other system that wants case-insensitive semantics on
Linux) can't make do with "oh, it probably doesn't exist". That way
leads to data loss. You have to know with 100% certainty that the file
doesn't exist in any case combination.

Unfortunately, that is also the hardest thing to do.

Cheers, Tridge
