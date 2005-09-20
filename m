Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbVITNKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbVITNKX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 09:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbVITNKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 09:10:23 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:29129 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S965010AbVITNKW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 09:10:22 -0400
Date: Tue, 20 Sep 2005 15:10:09 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Robin Holt <holt@sgi.com>
Cc: Paul Jackson <pj@sgi.com>, zippel@linux-m68k.org, akpm@osdl.org,
       torvalds@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
In-Reply-To: <20050920120523.GC21435@lnx-holt.americas.sgi.com>
Message-ID: <Pine.LNX.4.61.0509201503050.21394@openx3.frec.bull.fr>
References: <20050912075155.3854b6e3.pj@sgi.com> <Pine.LNX.4.61.0509121821270.3743@scrub.home>
 <20050912153135.3812d8e2.pj@sgi.com> <Pine.LNX.4.61.0509131120020.3728@scrub.home>
 <20050913103724.19ac5efa.pj@sgi.com> <Pine.LNX.4.61.0509141446590.3728@scrub.home>
 <20050914124642.1b19dd73.pj@sgi.com> <Pine.LNX.4.61.0509150116150.3728@scrub.home>
 <20050915104535.6058bbda.pj@sgi.com> <20050920005743.4ea5f224.pj@sgi.com>
 <20050920120523.GC21435@lnx-holt.americas.sgi.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/09/2005 15:23:30,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/09/2005 15:23:32,
	Serialize complete at 20/09/2005 15:23:32
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2005, Robin Holt wrote:

> Paul,
> 
> Can you give a _short_ explanation of why notify_on_release is
> essential?  Could the intent be accomplished with something
> like destroy on exit which then goes through and does the
> remove of shildren and finally removes the cpuset?
> 
> If we can agree on that, then the exit path becomes
> 	if (atomic_dec_and_lock(&current->cpuset.refcount)) {
> 		/* Code to remove children. */
> 	}
> which no longer needs to call a usermode helper and is _FAR_
> better in my personal biased opinion.
> 
> 

The original cpuset patch did not have a notify_on_release feature, it had 
an 'autoclean' feature, that did exactly what you describe.

But the locking was not clean, mostly at the filesystem level. Paul and I 
tried together to fix it, but at some point Paul proposed this solution, 
to use a usermode helper, and it seemed to be the easiest way to get out 
of this locking issue, so we agreed to drop the old 'autoclean' scheme.

(Even if Paul had a hard time convincing me, as I did not like the idea of 
this usermode helper too much).


	Simon.
