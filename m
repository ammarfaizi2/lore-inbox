Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030477AbVKWW5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbVKWW5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbVKWW5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:57:17 -0500
Received: from kanga.kvack.org ([66.96.29.28]:15064 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1030459AbVKWW5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:57:14 -0500
Date: Wed, 23 Nov 2005 17:54:30 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: rfc/rft: use r10 as current on x86-64
Message-ID: <20051123225430.GB14246@kvack.org>
References: <20051122165204.GG1127@kvack.org> <20051123224803.GE24220@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123224803.GE24220@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 11:48:03PM +0100, Pavel Machek wrote:
> 34KB smaller is nice, but is not it also 30% slower? Plus some inline
> assembly *will* have %r10 hardcoded, no? I'd be afraid around crypto
> code, for example.

It's not slower in any of the tests I've run.  The crypto code needs a 
tweak (the next version I send out will have that fix), and I'm still 
working on getting thread_info to be relative to current, which should 
save a bit more code.  The assembly I've looked at tends to be better 
as gcc can access various fields by directly offseting current instead 
of the inline asm load then store that is otherwise needed.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
Don't Email: <dont@kvack.org>.
