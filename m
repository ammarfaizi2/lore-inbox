Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266457AbUIMIqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUIMIqu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 04:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbUIMIqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 04:46:50 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:30942 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266457AbUIMIqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 04:46:42 -0400
Date: Mon, 13 Sep 2004 01:46:22 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, bcasavan@sgi.com, anton@samba.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: more numa maxnode confusions
Message-Id: <20040913014622.3addde90.pj@sgi.com>
In-Reply-To: <20040913001548.278bf672.akpm@osdl.org>
References: <20040912200253.3d7a6ff5.pj@sgi.com>
	<20040913065621.GB12185@wotan.suse.de>
	<20040913001548.278bf672.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew asked:
> Revert what?

The immediate change Andi wants reverted only matters at present in
Linus' bk tree.  My main cpuset patch in your *-mm tree already does the
reversion in *-mm (unfortunately - collision details follow ...).

So I presume that Linus' will apply Andi's reversion patch of earlier this
evening to his bk tree.

But then when you pull in Linus's latest bk changes into your linus.patch,
this will collide with my main cpuset patch.

Both patches will be trying to add back in the same line:

	--maxnode;

to get_nodes() in mm/mempolicy.c.

My guess is that now that you and Linus know about this, you two can
handle the collision by hand - both new lines of code agree on what's to
be done: add the above line back in.

But if there is some other permutation of patches that I can send that
would be smoother, let me know.

The one alternative I can think of that would allow everyone to put this
back on autopilot and forget the details, would be to _remove_ the
following segment of my cpusets-big-numa-cpu-and-memory-placement.patch:

@@ -133,6 +134,7 @@ static int get_nodes(unsigned long *node
 	unsigned long nlongs;
 	unsigned long endmask;
 
+	--maxnode;
 	bitmap_zero(nodes, MAX_NUMNODES);
 	if (maxnode == 0 || !nmask)
 		return 0;

so that Andi's latest reversion path applied cleanly when it came back
at you from Linus' bk tree.  But I understand that usually you like to
layer new patches, not replace or edit existing ones.

Go ahead and remove the above segment, if that seems best to you.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
