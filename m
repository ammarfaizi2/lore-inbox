Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWH3Wx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWH3Wx4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWH3Wx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:53:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751166AbWH3Wxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:53:55 -0400
Date: Wed, 30 Aug 2006 15:53:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [FOR 2.6.18 FIX][PATCH]  drm: radeon flush TCL VAP for vertex
 program enable/disable
In-Reply-To: <20060830154152.9ac71753.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0608301550090.27779@g5.osdl.org>
References: <Pine.LNX.4.64.0608302314360.21600@skynet.skynet.ie>
 <20060830154152.9ac71753.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 Aug 2006, Andrew Morton wrote:
> 
> That's a somewhat weird-looking patch.  It adds code which is quite
> dissimilar from all the other cases in that switch statement.

It looks ok to me, although you have to look into the caller to see why it 
does what it does.

It would be "prettier" if it changed the size and data of the incoming 
packet instead, but the code as is isn't actually set up to be able to do 
that (the size setup and verification stuff is done before the fixup).

That said, I'd have expected that the VAP state flush is really something 
that the _client_ should do when it generates the commands, not the kernel 
after the fact. Although maybe the kernel could keep track of whether the 
flush is needed at all, and since we apparently allow untrusted generation 
of packets, maybe this is the right approach..

Anyway, the patch doesn't look _wrong_ to me, although it does seem to 
break the abstraction rules a bit.

			Linus
