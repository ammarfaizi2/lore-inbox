Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275470AbRIZSvW>; Wed, 26 Sep 2001 14:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275471AbRIZSvM>; Wed, 26 Sep 2001 14:51:12 -0400
Received: from chiara.elte.hu ([157.181.150.200]:16396 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S275470AbRIZSvA>;
	Wed, 26 Sep 2001 14:51:00 -0400
Date: Wed, 26 Sep 2001 20:48:57 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Ben LaHaise <bcrl@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
In-Reply-To: <20010926104800.A1143@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0109262046450.7584-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Sep 2001, Mike Kravetz wrote:

> > +	if (!p->has_cpu && (p != current) && task_on_runqueue(p)) {

> Is it really possible for a task to be 'current' without having
> 'has_cpu' set?  If so, then don't you need to compare p to 'current'
> on all CPUs since 'current' is CPU specific?

you are correct that the check is redundant on SMP, but ->has_cpu is not
set on UP kernels, so the 'current' check is needed there. I did not want
to introduce yet another #if CONFIG_SMP ifdef.

	Ingo

