Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWHVIBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWHVIBq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWHVIBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:01:45 -0400
Received: from mail.suse.de ([195.135.220.2]:54168 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751173AbWHVIBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:01:43 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Date: Tue, 22 Aug 2006 10:01:36 +0200
User-Agent: KMail/1.9.3
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, "Jan Beulich" <jbeulich@novell.com>,
       "J. Bruce Fields" <bfields@fieldses.org>, linux-kernel@vger.kernel.org
References: <20060820013121.GA18401@fieldses.org> <20060821094718.79c9a31a.rdunlap@xenotime.net> <20060821212043.332fdd0f.akpm@osdl.org>
In-Reply-To: <20060821212043.332fdd0f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608221001.36124.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 August 2006 06:20, Andrew Morton wrote:
> On Mon, 21 Aug 2006 09:47:18 -0700
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> 
> > > The 'stuck' unwinder issue at hand already has a fix, though planned to
> > > be merged for 2.6.19 only. The crash after switching to the legacy
> > > stack trace code is bad, though, but has little to do with the unwinder
> > > additions/changes. The way that code reads the stack is just
> > > inappropriate in contexts where things must be expected to be broken.
> > 
> > "merged for 2.6.19" meaning:
> > - in (before) 2.6.19, or
> > - after 2.6.19 is released
> > 
> > If "after," then it will likely need to be added to -stable also,
> > so it might as well go in "before" 2.6.19 is released.
> 
> Precisely.
> 
> Guys, this unwinder change has been quite problematic.  We really cannot
> let this badness out into 2.6.18 - it degrades our ability to debug every
> subsystem in the entire kernel.  Would marking it CONFIG_BROKEN get us back 
> to 2.6.17 behaviour?

IMHO just some stucks is tolerable for .18 and .18-stable, as long as it doesn't 
add new crashes and the fallback always gives an useful backtrace (that is why I 
added the fallback -- to make sure no information is lost) 

Short term the stucks are a bit ugly but I hope with .19 or .20 longer 
term we will have much better backtraces without false positives
(ok assuming people turn it on). The code queued for .19 should
be already pretty good now (ok after I fixed one nasty problem yesterday
that added some new ones compared to .18)

> 
> Has anyone even tried to reproduce Bruce's crash?

I looked at it a bit, but it puzzles me. The chaining for the interrupt stacks
on i386 -- which is what seems to be corrupted here -- shouldn't have changed at all 
by the unwinder changes.

I suspect it would crash without unwinder too. Bruce, do you get the 
same crash when you boot with "call_trace=old" ? 

-Andi

