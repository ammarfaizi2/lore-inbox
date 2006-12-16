Return-Path: <linux-kernel-owner+w=401wt.eu-S932531AbWLPShi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWLPShi (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 13:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWLPShi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 13:37:38 -0500
Received: from excu-mxob-2.symantec.com ([198.6.49.23]:35514 "EHLO
	excu-mxob-2.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932531AbWLPShh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 13:37:37 -0500
X-Greylist: delayed 1020 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 13:37:37 EST
X-AuditID: c6063117-a2740bb000001a74-8e-458438f51ac4 
Date: Sat, 16 Dec 2006 18:20:59 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Martin Michlmayr <tbm@cyrius.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: Recent mm changes leading to filesystem corruption?
In-Reply-To: <20061216155044.GA14681@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64.0612161812090.21270@blonde.wat.veritas.com>
References: <20061216155044.GA14681@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Dec 2006 18:20:37.0189 (UTC) FILETIME=[E24F5F50:01C7213E]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006, Martin Michlmayr wrote:

> Debian recently applied a number of mm changes that went into 2.6.19
> to their 2.6.18 kernel for LSB 3.1 compliance (msync() had problems
> before).  Since then, some filesystem corruption has been observed
> which can be traced back to these mm changes.  Is anyone aware of
> problems with these patches?

Very disturbing.  I'm not aware of any problem with them, and we
surely wouldn't have released 2.6.19 with any known-corrupting patches
in.  There's some doubts about 2.6.19 itself in the links below: were
it not for those, I'd suspect a mismerge of the pieces into 2.6.18,
perhaps a hidden dependency on something else.  I'll ponder a little,
but let's CC linux-mm in case someone there has an idea.

Hugh

> 
> The patches that were applied are:
> 
>    - mm: tracking shared dirty pages
>    - mm: balance dirty pages
>    - mm: optimize the new mprotect() code a bit
>    - mm: small cleanup of install_page()
>    - mm: fixup do_wp_page()
>    - mm: msync() cleanup
> 
> With these applied to 2.6.18, the Debian installer on a slow ARM
> system fails because a program segfaults due to filesystem corruption:
> http://bugs.debian.org/401980  This problem also occurs if you only
> apply the "mm: tracking shared dirty pages" patch to 2.6.18 from the
> series of 5 patches listed above.
> 
> Another problem has been reported related to libtorrent: according to
> http://bugs.debian.org/402707 someone also saw this with non-Debian
> 2.6.19 but obviously it's hard to say whether the bugs are really
> related.
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=394392;msg=24 shows
> some dmesg messages but again it's not 100% clear it's the same bug.
> 
> Has anyone else seen problems or is aware of a fix to the patches
> listed above that I'm unaware of?  It's possible the problem only
> shows up on slow systems. (The corruption is reproducible on a slow
> NSLU2 ARM system with 32 MB ram, but it doesn't happen on a faster ARM
> box with more RAM.)
> -- 
> Martin Michlmayr
> http://www.cyrius.com/
