Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030535AbVIOQvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030535AbVIOQvL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 12:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030537AbVIOQvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 12:51:10 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:62067
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1030535AbVIOQvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 12:51:09 -0400
Date: Thu, 15 Sep 2005 18:51:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@novell.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: ptrace can't be transparent on readonly MAP_SHARED
Message-ID: <20050915165117.GE4122@opteron.random>
References: <20050914212405.GD4966@opteron.random> <Pine.LNX.4.61.0509151337260.16231@goblin.wat.veritas.com> <Pine.LNX.4.58.0509150805150.26803@g5.osdl.org> <20050915154702.GA4122@opteron.random> <Pine.LNX.4.58.0509150911180.26803@g5.osdl.org> <20050915162347.GC4122@opteron.random> <Pine.LNX.4.58.0509150928030.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509150928030.26803@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 09:34:12AM -0700, Linus Torvalds wrote:
> If you think the data is wrong, then you are arguing against the COW. Yes, 
> the COW will make the data "wrong", but you can't escape that. That's what 
> a "write" by ptrace does.

My point is that exactly because this is the wrong page with the wrong
data with the wrong ptrace usage, these kind of things will happen in a
very controlled environment, so if you can deal with the wrong data and
the wrong page with wrong ptrace usage, you can sure deal with the pte
being writeable too. Especially the ptrace over PROT_NONE that you
mentioned is a total nosense, so that is really wrong ptrace usage, it's
not worth it to even try to make transparent such a wrong usage of ptrace.

I don't see why the kernel should bother to fix an unfixable case.

The only thing we might want to argue about is the ptrace over anonymous
memory (not the subject here but still affected by my changes), that
is the only one that can work right and it does currently, but even that
is quite a corner case that doesn't seem worth it IMHO since ptrace on
readonly vma is a corner case since the first place.
