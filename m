Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268291AbTCFT50>; Thu, 6 Mar 2003 14:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268294AbTCFT50>; Thu, 6 Mar 2003 14:57:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15109 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268291AbTCFT5Z>; Thu, 6 Mar 2003 14:57:25 -0500
Date: Thu, 6 Mar 2003 12:05:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: HT and idle = poll
In-Reply-To: <Pine.LNX.4.50.0303061150250.1670-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.44.0303061204120.8404-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Davide Libenzi wrote:
> 
> Not only. The polling CPU will also shoot a strom of memory requests,
> clobbering the CPU's memory I/O stages.

Well, that would only be true with a really crappy CPU with no caches.

Polling the same location (as long as it's a pure poll, not trying to do 
some locked read-modify-write cycle) should be fine. At least for 
something like idle-polling, where the one location it _is_ polling should 
not actually be touched by anybody else until the wakeup actually happens.

		Linus

