Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263746AbUDVHyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263746AbUDVHyL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263729AbUDVHwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:52:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49309 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263826AbUDVHvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:51:25 -0400
Date: Thu, 22 Apr 2004 03:50:54 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Hugh Dickins <hugh@veritas.com>
cc: Jamie Lokier <jamie@shareable.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Non-linear mappings and truncate/madvise(MADV_DONTNEED)
In-Reply-To: <Pine.LNX.4.44.0404191548030.24243-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0404220349040.13746@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0404191548030.24243-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Apr 2004, Hugh Dickins wrote:

> rmap 6 nonlinear truncation (which never appeared on LKML, though
> sent twice) fixed most of this, and went into 2.6.6-rc1-bk4 last
> night: please check it out.
> 
> But I just converted madvise_dontneed by rote, adding a NULL arg to
> zap_page_range, missing your point that it should respect nonlinearity.
> 
> And I made the zap_details structure private to mm/memory.c since I
> hadn't noticed anything outside needing it: I'll fix that up later and
> post a patch.
> 
> I'm haven't and don't intend to change the behaviour of ->populate,
> without agreement from others - Ingo? Jamie?

feel free. I've got followup work, protection bits stored in the swap pte,
thus per-page protection possible via remap_file_pages_prot(). (earlier
-mm trees had this but it clashed with objrmap which has priority.)

	Ingo
