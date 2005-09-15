Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965238AbVIOEFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbVIOEFV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 00:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbVIOEFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 00:05:21 -0400
Received: from lucius.provo.novell.com ([137.65.81.172]:25739 "EHLO
	lucius.provo.novell.com") by vger.kernel.org with ESMTP
	id S965238AbVIOEFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 00:05:19 -0400
Message-Id: <43297F8E0200008A000032AE@lucius.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 14 Sep 2005 22:05:02 -0600
From: "Nick Piggin" <npiggin@novell.com>
To: "Andrea Arcangeli" <andrea@suse.de>, "Hugh Dickins" <hugh@veritas.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: ptrace can't be transparent on readonly MAP_SHARED
References: <20050914212405.GD4966@opteron.random>
In-Reply-To: <20050914212405.GD4966@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 
 
>>>Andrea Arcangeli <andrea@suse.de> 09/15/05 7:24 am >>> 
>
>About generating anonymous pages on top of map_shared that should be 
>fine with the vm, the way anon-vma works, it already happens for 
>map_private and it's not conceputally different for anon-vma to deal 
>with overlap with map-shared or map-private. So I don't think we need
to 
>forbid ptrace (i.e. gdb) to write to a readonly map shared or stuff
like 
>that. 
> 
>Comments welcome. (especially if you see any bug in my simpler approach

>please let me know because that's how I fixed the DoS in some kernel ;)

>thanks! 
>

I like the look of the patch.

I would like to go one step further and simply disallow writing to
MAP_SHARED memory full stop. It eliminates so many corner cases and
weird behaviour (ie. after writing to a readonly MAP_SHARED, the process
will no longer see updates to the file).

Actually, maybe that's too much. I imagine on a shared memory
application
there would be use in changing writeable MAP_SHARED memory in a
debugger.
How about we disallow writing to readonly MAP_SHARED?

However going back a step - I still think Andrea's patch is nicer than
what we have now.

