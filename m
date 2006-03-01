Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWCASen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWCASen (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 13:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWCASem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 13:34:42 -0500
Received: from ns.suse.de ([195.135.220.2]:10434 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751074AbWCASel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 13:34:41 -0500
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
Date: Wed, 1 Mar 2006 19:34:32 +0100
User-Agent: KMail/1.9.1
Cc: clameter@engr.sgi.com, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, clameter@sgi.com
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com> <200602281813.47234.ak@suse.de> <20060301102757.f2eec70e.pj@sgi.com>
In-Reply-To: <20060301102757.f2eec70e.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603011934.34136.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 19:27, Paul Jackson wrote:
> > >  1) Are you content to have such a interleave of these particular file
> > >     i/o slabs triggered by a mm/mempolicy.c option?  Or do you think
> > >     we need some sort of task external API to invoke this policy?
> > 
> > Task external. mempolicy.c has no good way to handle multiple policies
> > like this. I was thinking of a simple sysctl
> 
> No need to implement a sysctl for this.  The current cpuset facility
> should provide just what you want, if I am understanding correctly.

The main reason i'm reluctant to use this is that the cpuset fast path
overhead (e.g. in memory allocators etc.) is quite large and I wouldn't like 
to recommend people to enable all this overhead by default just to get 
more useful dcache/inode behaviour on small NUMA systems.

-Andi
