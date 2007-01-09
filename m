Return-Path: <linux-kernel-owner+w=401wt.eu-S1750778AbXAIA0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbXAIA0F (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 19:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbXAIA0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 19:26:05 -0500
Received: from twinlark.arctic.org ([207.29.250.54]:36882 "EHLO
	twinlark.arctic.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbXAIA0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 19:26:04 -0500
Date: Mon, 8 Jan 2007 16:26:02 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: ak@muc.de, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] faster vgetcpu using sidt
In-Reply-To: <Pine.LNX.4.64.0701061807530.26307@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.64.0701081622270.12282@twinlark.arctic.org>
References: <Pine.LNX.4.64.0701061807530.26307@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2007, dean gaudet wrote:

> below is a patch which improves vgetcpu latency on all x86_64 
> implementations i've tested.
> 
> Nathan Laredo pointed out the sgdt/sidt/sldt instructions are 
> userland-accessible and we could use their limit fields to tuck away a few 
> bits of per-cpu information.
...

i got a hold of a p4 (model 4) and ran the timings there:

                        baseline        patched
                no cache        cache
k8 pre-revF        21             14      16
k8 revF            31             14      17
core2              38             12      17
p4                 49             24      37

not as good as i hoped... i'll have to put the cache back in just for the 
p4... so i'll respin my patch with the cache back in place.

another thought occured to me -- 64-bit processes can't actually use their 
LDT can they?  in that case i could probably use sldt (faster than sidt) 
for 64-bit procs and fallback to sidt for 32-bit emulation (which doesn't 
exist for this vsyscall yet anyhow).

let me know if you have any other feedback.

thanks
-dean
