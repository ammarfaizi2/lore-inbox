Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbUCEObL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 09:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbUCEObK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 09:31:10 -0500
Received: from mx1.elte.hu ([157.181.1.137]:22178 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262604AbUCEObG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 09:31:06 -0500
Date: Fri, 5 Mar 2004 15:32:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
       riel@redhat.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305143210.GA11897@elte.hu>
References: <20040228072926.GR8834@dualathlon.random> <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305141504.GY4922@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> [...] 8/16/32G boxes works perfectly with 3:1 with the stock 2.4 VM
> (after you nuke rmap).

the mem_map[] on 32G is 400 MB (using the stock 2.4 struct page). This
leaves ~500 MB for the lowmem zone. It's ridiculously easy to use up 500
MB of lowmem. 500 MB is a lowmem:RAM ratio of 1:60. With 4/4 you have 6
times more lowmem. So starting at 32 GB (but often much earlier) the 3/1
split breaks down. And you obviously it's a no-go at 64 GB.

inbetween it all depends on the workload. If the 3:1 split works fine
then sure, use it. There's no one kernel that fits all sizes.

	Ingo
