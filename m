Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268162AbUBRVbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 16:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268166AbUBRVbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 16:31:25 -0500
Received: from dp.samba.org ([66.70.73.150]:17561 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S268162AbUBRVbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 16:31:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16435.55700.600584.756009@samba.org>
Date: Thu, 19 Feb 2004 08:31:00 +1100
To: Linus Torvalds <torvalds@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <Pine.LNX.4.58.0402171919240.2686@home.osdl.org>
References: <16433.38038.881005.468116@samba.org>
	<16433.47753.192288.493315@samba.org>
	<Pine.LNX.4.58.0402170704210.2154@home.osdl.org>
	<16434.41376.453823.260362@samba.org>
	<c0uj52$3mg$1@terminus.zytor.com>
	<Pine.LNX.4.58.0402171859570.2686@home.osdl.org>
	<4032D893.9050508@zytor.com>
	<Pine.LNX.4.58.0402171919240.2686@home.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

 > The thing is, I do agree with Tridge on one simple fact: it's very hard 
 > indeed to do atomic file operations from user space.

I'm glad I'm making progress :)

The second basic fact that I think is relevant is that its not
possible to do case-insensitive filesystem operations efficiently
without the filesystem having knowledge of the fact that you want a
case-insensitive lookup.

The reason for this is that modern filesystems do much better than an
O(n) linear scan for lookups in directories. They use a hash, or a
tree or whatever you like to take advantage of an ordering function on
the names in the directory. The days of linear scans in directories
are fast dwindling.

The only way you are going to avoid the linear scan for a
case-insensitive lookup is to make that ordering function
case-insensitive. The question really is whether we are willing to pay
the price in terms of complexity for doing that. I've tried to make
the claim in this thread that the code complexity cost of doing this
isn't really all that high, but it is definately non-zero.

So your magic_open() proposal would probably be a help, and would
certainly reduce the amount of code we would need in userspace, but it
doesn't change the fundamental linear scan of directories problem at
all. 

That doesn't mean I won't take you up on the magic_open() proposal,
it's just that I'd need to try it to see if its a sufficient win to
justify using it given the limitations.

Cheers, Tridge
