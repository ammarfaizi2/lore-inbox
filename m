Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbTGBE45 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 00:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264696AbTGBE45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 00:56:57 -0400
Received: from air-2.osdl.org ([65.172.181.6]:12497 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264701AbTGBEzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 00:55:03 -0400
Date: Tue, 1 Jul 2003 22:09:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@digeo.com>
cc: Bernardo Innocenti <bernie@develer.com>, <linux-kernel@vger.kernel.org>,
       <torvalds@transmeta.com>
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
In-Reply-To: <20030701193250.1cbd4af9.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0307012206530.2047-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Jul 2003, Andrew Morton wrote:
> 
> By requiring an explicit do_div we are made aware of all those 64-bit
> divides and are made to think about them.

do_div() is NOT a 64-bit divide.

It's a 64/32->64+32 div/mod operation, which is a totally different thing
than a full 64/64 divide, and is usually much faster to compute on most 
32-bit architectures.

> Why 64-bit divides in particular were victimised in this manner is a matter
> for speculation ;)

Because gcc historically _cannot_ generate an efficient 64/32->64 divide. 
It ends up doing a full 64/64 divide thing.

		Linus

