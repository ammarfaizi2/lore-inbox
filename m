Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVAAC57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVAAC57 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 21:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVAAC56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 21:57:58 -0500
Received: from [195.23.16.24] ([195.23.16.24]:48263 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262179AbVAAC5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 21:57:54 -0500
Message-ID: <1104548126.41d6111e3c47f@webmail.grupopie.com>
Date: Sat,  1 Jan 2005 02:55:26 +0000
From: "" <pmarques@grupopie.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Christoph Lameter <clameter@sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       Robin Holt <holt@sgi.com>, Adam Litke <agl@us.ibm.com>,
       "" <linux-ia64@vger.kernel.org>, "" <torvalds@osdl.org>,
       "" <linux-mm@vger.kernel.org>, "" <linux-kernel@vger.kernel.org>
Subject: Re: Increase page fault rate by prezeroing V1 [2/3]: zeroing and scrubd
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com> <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412211156090.1313@schroedinger.engr.sgi.com> <41D6094C.3040908@yahoo.com.au>
In-Reply-To: <41D6094C.3040908@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 82.154.89.203
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nick Piggin <nickpiggin@yahoo.com.au>:
> [...]
> Would you be better off to just have a driver->zero_me(...) call, with this
> logic pushed into those like your BTE which need it? I'm thinking this would
> help flexibility if you had say a BTE-thingy that did an interrupt on
> completion, or if it was done synchronously by the CPU with cache bypassing
> stores.

It seems that people in this discussion are assuming that PC's don't have
hardware to do this at all.

While there is no _official_ hardware, a bt878 with the brightness setting all
the way down, at 1024 pixels per line, 32 bits per pixel would be able to zero
a full physical page in under 60 microseconds (PAL scanline). It could even
zero a _list_ of pages passed to it and generate an interrupt in the end.

This is just an example, and there might be some problems in the implementation
details that make it impossible to work, but there might also be more hardware
out there that could perform similar functions (graphics cards?).

This might not be worth the bother *at all*, but I can imagine some weird
conversation between two sysadmins:
  "My server is wasting a lot of time handling page faults"
  "Why don't you install a video aquisition board with a bt878 chip? It did
wonders on my server"
  "Yes, I've also weard that a radeon graphics card can really accelerate kernel
compiles"

Well, just my 0.02 euro :)

--
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu

