Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271110AbUJVBgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271110AbUJVBgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271169AbUJVBbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:31:22 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:23735 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S271176AbUJVBVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:21:32 -0400
Date: Fri, 22 Oct 2004 03:22:11 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: shaggy@austin.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
Message-ID: <20041022012211.GD14325@dualathlon.random>
References: <1098393346.7157.112.camel@localhost> <20041021144531.22dd0d54.akpm@osdl.org> <20041021223613.GA8756@dualathlon.random> <20041021160233.68a84971.akpm@osdl.org> <20041021232059.GE8756@dualathlon.random> <20041021164245.4abec5d2.akpm@osdl.org> <20041022003004.GA14325@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022003004.GA14325@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 02:30:04AM +0200, Andrea Arcangeli wrote:
> If you want to shootdown ptes before clearing the bitflag, that's fine

small correction s/before/after/. doing the pte shootdown before
clearing the uptodate bitflag, would still not guarantee to read
uptodate data after the invalidate (a minor page fault could still
happen between the shootdown and the clear_bit; while after clearing the
uptodate bit a major fault hitting the disk and refreshing the pagecache
contents will be guaranteed - modulo bhs, well at least nfs is sure ok
in that respect ;).
