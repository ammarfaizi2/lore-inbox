Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268636AbRGZSXV>; Thu, 26 Jul 2001 14:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268635AbRGZSXB>; Thu, 26 Jul 2001 14:23:01 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:41745 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S268634AbRGZSWv>; Thu, 26 Jul 2001 14:22:51 -0400
Message-ID: <00bc01c11600$4c3901a0$bef7020a@mammon>
From: "Jeremy Linton" <jlinton@interactivesi.com>
To: <mingo@elte.hu>
Cc: "Anton Blanchard" <anton@samba.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107261423020.3796-200000@localhost.localdomain>
Subject: Re: highmem-2.4.7-A0 [Re: kmap() while holding spinlock]
Date: Thu, 26 Jul 2001 13:25:04 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> > [...] or to do the clearing (and copying) speculatively, after
> > allocating the page but before locking the pagetable lock. This might
> > lead to a bit more work in the pagefault-race case, but we dont care
> > about that window. It will on the other hand reduce pagetable_lock
> > contention (because the clearing/copying is done outside the lock), so
> > perhaps this solution is better.
>
> the attached highmem-2.4.7-A0 patch implements this method in both
> affected functions. Comments?
    It seems to me that the problem is more fundamental than that. Excuse my
ignorance, but what keeps the 'old_page' (and associated pte, checked two
lines down) from disappearing somewhere between the lock drop, alloc page
and the copy from the old page? Normally if this happens it appears the new
page gets dropped and the fault occurs again, and is resolved in a
potentially different way.



                                                                    jlinton


