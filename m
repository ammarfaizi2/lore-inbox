Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWD1HGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWD1HGY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 03:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWD1HGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 03:06:24 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:14034
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030280AbWD1HGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 03:06:24 -0400
Message-Id: <4451DB47.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 28 Apr 2006 09:07:19 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <discuss@x86-64.org>
Subject: [discuss] Re: [PATCH] [3/4] i386: Fix overflow in
	e820_all_mapped
References: <4451A80E.mailNZX1XN4A8@suse.de> <Pine.LNX.4.64.0604272237430.3701@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604272237430.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Linus Torvalds <torvalds@osdl.org> 28.04.06 07:39 >>>
>
>
>On Fri, 28 Apr 2006, Andi Kleen wrote:
>> 
>> The 32bit version of e820_all_mapped() needs to use u64 to avoid
>> overflows on PAE systems.  Pointed out by Jan Beulich
>
>I don't think that's true.
>
>It can't be called with 64-bit arguments anyway. If the base address 
>doesn't fit in 32-bit, we'd be screwed in other places, afaik.

The arguments don't necessarily need to be u64, but (at least some of)
the calculations inside the function do. Otherwise, a region starting
below 4G and extending to or beyond 4G would not be considered
correctly.

Jan
