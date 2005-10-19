Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbVJSRAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVJSRAY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 13:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVJSRAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 13:00:23 -0400
Received: from gold.veritas.com ([143.127.12.110]:19099 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751151AbVJSRAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 13:00:23 -0400
Date: Wed, 19 Oct 2005 17:59:33 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Steve Youngs <steve@youngs.au.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13.4 After increasing RAM, I'm getting Bad page state at
 prep_new_page
In-Reply-To: <microsoft-free.877jc9jzwy.fsf@youngs.au.com>
Message-ID: <Pine.LNX.4.61.0510191741350.8481@goblin.wat.veritas.com>
References: <microsoft-free.877jc9jzwy.fsf@youngs.au.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Oct 2005 17:00:22.0557 (UTC) FILETIME=[97D494D0:01C5D4CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2005, Steve Youngs wrote:
> 
> A few days ago I increased my RAM from 0.5Gb to 3Gb and since then
> I've been getting `Bad page state at prep_new_page' errors at odd
> times.  Here is a typical backtrace from my logs:
> 
> Bad page state at prep_new_page (in process 'X', page c1f7bde0)
> flags:0x80000004 mapping:00000000 mapcount:-262144 count:0

It does look like bad memory, the single bit 0x40000 has got cleared
from the 0xffffffff which represents the expected mapcount 0 (for
reasons I won't go into, physical -1 represents logical 0 there).

If it were 0x800 which was cleared, I'd get excited, because that
would fit with a report from a few months back, which really did
not seem to be bad memory.  But 0x40000 isn't so interesting, sorry!

The bad memory in question (the struct page at 0xc1f7bde0) is quite
low down, just below 32MB.  Would I be right to guess that that you
inserted the new cards in such a way that the low memory is new RAM?

I suggest you try taking out that lowest card, and see what happens
then.  Sometimes the kernel these days seems to find memory problems
that memtest86 does not (how long did you run it? overnight?).

You could try sending me all your "Bad page state" messages,
to check for correlations.

Hugh
