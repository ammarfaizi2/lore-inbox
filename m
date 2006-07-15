Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945990AbWGOETE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945990AbWGOETE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 00:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945991AbWGOETE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 00:19:04 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:14048 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1945990AbWGOETD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 00:19:03 -0400
Subject: Re: RFC: cleaning up the in-kernel headers
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>, torvalds@osdl.org, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.64.0607131201050.28976@schroedinger.engr.sgi.com>
References: <20060711160639.GY13938@stusta.de>
	 <Pine.LNX.4.64.0607131201050.28976@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 00:18:29 -0400
Message-Id: <1152937109.27135.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 12:05 -0700, Christoph Lameter wrote:
> On Tue, 11 Jul 2006, Adrian Bunk wrote:
> 
> > This would also remove all the implicit rules "before #include'ing 
> > header foo.h, you must #include header bar.h" you usually only see when 
> > the compilation fails.
> > 
> > There might be exceptions (e.g. for avoiding circular #include's) but 
> > these would be special cases.
> 
> Great! Yes please. There is also some weirdness in #include in the 
> middle of another .h file (see mm.h). It would be great if you could find 
> a solution.

Are you talking about the page-flags.h or the vmstat.h?

The page-flags.h has a FIXME by it to remove it, but under Adrian's
rules, it seems that it should still belong.  The rule is that if foo.h
needs bar.h to compile, then foo.h should have bar.h in it. And just
seeing what happens if we remove page-flags.h from mm.h, we get a
compile error in mm.h. Which means that that page-flags.h belongs in
mm.h since it wont compile without it.

Now for the vmstat.h, I just tried removing that, and it seems that this
is a candidate to be removed from mm.h since mm.h compiles fine without
it. But vmstat.h doesn't compile without mm.h.  So it seems that we
should add mm.h to vmstat.h, remove vmstat.h from mm.h and for those .c
files that break, just add vmstat.h to them.

-- Steve


