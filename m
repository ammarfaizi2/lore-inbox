Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbVKCBhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbVKCBhg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 20:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbVKCBhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 20:37:35 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:2188 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030261AbVKCBhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 20:37:32 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Wed, 2 Nov 2005 18:10:27 -0600
User-Agent: KMail/1.8
Cc: Ingo Molnar <mingo@elte.hu>,
       Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
References: <E1EXK87-0008JB-00@w-gerrit.beaverton.ibm.com>
In-Reply-To: <E1EXK87-0008JB-00@w-gerrit.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511021810.28948.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 November 2005 09:02, Gerrit Huizenga wrote:
> > but that's obviously not 'generic unpluggable kernel RAM'. It's very
> > special RAM: RAM that is free or easily freeable. I never argued that
> > such RAM is not returnable to the hypervisor.
>
>  Okay - and 'generic unpluggable kernel RAM' has not been a goal for
>  the hypervisor based environments.  I believe it is closer to being
>  a goal for those machines which want to hot-remove DIMMs or physical
>  memory, e.g. those with IA64 machines wishing to remove entire nodes

Keep in mind that just about any virtualized environment might benefit from 
being able to tell the parent system "we're not using this ram".  I mentioned 
UML, and I can also imagine a Linux driver that signals qemu (or even vmware) 
to say "this chunk of physical memory isn't currently in use", and even if 
they don't actually _free_ it they can call madvise() on it.

Heck, if we have prezeroing of large blocks, telling your emulator to 
madvise(ADV_DONTNEED) the pages for you should just plug right in to that 
infrastructure...

Rob
