Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTJMBfk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 21:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTJMBfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 21:35:40 -0400
Received: from mail9.speakeasy.net ([216.254.0.209]:39907 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S261321AbTJMBfj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 21:35:39 -0400
Date: Sun, 12 Oct 2003 18:35:36 -0700
Message-Id: <200310130135.h9D1Zajj008309@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: torvalds@osdl.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] report user-readable fixmap area in /proc/PID/maps
In-Reply-To: Andrew Morton's message of  Sunday, 12 October 2003 18:17:57 -0700 <20031012181757.6272eaf5.akpm@osdl.org>
Emacs: featuring the world's first municipal garbage collector!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This special-casing, and the special-casing in get_user_pages() would go
> away if each process had a real VMA for the fixmap area inserted into its
> VMA tree.

Agreed.

> Remind me again why we cannot do that?

I don't know any reason to think we cannot.  That's not the way it was done
when I first looked at fixmap issues, and I try not to rock the boat more
than necessary (really!).  I know that Ingo had some kernel versions that
used a normal vma for it (and randomized the location on each exec), so he
certainly managed it.  I always assumed that people (i.e. Linus) wouldn't
like it because of the overhead in memory and setup time for an extra vma
that is identical in every process.  Given the constraint that the fixmap
area is the last thing in the address space, I imagine that can be
mitigated by some magic using a single shared fixmap_vma at the end of
everybody's chain.
