Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265446AbUGGUrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265446AbUGGUrn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 16:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265462AbUGGUrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 16:47:43 -0400
Received: from mail1.speakeasy.net ([216.254.0.201]:29094 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S265446AbUGGUrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 16:47:37 -0400
Date: Wed, 7 Jul 2004 13:47:33 -0700
Message-Id: <200407072047.i67KlXk5028719@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: davidm@hpl.hp.com
X-Fcc: ~/Mail/linus
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: ptrace "fix" breaks ia64
In-Reply-To: David Mosberger's message of  Wednesday, 7 July 2004 11:22:41 -0700 <16620.16241.664033.493568@napali.hpl.hp.com>
X-Windows: foiled again.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is due to the fact that the gate page on ia64 really does
> live in the kernel-mapped segment (as your original code correctly
> assumed).  Furthermore, pgd_offset_k() is different from pgd_offset()
> since the kernel-mapped segment gets a full page-directory inside a
> single region, whereas user-space regions get only 1/8th of a
> page-directory, so it's not OK to use pgd_offset() in lieu of
> pgd_offset().

Sorry.  I skimmed all the code and comments for pgd_offset_k and thought at
the time that it was strictly an optimized shortcut for pgd_offset.
Clearly I did not understand the ia64 code.

> I suppose we could have a new macro pgd_offset_gate() or something
> along those lines to accommodate platform-differences in where the
> gage page lives.

That seems like the reasonable thing to do.  I considered just putting all
that logic into arch-specific code, joining with the get_gate_vma code.
But that would leave x86_64 requiring duplication of the generic version.
At least with the various arch cases around now, just adding pgd_offset_gate 
is the thing that will allow maximal code sharing.


Thanks,
Roland
