Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVHBMBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVHBMBc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 08:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVHBMBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 08:01:32 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:26331 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261456AbVHBMBb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 08:01:31 -0400
In-Reply-To: <Pine.LNX.4.58.0508011455520.3341@g5.osdl.org>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Roland McGrath <roland@redhat.com>
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OF3BCB86B7.69087CF8-ON42257051.003DCC6C-42257051.00420E16@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 2 Aug 2005 14:01:29 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 02/08/2005 14:01:28
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Any chance you can change the __follow_page test to account for
> > writeable clean ptes? Something like
> >
> >       if (write && !pte_dirty(pte) && !pte_write(pte))
> >               goto out;
> >
> > And then you would re-add the set_page_dirty logic further on.
>
> Hmm.. That should be possible. I wanted to do the simplest possible code
> sequence, but yeah, I guess there's nothing wrong with allowing the code
> to dirty the page.
>
> Somebody want to send me a proper patch? Also, I haven't actually heard
> from whoever actually noticed the problem in the first place (Robin?)
> whether the fix does fix it. It "obviously does", but testing is always
> good ;)

Why do we require the !pte_dirty(pte) check? I don't get it. If a writeable
clean pte is just fine then why do we check the dirty bit at all? Doesn't
pte_dirty() imply pte_write()?

With the additional !pte_write(pte) check (and if I haven't overlooked
something which is not unlikely) s390 should work fine even without the
software-dirty bit hack.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


