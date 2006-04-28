Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbWD1Oxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbWD1Oxg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 10:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030421AbWD1Oxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 10:53:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3306 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030420AbWD1Oxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 10:53:34 -0400
Date: Fri, 28 Apr 2006 07:52:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jbeulich@novell.com
Subject: Re: [PATCH] [3/4] i386: Fix overflow in e820_all_mapped
In-Reply-To: <200604280808.16256.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0604280748260.3701@g5.osdl.org>
References: <4451A80E.mailNZX1XN4A8@suse.de> <Pine.LNX.4.64.0604272237430.3701@g5.osdl.org>
 <200604280808.16256.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Apr 2006, Andi Kleen wrote:
> 
> Quoting jbeulich:
>
> The effect is not on the current user's parameter passing, but in the 
> result the function may produce. If, say, for the PCI mmconfig and BIOS 
> space, there is a (reserved) entry starting at E0000000 and being 
> 20000000 in size, then as far as I can tell the function will return 
> zero (rather than one).

Well, but that has nothing to do with the _calling_ convention.

That looks to be a totally internal bug to within e820_all_mapped().

I agree that the calling convention change would avoid the overflow 
internally too, I just don't much like the explanation (and not 
necessarily that it affects the caller, who doesn't much care).

		Linus
