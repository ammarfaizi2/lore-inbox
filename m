Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVHBIHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVHBIHg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 04:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVHBIHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 04:07:33 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:6275 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261417AbVHBIHb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 04:07:31 -0400
In-Reply-To: <Pine.LNX.4.58.0508011238330.3341@g5.osdl.org>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Roland McGrath <roland@redhat.com>
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OFAD9E831B.5D9FB95C-ON42257051.002BC8C3-42257051.002CA1EB@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 2 Aug 2005 10:07:30 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 02/08/2005 10:07:28
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote on 08/01/2005 09:48:40 PM:

> > Attractive, I very much wanted to do that rather than change all the
> > arches, but I think s390 rules it out: its pte_mkdirty does nothing,
> > its pte_dirty just says no.
>
> How does s390 work at all?

The big difference between s390 and your standard architecture is that
s390 keeps the dirty and reference bits in the storage key. That is
per physical page and not per mapping. The primitive pte_dirty() just
doesn't make any sense for s390. A pte never contains any information
about dirty/reference state of a page. The "page" itself contains it,
you access the information with some instructions (sske, iske & rrbe)
which get the page frame address as parameter.

> > Or should we change s390 to set a flag in the pte just for this purpose?
>
> If the choice is between a broken and ugly implementation for everybody
> else, then hell yes. Even if it's a purely sw bit that nothing else
> actually cares about.. I hope they have an extra bit around somewhere.

Urg, depending on the pte type there are no bits available. For valid ptes
there are some bits we could use but it wouldn't be nice.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

