Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262262AbRE0VC3>; Sun, 27 May 2001 17:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262281AbRE0VCU>; Sun, 27 May 2001 17:02:20 -0400
Received: from chiara.elte.hu ([157.181.150.200]:52232 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S262262AbRE0VCM>;
	Sun, 27 May 2001 17:02:12 -0400
Date: Sun, 27 May 2001 23:00:08 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] severe softirq handling performance bug, fix, 2.4.5
In-Reply-To: <20010527215528.A731@athlon.random>
Message-ID: <Pine.LNX.4.33.0105272255560.6868-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 May 2001, Andrea Arcangeli wrote:

> Yes the stock kernel.

yep you are right.

i had this fixed too at a certain point, there is one subtle issue: under
certain circumstances tasklets re-activate the tasklet softirq(s) from
within the softirq handler, which leads to infinite loops if we just
naively restart softirq handling. This fix is not in the -B0 patch yet.

	Ingo

