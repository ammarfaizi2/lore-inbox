Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbSKHUrZ>; Fri, 8 Nov 2002 15:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262374AbSKHUrZ>; Fri, 8 Nov 2002 15:47:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17425 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262373AbSKHUrY>; Fri, 8 Nov 2002 15:47:24 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [BUG] Failed writes marked clean?
Date: Fri, 8 Nov 2002 20:53:56 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aqh894$13t$1@penguin.transmeta.com>
References: <3DCC1EB5.4020303@google.com>
X-Trace: palladium.transmeta.com 1036788835 14654 127.0.0.1 (8 Nov 2002 20:53:55 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 8 Nov 2002 20:53:55 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3DCC1EB5.4020303@google.com>, Ross Biro <rossb@google.com> wrote:
>
>Perhaps I'm reading the code incorrectly, but in kernel versions 2.4.18 
>and 2.5.46 it looks to me like in the case of a write, ll_rw_block 
>always clears the dirty bit.  In the event of an error, nothing resets 
>the dirty bit and the uptodate flag is cleared.

Correct. 

There's not all that much else it could do. Keeping the dirty bit set is
not an option - that would bring the whole system down on IO errors.

As it is, higher layers that care _can_ figure the IO error out, simply
by noticing that the page is not up-to-date after the write. It's then
totally up to the higher layers (ie user space) to write the thing anew
if it cares about the data.

(In other words: this is why we have fsync() and error codes).

		Linus
