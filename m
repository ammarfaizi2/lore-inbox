Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266967AbUBRWuf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267163AbUBRWue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:50:34 -0500
Received: from dp.samba.org ([66.70.73.150]:6111 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267150AbUBRWuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:50:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16435.60448.70856.791580@samba.org>
Date: Thu, 19 Feb 2004 09:50:08 +1100
To: Linus Torvalds <torvalds@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <Pine.LNX.4.58.0402181427230.2686@home.osdl.org>
References: <16433.38038.881005.468116@samba.org>
	<16433.47753.192288.493315@samba.org>
	<Pine.LNX.4.58.0402170704210.2154@home.osdl.org>
	<16434.41376.453823.260362@samba.org>
	<c0uj52$3mg$1@terminus.zytor.com>
	<Pine.LNX.4.58.0402171859570.2686@home.osdl.org>
	<4032D893.9050508@zytor.com>
	<Pine.LNX.4.58.0402171919240.2686@home.osdl.org>
	<16435.55700.600584.756009@samba.org>
	<Pine.LNX.4.58.0402181422180.2686@home.osdl.org>
	<Pine.LNX.4.58.0402181427230.2686@home.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

 > And I bet the performance advantages of _not_ doing native case 
 > insensitivity are likely to dominate hugely.

This part I just don't understand at all. The proposed changes would
be extremely cheap performance wise as you are just replacing one hash
with another, and dealing with one extra context bit in the
dcache. There is no way that this could come anywhere near the cost of
doing linear directory scans.

The hash function would be slightly more expensive (when enabled), but
not much, especially when you put in the obvious optimisation for 7
bit characters. The string comparison function in a couple of places
would also become more expensive, but once again it would only be
expensive for case-insensitive processes and benefits from the 7 bit
optimisation so that the average case will only be very slightly more
expensive than the current function.

Fair enough that you don't want to do this for code complexity
reasons, but please don't tell me it would be slower than what we have
to do now. 

Try an strace of Samba trying to unlink() a non-existant file in a
large directory. It's enough to make you want to curl up and die :)

Cheers, Tridge
