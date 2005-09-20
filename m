Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbVITPIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVITPIZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbVITPIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:08:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59611 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964852AbVITPIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:08:24 -0400
Date: Tue, 20 Sep 2005 08:07:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Robin Holt <holt@sgi.com>
cc: Paul Jackson <pj@sgi.com>, zippel@linux-m68k.org, akpm@osdl.org,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
In-Reply-To: <20050920145449.GA31461@lnx-holt.americas.sgi.com>
Message-ID: <Pine.LNX.4.58.0509200804520.2553@g5.osdl.org>
References: <20050912153135.3812d8e2.pj@sgi.com> <Pine.LNX.4.61.0509131120020.3728@scrub.home>
 <20050913103724.19ac5efa.pj@sgi.com> <Pine.LNX.4.61.0509141446590.3728@scrub.home>
 <20050914124642.1b19dd73.pj@sgi.com> <Pine.LNX.4.61.0509150116150.3728@scrub.home>
 <20050915104535.6058bbda.pj@sgi.com> <20050920005743.4ea5f224.pj@sgi.com>
 <20050920120523.GC21435@lnx-holt.americas.sgi.com> <20050920072255.0096f1bb.pj@sgi.com>
 <20050920145449.GA31461@lnx-holt.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Sep 2005, Robin Holt wrote:
> 
> This makes things even easier!!!
> 
> When you create a cpuset, set the refcount to 0.  The root
> cpuset is the exception and has a refcount of 1.
> 
> When tasks are added to the cpuset, increment the refcount.
> 
> When child cpusets are created, increment the refcount.  Each
> cpuset has a list of children that is protected by a single
> lock.

You just described the "dentry" reference counting. Which has the same 
issues: as long as a dentry has any children, it needs to remain.

Except dentries are a lot more complex, because we want to keep cached 
versions of them around even when the count goes to zero (and zero only 
means that we're _allowed_ to remove it under memory pressure). And 
dentries can move from one parent to another. 

			Linus
