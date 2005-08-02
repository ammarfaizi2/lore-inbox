Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVHBQoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVHBQoV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 12:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVHBQoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 12:44:21 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:17076 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261639AbVHBQoU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 12:44:20 -0400
In-Reply-To: <Pine.LNX.4.58.0508020829010.3341@g5.osdl.org>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Roland McGrath <roland@redhat.com>
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OFD58BB32F.D2A5CB19-ON42257051.005B9FC2-42257051.005BF25A@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 2 Aug 2005 18:44:18 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 02/08/2005 18:44:17
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote on 08/02/2005 05:30:37 PM:

> > With the additional !pte_write(pte) check (and if I haven't overlooked
> > something which is not unlikely) s390 should work fine even without the
> > software-dirty bit hack.
>
> No it won't. It will just loop forever in a tight loop if somebody tries
> to put a breakpoint on a read-only location.

Yes, I have realized that as well nowe after staring at the code a little
bit longer. That maybe_mkwrite is really tricky.

> On the other hand, this being s390, maybe nobody cares?

Some will care. At least I do. I've tested the latest git with gdb and
it will indeed loop forever if I try to write to a read-only vma.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

