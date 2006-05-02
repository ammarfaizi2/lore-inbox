Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWEBUJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWEBUJQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWEBUJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:09:16 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:41880 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751284AbWEBUJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:09:15 -0400
Date: Tue, 2 May 2006 22:13:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Martin Bligh <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060502201358.GA10831@elte.hu>
References: <20060419112130.GA22648@elte.hu> <200605022144.56586.ak@suse.de> <4457B960.40701@mbligh.org> <200605022200.12980.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605022200.12980.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > > The problem is that nobody regression tests it. So even if you fix it
> > > now it will be likely broken again in a few months.
> > 
> > We can add a box to the test.kernel.org harness easily enough, and
> > it will show up with an eerie red glow.
> 
> Single box is not enough - there are many possible combinations (e.g. 
> Opteron NUMA, IBM NUMA, no NUMA small box, big box with weird mappings 
> etc.). Basically you would need a real tester base.

nah. And the fact that i could boot this on a non-NUMA box already 
unearthed a weakness in the buddy allocator. (it should have much 
clearer asserts about mis-sized zones - it's not the first time we had 
them and they are hard to debug) So consider this a debugging feature. 
It also found other bugs, so even if nobody but me uses it, it's useful.

	ingo
