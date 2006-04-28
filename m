Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWD1Hee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWD1Hee (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 03:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWD1Hee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 03:34:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23210 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030296AbWD1Hed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 03:34:33 -0400
Subject: Re: [discuss] Re: [PATCH] [3/4] i386: Fix overflow in
	e820_all_mapped
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Beulich <jbeulich@novell.com>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
In-Reply-To: <4451DB47.76E4.0078.0@novell.com>
References: <4451A80E.mailNZX1XN4A8@suse.de>
	 <Pine.LNX.4.64.0604272237430.3701@g5.osdl.org>
	 <4451DB47.76E4.0078.0@novell.com>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 09:34:02 +0200
Message-Id: <1146209643.3126.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 09:07 +0200, Jan Beulich wrote:
> >>> Linus Torvalds <torvalds@osdl.org> 28.04.06 07:39 >>>
> >
> >
> >On Fri, 28 Apr 2006, Andi Kleen wrote:
> >> 
> >> The 32bit version of e820_all_mapped() needs to use u64 to avoid
> >> overflows on PAE systems.  Pointed out by Jan Beulich
> >
> >I don't think that's true.
> >
> >It can't be called with 64-bit arguments anyway. If the base address 
> >doesn't fit in 32-bit, we'd be screwed in other places, afaik.
> 
> The arguments don't necessarily need to be u64, but (at least some of)
> the calculations inside the function do. Otherwise, a region starting
> below 4G and extending to or beyond 4G would not be considered
> correctly.

since this is use-once __init code I rather keep it simple and safe (eg
use u64) than do complex tricks to make it safe in another way.. and the
4G thing is a real potential problem that's easily fixed with the u64
thing.

