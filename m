Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbVI0PA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbVI0PA3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbVI0PA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:00:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964962AbVI0PA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:00:28 -0400
Date: Tue, 27 Sep 2005 08:00:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hirokazu Takata <takata@linux-m32r.org>
cc: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m32r: set CHECKFLAGS properly
In-Reply-To: <20050927.152325.424252181.takata.hirokazu@renesas.com>
Message-ID: <Pine.LNX.4.58.0509270758040.3308@g5.osdl.org>
References: <E1EJlNM-00059K-R8@ZenIV.linux.org.uk>
 <20050927.152325.424252181.takata.hirokazu@renesas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Sep 2005, Hirokazu Takata wrote:
> 
> Now, the endianness is to be determined by a (cross)compiler:
> - For the big-endian, a compiler (m32r-linux-gcc or m32r-linux-gnu-gcc)
>   provides a predefined macro __BIG_ENDIAN__.
> - For little-endian, a compiler (m32rle-linux-gcc or m32rle-linux-gnu-gcc)
>   provides a predefined macro __LITTLE_ENDIAN__.

Hmm.. You need to tell sparse _some_ way which one you use, since sparse 
won't do it.

Picking one at random is fine, of course. It doesn't even have to match 
the one you'll compile with, although that means that sparse will 
obviously be testing a different configuration than the one you'd actually 
compile.

So I think having -D__BIG_ENDIAN__ in the sparse flags is better than not
having anything at all (since otherwise it won't be able to check
anything). And having something that matches the compiler would be better
still.

		Linus
