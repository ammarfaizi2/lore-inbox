Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbUAKEmR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 23:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265762AbUAKEmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 23:42:17 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:38380 "EHLO
	omta08.mta.everyone.net") by vger.kernel.org with ESMTP
	id S265756AbUAKEmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 23:42:16 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Sat, 10 Jan 2004 20:42:13 -0800 (PST)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: krealloc()
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.187.247]
Message-Id: <20040111044213.CCFAA725C@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why is there no krealloc()?  I'm not sure if I should just call mmap() inside the
kernel (any security hazzards or whatnot I should be worried about there?), but
it's going to be a pain to resize arrays.  realloc() is usually:

void *realloc(void *block, size_t size);

I'm thinking krealloc would be the same, since we'd have the old GFP_* flags and
the old size:

void *krealloc(void *block, size_t size);

Most realloc() implimentations grow or shrink in place, if possible.  If they can't,
or if that wasn't how they were coded, they allocate the new block, memcpy() over,
then free the old block.

I have nowhere near the skill or experience needed to impliment any sort of
krealloc(), so for now I'm going to have to do bad hacks in my code.  Can someone
please impliment a krealloc() by 2.6.2?  Or at least slate it for SOME time in the
future, if not immediately now.

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
