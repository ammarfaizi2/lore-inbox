Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbTLJNWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 08:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbTLJNWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 08:22:41 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:25611
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263081AbTLJNWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 08:22:37 -0500
Date: Wed, 10 Dec 2003 05:16:47 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Valdis.Kletnieks@vt.edu
cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause? 
In-Reply-To: <200312050513.hB55D1ps030713@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.10.10312100512480.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Very simple.

Apply the basics of GPL and strip all the inlines to a file called
kernel_inlines.[ch] and export all the symbols to export_symbol.

Thus all the cute tricks people try to taint the unprotecable interface is
removed.  The basics of removing the code in question.

If you holler wait you are changing the core and you can't BUZZIT.
I can change what ever I want and distribute it where ever I care.

Thank you,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 5 Dec 2003 Valdis.Kletnieks@vt.edu wrote:

> On Fri, 05 Dec 2003 15:23:10 +1100, Peter Chubb said:
> 
> > As far as I know, interfacing to a published API doesn't infringe
> > copyright.
> 
> Well, if the only thing in the .h files was #defines and structure definitions,
> it would probably be a slam dunk to decide that, yes.
> 
> Here's the part where people's eyes glaze over:
> 
> % cd /usr/src/linux-2.6.0-test10-mm1
> % find include -name '*.h' | xargs egrep 'static.*inline' | wc -l
>    6288
> 
> That's 6,288 chances for you to #include GPL code and end up
> with executable derived from it in *your* .o file, not the kernel's.
> 
> More to the point, look at include/linux/rwsem.h, and ask yourself
> how to call down_read(), down_write(), up_read(), and up_write()
> without getting little snippets of GPL all over your .o.  
> 
> And even if your module doesn't get screwed by that, there's a
> few other equally dangerous inlines waiting to bite you on the posterior.
> 
> I seem to recall one of the little buggers was particularly nasty, because it
> simply Would Not Work if not inlined, so compiling with -fno-inline wasn't an
> option.  Unfortunately, I can't remember which it was - it was mentioned on
> here a while ago when somebody's kernel failed to boot because a gcc 3.mumble
> had broken inlining.....
> 
> 

