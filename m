Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWBFKQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWBFKQy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWBFKQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:16:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:6362 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750947AbWBFKQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:16:53 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Date: Mon, 6 Feb 2006 11:16:42 +0100
User-Agent: KMail/1.8.2
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602061109.45788.ak@suse.de> <20060206101156.GA1761@elte.hu>
In-Reply-To: <20060206101156.GA1761@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602061116.44040.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 11:11, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > Of course there might be some corner cases where using local memory 
> > for caching is still better (like mmap file IO), but my guess is that 
> > it isn't a good default.
> 
> /tmp is almost certainly one where local memory is better.

Not sure. What happens if someone writes a 1GB /tmp file on a 1GB node?

Christoph recently added some changes to the page allocator to 
try harder to get local memory to work around this problem, but
attacking it at the root might be better.

Perhaps one could do a "near" caching policy for big machines: e.g. 
if on a big Altix prefer to put it on a not too far away node, but
spread it out evenly. But it's not clear yet such complexity is needed.

-Andi
