Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263168AbUKTTdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263168AbUKTTdx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 14:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUKTTdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 14:33:53 -0500
Received: from holomorphy.com ([207.189.100.168]:39304 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263165AbUKTTdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 14:33:40 -0500
Date: Sat, 20 Nov 2004 11:33:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       clameter@sgi.com, benh@kernel.crashing.org, hugh@veritas.com,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
Message-ID: <20041120193325.GZ2714@holomorphy.com>
References: <20041120053802.GL2714@holomorphy.com> <419EDB21.3070707@yahoo.com.au> <20041120062341.GM2714@holomorphy.com> <419EE911.20205@yahoo.com.au> <20041119225701.0279f846.akpm@osdl.org> <419EEE7F.3070509@yahoo.com.au> <1834180000.1100969975@[10.10.2.4]> <Pine.LNX.4.58.0411200911540.20993@ppc970.osdl.org> <20041120190818.GX2714@holomorphy.com> <Pine.LNX.4.58.0411201112200.20993@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411201112200.20993@ppc970.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Nov 2004, William Lee Irwin III wrote:
>> "The perfect is the enemy of the good."

On Sat, Nov 20, 2004 at 11:16:12AM -0800, Linus Torvalds wrote:
> Yes. But in this case, my suggestion _is_ the good. You seem to be pushing 
> for a really horrid thing which allocates a per-cpu array for each 
> mm_struct. 
> What is it that you have against the per-thread rss? We already have 
> several places that do the thread-looping, so it's not like "you can't do 
> that" is a valid argument.

Okay, first thread groups can share mm's, so it's worse than iterating
over a thread group. Second, the long loops under tasklist_lock didn't
stop causing rwlock starvation because what patches there were to do
something about them didn't get merged.

I'm not particularly "stuck on" the per-cpu business, it was merely the
most obvious method of splitting the RSS counter without catastrophes
elsewhere. Robin Holt's 2.4 performance studies actually show that
splitting the counter is not even essential.


-- wli
