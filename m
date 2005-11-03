Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbVKCFmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbVKCFmn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 00:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbVKCFmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 00:42:43 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:389 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S932581AbVKCFmm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 00:42:42 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Wed, 2 Nov 2005 23:41:49 -0600
User-Agent: KMail/1.8
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       user-mode-linux-devel@lists.sourceforge.net,
       Yasunori Goto <y-goto@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Mel Gorman <mel@csn.ul.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
References: <1130917338.14475.133.camel@localhost> <200511021728.36745.rob@landley.net> <20051103052649.GA16508@ccure.user-mode-linux.org>
In-Reply-To: <20051103052649.GA16508@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511022341.50524.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 November 2005 23:26, Jeff Dike wrote:
> On Wed, Nov 02, 2005 at 05:28:35PM -0600, Rob Landley wrote:
> > With fragmentation reduction and prezeroing, UML suddenly gains the
> > option of calling madvise(DONT_NEED) on sufficiently large blocks as A) a
> > fast way of prezeroing, B) a way of giving memory back to the host OS
> > when it's not in use.
>
> DONT_NEED is insufficient.  It doesn't discard the data in dirty
> file-backed pages.

I thought DONT_NEED would discard the page cache, and punch was only needed to 
free up the disk space.

I was hoping that since the file was deleted from disk and is already getting 
_some_ special treatment (since it's a longstanding "poor man's shared 
memory" hack), that madvise wouldn't flush the data to disk, but would just 
zero it out.  A bit optimistic on my part, I know. :)

> Badari Pulavarty has a test patch (google for madvise(MADV_REMOVE))
> which does do the trick, and I have a UML patch which adds memory
> hotplug.  This combination does free memory back to the host.

I saw it wander by, and am all for it.  If it goes in, it's obviously the 
right thing to use.  You may remember I asked about this two years ago:
http://seclists.org/lists/linux-kernel/2003/Dec/0919.html

And a reply indicated that SVr4 had it, but we don't.  I assume the "naming 
discussion" mentioned in the recent thread already scrubbed through this old 
thread to determine that the SVr4 API was icky.
http://seclists.org/lists/linux-kernel/2003/Dec/0955.html

>     Jeff

Rob
