Return-Path: <linux-kernel-owner+w=401wt.eu-S1753852AbWL1Xyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852AbWL1Xyw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 18:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbWL1Xyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 18:54:51 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43474 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753852AbWL1Xyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 18:54:49 -0500
Date: Thu, 28 Dec 2006 15:54:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Andrew Morton <akpm@osdl.org>, Guillaume Chazarain <guichaz@yahoo.fr>,
       David Miller <davem@davemloft.net>, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, Marc Haber <mh+linux-kernel@zugschlus.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Martin Michlmayr <tbm@cyrius.com>, arjan@infradead.org,
       Chen Kenneth W <kenneth.w.chen@intel.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <Pine.LNX.4.64.0612282326460.3586@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0612281552100.4473@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost> <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost> <20061217154026.219b294f.akpm@osdl.org>
 <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org> <45861E68.3060403@yahoo.com.au>
 <20061217214308.62b9021a.akpm@osdl.org> <20061219085149.GA20442@torres.l21.ma.zugschlus.de>
 <20061228180536.GB7385@torres.zugschlus.de> <Pine.LNX.4.64.0612281014190.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612281318480.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612281325290.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612282326460.3586@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2006, Anton Altaparmakov wrote:
> 
> But are chunks 3 and 4 in separate buffer heads?  Sorry could not see it 
> immediately from the output you showed...

No, this is a 4kB filesystem. A single bh per page.

> It is just that there may be a different cause rather than buffer dirty 
> state...

Sure.

> A shot in the dark I know but it could perhaps be that a "COW for 
> MAP_PRIVATE" like event happens when the page is dirty already thus the 
> second write never actually makes it to the shared page thus it never gets 
> written out.

There are no private mappings anywhere, and no forks. Just a single mmap 
(well, we unmap and remap in order to force the page cache to be 
invalidated properly with the posix_fadvise() thing, but that's literally 
the only user).

		Linus
