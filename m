Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265934AbUBCI3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 03:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265937AbUBCI3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 03:29:20 -0500
Received: from mx1.elte.hu ([157.181.1.137]:19146 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265934AbUBCI3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 03:29:14 -0500
Date: Tue, 3 Feb 2004 09:29:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore protections after forced fault in get_user_pages
Message-ID: <20040203082949.GA1116@elte.hu>
References: <200402030009.i1309TeY016316@magilla.sf.frob.com> <Pine.LNX.4.58.0402021616340.9720@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402021616340.9720@home.osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin 2.60
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> > I think this question is orthogonal to my concern about follow_page.
> 
> The follow_page issue should be fixable by just marking the _page_
> dirty inside the ptrace routines. I think we do that anyway (or we'd
> already be buggy wrt perfectly normal writes).

the follow_page() issue could be handled like the 4/4 patch does it: a
repeat-until loop of manual-fault + lookup-pte (we break out of the loop
if the manual fault fails or when the lookup is successful). The race
window is so small that the repeating solution is i think far superior
to artificially dirtying the pte.

	Ingo
