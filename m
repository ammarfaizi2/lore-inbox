Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267074AbUBRXtX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267085AbUBRXtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:49:23 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:62180
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S267074AbUBRXtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:49:21 -0500
Date: Thu, 19 Feb 2004 00:49:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Raphael Rigo <raphael.rigo@inp-net.eu.org>,
       linux-kernel@vger.kernel.org
Subject: Re: New do_mremap vulnerabitily.
Message-ID: <20040218234916.GU4478@dualathlon.random>
References: <4033841A.6020802@inp-net.eu.org> <Pine.LNX.4.58.0402180954590.2686@home.osdl.org> <4033E3A4.80509@nortelnetworks.com> <Pine.LNX.4.58.0402181424120.2686@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402181424120.2686@home.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 02:26:45PM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 18 Feb 2004, Chris Friesen wrote:
> > 
> > There is still a call to do_munmap() that does not check the return 
> > code, called from move_vma(), which in turn is called in do_mremap().
> > 
> > Can that call ever fail and cause Bad Things to happen?
> 
> Yes it can fail, and no, bad things can't happen. We could return the 
> error code to user space, but on the other hand, by the time the munmap 
> fails we would already have done 90% of the mremap(), so it doesn't much 
> help user space to know that the old area still has a vma, but no pages 
> associated with it.

which is a bug, mremap has to retire fully and it's not doing that
(obviously we don't want to write a retirement logic, we only want to
preallocate whatever needed so we don't need to retire), but it's not a
bad bug, since it only matters for real apps, an real apps will only
fall into this do_munamp due the oom condition, which isn't going to
trigger in do_munmap anyways, and even in the unlikely case that it does
it is extremly unlikely to generate an exploitable hole in the real (non
malicious) app.
