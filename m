Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbVHDXk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbVHDXk3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 19:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbVHDXk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 19:40:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:29125 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262665AbVHDXk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 19:40:27 -0400
Date: Fri, 5 Aug 2005 01:40:25 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: NUMA policy interface
Message-ID: <20050804234025.GJ8266@wotan.suse.de>
References: <20050803084849.GB10895@wotan.suse.de> <Pine.LNX.4.62.0508040704590.3319@graphe.net> <20050804142942.GY8266@wotan.suse.de> <Pine.LNX.4.62.0508040922110.6650@graphe.net> <20050804170803.GB8266@wotan.suse.de> <Pine.LNX.4.62.0508041011590.7314@graphe.net> <20050804211445.GE8266@wotan.suse.de> <Pine.LNX.4.62.0508041416490.10150@graphe.net> <20050804214132.GF8266@wotan.suse.de> <Pine.LNX.4.62.0508041509330.10813@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0508041509330.10813@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 03:19:52PM -0700, Christoph Lameter wrote:
> There are three possibilites:
> 
> 1. do what cpusets is doing by versioning.
> 
> 2. Have the task notifier access the task_struct information.
> See http://lwn.net/Articles/145232/ "A new path to the refrigerator"
> 
> 3. Maybe the easiest: Require mmap_sem to be taken for all policy 
> accesses. Currently its only require for vma policies. Then we need
> to make a copy of the policy at some point so that alloc_pages can
> access policy information lock free. This may also allow us to fix
> the bind issue if we would f.e. keep a bitmap in the taskstruct or (ab)use 
> the cpusets map.

None of them seem very attractive to me.  I would prefer to just
not support external accesses keeping things lean and fast.


> > If they cannot afford enough disk space it might be possible
> > to do the page migration in swap cache like Hugh proposed.
> 
> This code already exist in the memory hotplug code base and Ray already 
> had a working implementation for page migration. The migration code will 
> also be necessary in order to relocate pages with ECC single bit failures 
> that Russ is working on (of course that will only work for some pages) and
> for Mel Gorman's defragmentation approach (if we ever get the split into 
> differnet types of memory chunks in).

Individual physical page migration is quite different from
address space migration.

-Andi
