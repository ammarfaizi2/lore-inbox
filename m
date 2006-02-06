Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWBFKwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWBFKwp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWBFKwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:52:45 -0500
Received: from ns2.suse.de ([195.135.220.15]:25822 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751070AbWBFKwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:52:44 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Date: Mon, 6 Feb 2006 11:35:29 +0100
User-Agent: KMail/1.8.2
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602061116.44040.ak@suse.de> <20060206102337.GA3359@elte.hu>
In-Reply-To: <20060206102337.GA3359@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602061135.30966.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 11:23, Ingo Molnar wrote:

> 
> well, if the pagecache is filled on a node above a certain ratio then 
> one would have to spread it out forcibly. 

In theory yes. In practice it doesn't work that well ...

> But otherwise, try to keep  
> things as local as possible, because that will perform best. 

Experience teaches differently. For IO caches (and d/icache) strict local 
caching doesn't seem to be the best policy because it competes with more
important mapped memory too much.

> This is  
> different from the case Paul's patch is addressing: workloads which are 
> known to be global (and hence spreading out is the best-performing 
> allocation).
> 
> (for which problem i suggested a per-mount/directory/file 
> locality-of-reference attribute in another post.)

iirc there is already a patch around for tmpfs to do that. But the 
interesting point here is what should be that default. And what
to do with the d/icaches by default.

-Andi
 
