Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266637AbSKLRaO>; Tue, 12 Nov 2002 12:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266639AbSKLRaO>; Tue, 12 Nov 2002 12:30:14 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:41433 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S266637AbSKLRaN>;
	Tue, 12 Nov 2002 12:30:13 -0500
Date: Tue, 12 Nov 2002 17:36:42 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       "'mingo@redhat.com'" <mingo@redhat.com>,
       "'Mark Mielke'" <mark@mark.mielke.cc>, linux-kernel@vger.kernel.org
Subject: Re: Users locking memory using futexes
Message-ID: <20021112173642.GA14034@bjl1.asuk.net>
References: <A46BBDB345A7D5118EC90002A5072C7806CAC921@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7806CAC921@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perez-Gonzalez, Inaky wrote:
> Good thing is - I just found out after reading twice - that FUTEX_FD does
> not lock the page in memory, so that is one case less to worry about. 

Oh yes it does - the page isn't unpinned until wakeup or close.
See where it says in futex_fd():

	page = NULL;
out:
	if (page)
		unpin_page(page);

Rusty's got a good point about pipe() though.

Btw, maybe GnuPG can use this "feature" to lock it's crypto memory in RAM :)

-- Jamie
