Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbUCGIkT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 03:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbUCGIkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 03:40:19 -0500
Received: from mx1.elte.hu ([157.181.1.137]:30418 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261778AbUCGIkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 03:40:14 -0500
Date: Sun, 7 Mar 2004 09:41:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
       riel@redhat.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040307084120.GB17629@elte.hu>
References: <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143210.GA11897@elte.hu> <20040305145837.GZ4922@dualathlon.random> <20040305152622.GA14375@elte.hu> <20040305155317.GC4922@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305155317.GC4922@dualathlon.random>
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

> [...] but I'm quite confortable to say that up to 16G (included) 4:4
> is worthless unless you've to deal with the rmap waste IMHO. [...]

i've seen workloads on 8G RAM systems that easily filled up the ~800 MB
lowmem zone. (it had to do with many files and having them as a big
dentry cache, so yes, it's unfixable unless you start putting inodes
into highmem which is crazy. And yes, performance broke down unless most
of the dentries/inodes were cached in lowmem.)

as i said - it all depends on the workload, and users are amazingly
creative at finding all sorts of workloads. Whether 4:4 or 3:1 is thus
workload dependent.

should lowmem footprint be reduced? By all means yes, but only as long
as it doesnt jeopardize the real 64-bit platforms. Is 3:1 adequate as a
generic x86 kernel for absolutely everything up to and including 16 GB? 
Strong no. [not to mention that 'up to 16 GB' is an artificial thing
created by us which wont satisfy an IHV that has a hw line with RAM up
to 32 or 64 GB. It doesnt matter that 90% of the customers wont have
that much RAM, it's a basic "can it scale to that much RAM" question.]

so i think the right answer is to have 4:4 around to cover the bases -
and those users who have workloads that will run fine on 3:1 should run
3:1.

(not to mention the range of users who need 4GB _userspace_.)

but i'm quite strongly convinced that 'getting rid' of the 'pte chain
overhead' in favor of questionable lowmem space gains for a dying
(high-end server) platform is very shortsighted. [getting rid of them
for purposes of the 64-bit platforms could be OK, but the argumentation
isnt that strong there i think.]

	Ingo
