Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVCBWl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVCBWl0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbVCBWhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:37:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:57280 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262516AbVCBW1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:27:43 -0500
Date: Wed, 2 Mar 2005 14:28:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: David Howells <dhowells@redhat.com>, davidm@snapgear.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information
In-Reply-To: <20050302135146.2248c7e5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503021423420.25732@ppc970.osdl.org>
References: <20050302090734.5a9895a3.akpm@osdl.org> <9420.1109778627@redhat.com>
 <31789.1109799287@redhat.com> <20050302135146.2248c7e5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Mar 2005, Andrew Morton wrote:
>
> Why not make these bitfields as well?

Side note: bitfields aren't exactly wonderful. They tend to generate worse
code, and they make it much harder to work with combinations of flags
(both testing and initializing). They also have architecture-specific
bit-order and packing issues, which means that when coupled with device
drivers etc they can be a major pain in the derriere.

Even apart from those issues, they can't sanely be atomically accessed, so
in many cases they just aren't a good thing.

In contrast, just using a flag word and explicit bitmask has none of those 
problems, and it's often easy to abstract out things with a macro and/or 
inline function.

So don't go for bitfields "just because". It's generally a good idea to 
_require_ that the code in question has none of the potential problem 
spots even in _theory_, and in addition also show that bitfields really 
make the code look nicer. The downsides really can be that nasty.

		Linus
