Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbVKQTlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbVKQTlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbVKQTlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:41:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1518 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964829AbVKQTlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:41:20 -0500
Date: Thu, 17 Nov 2005 14:41:02 -0500
From: Dave Jones <davej@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] unpaged: private write VM_RESERVED
Message-ID: <20051117194102.GE5772@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com> <Pine.LNX.4.61.0511171929210.4563@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511171929210.4563@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 07:30:04PM +0000, Hugh Dickins wrote:
 > The PageReserved removal in 2.6.15-rc1 issued a "deprecated" message
 > when you tried to mmap or mprotect MAP_PRIVATE PROT_WRITE a VM_RESERVED,
 > and failed with -EACCES: because do_wp_page lacks the refinement to COW
 > pages in those areas, nor do we expect to find anonymous pages in them;
 > and it seemed just bloat to add code for handling such a peculiar case.
 > But immediately it caused vbetool and ddcprobe (using lrmi) to fail.
 > 
 > So revert the "deprecated" messages, letting mmap and mprotect succeed.
 > But leave do_wp_page's BUG_ON(vma->vm_flags & VM_RESERVED) in place
 > until we've added the code to do it right: so this particular patch is
 > only good if the app doesn't really need to write to that private area.
 > 
 > Dave Jones has changed vbetool & ddcprobe to use MAP_SHARED or PROT_READ
 > just as well, but we don't want to force people to update their tools.

Actually Dave Miller did the detective work on that one, I just
rebuilt some packages, and spread the good word :)

		Dave

