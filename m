Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265026AbSJPPBf>; Wed, 16 Oct 2002 11:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265027AbSJPPBf>; Wed, 16 Oct 2002 11:01:35 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:36774 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S265026AbSJPPBb>; Wed, 16 Oct 2002 11:01:31 -0400
Date: Wed, 16 Oct 2002 16:08:17 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Dave McCracken <dmccr@us.ibm.com>
cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.42-mm3] Fix mremap for shared page tables
In-Reply-To: <291360000.1034721127@baldur.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0210161543170.1320-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, Dave McCracken wrote:
> 
> Hugh Dickens was right.  mremap was broken wrt shared page tables.
           i

Sorry, Dave, I only mentioned mremap as one _example_.  You have
changed the locking rules for ptes in page tables in two or three
sources, but there's a number more which need to be updated too.

Please don't ask me to list which, it's a matter of looking at all
the uses of ->page_table_lock and whether those places need to be
changed to fit the new locking scheme - some of the uses are quite
irrelevant, some may be obscure, some may be historic, some must
be changed.

I wouldn't mind if it was just broken wrt shared page tables,
CONFIG_SHAREPTE is easily made experimental.  But the locking rules
have (rightly) been changed in all cases, so -mm tree is now unsafe.
A stopgap measure might be to hold on to page_table_lock for as
long as before, then fix sources up piecemeal - but that approach
would still leave CONFIG_SHAREPTE y broken for a while.

Let me say again, that I have _not_ actually observed any problem
yet: we're talking about races and correctness, I don't mean to be
alarmist.

Hugh

