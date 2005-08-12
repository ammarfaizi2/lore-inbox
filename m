Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVHLQ5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVHLQ5W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 12:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVHLQ5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 12:57:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59075 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750702AbVHLQ5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 12:57:21 -0400
Date: Fri, 12 Aug 2005 12:56:57 -0400
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference between /dev/kmem and /dev/mem)
Message-ID: <20050812165657.GC13749@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <1123796188.17269.127.camel@localhost.localdomain> <1123809302.17269.139.camel@localhost.localdomain> <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 09:35:03AM -0700, Linus Torvalds wrote:

 > On Thu, 11 Aug 2005, Steven Rostedt wrote:
 > > 
 > > Found the problem.  It is a bug with mmap_kmem.  The order of checks is
 > > wrong, so here's the patch.  Attached is a little program that reads the
 > > System map looking for the variable modprobe_path.  If it finds it, then
 > > it opens /dev/kmem for read only and mmaping it to read the contents of
 > > modprobe_path.
 > 
 > I'm actually more inclined to try to deprecate /dev/kmem.. I don't think 
 > anybody has ever really used it except for some rootkits. It only exists 
 > in the first place because it's historical.

We've had it disabled in Fedora for a long time, maybe as far
back as FC2, for exactly this reason.  The only things that broke,
were things that needed fixing anyway. (Something like gdm was
reading /dev/mem to get a source of random numbers of all things).

 > We do need to support /dev/mem for X, but even that might go away some 
 > day. 

We also restrict /dev/mem to be a 'need to know' basis. Trying
to read from certain regions of memory will fail.
Again, nothing that wasn't already broken broke with this change.

 > So I'd be perfectly happy to fix this, but I'd be even happier if we made 
 > the whole kmem thing a config variable (maybe even default it to "off").

The above patches were in -mm for a while, though they didn't
have a config option, they just 'did it', and some of the
changes were a bit unclean, but I can polish that up if you're
interested.

		Dave

