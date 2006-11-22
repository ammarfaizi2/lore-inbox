Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162046AbWKVKq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162046AbWKVKq6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 05:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162042AbWKVKq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 05:46:57 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:41563 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S1162031AbWKVKqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 05:46:55 -0500
Subject: Re: The VFS cache is not freed when there is not enough free
	memory to allocate
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Aubrey <aubreylee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mel <mel@csn.ul.ie>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <6d6a94c50611220202t1d076b4cye70dcdcc19f56e55@mail.gmail.com>
References: <6d6a94c50611212351if1701ecx7b89b3fe79371554@mail.gmail.com>
	 <1164185036.5968.179.camel@twins>
	 <6d6a94c50611220202t1d076b4cye70dcdcc19f56e55@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 11:42:51 +0100
Message-Id: <1164192171.5968.186.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-22 at 18:02 +0800, Aubrey wrote:
> On 11/22/06, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> > Please see the
> > threads on Mel Gorman's Anti-Fragmentation and Linear/Lumpy reclaim in
> > the linux-mm archives.
> >
> 
> Thanks to point this. Is it already included in Linus' git tree?

No it is not.

> Well, the test application just use an exaggerated way to replicate the issue.
> 
> Actually, In the real work, the application such as mplayer, asterisk,
> etc will run into
> the above problem when run them at the second time. I think I have no
> reason to modify those kind of applications.

It comes from the choice of architecture, I'd not run general purpose
code like that on MMU-less hardware. But yeah, I see your point.

> My patch let kernel drop VFS cache in the low memory situation when
> the application requests more memory allocation, I don't think it's
> luck. You know, the application just wants to allocate 8
> 1Mbyte-blocks(order =9) and releasing VFS cache we can get almost
> 50Mbyte free memory.

Yes it does that, but there is no guarantee that those 50MB have a
single 1M contiguous region amongst them.

> The patch indeedly enabled many failed test cases on our side. But
> yes, I don't think it's the final solution. I'll try Mel's patch and
> update the results.

Mel's patches alone aren't quite enough, you also need some reclaim
modifications, I'll ping Andy to see how far he's on that.

