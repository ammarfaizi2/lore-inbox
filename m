Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbUKFPx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbUKFPx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 10:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUKFPx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 10:53:28 -0500
Received: from canuck.infradead.org ([205.233.218.70]:33808 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261412AbUKFPxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 10:53:19 -0500
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages /
	all_unreclaimable braindamage
From: Arjan van de Ven <arjan@infradead.org>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <20041106154415.GD3851@dualathlon.random>
References: <20041105200118.GA20321@logos.cnet>
	 <200411051532.51150.jbarnes@sgi.com>
	 <20041106012018.GT8229@dualathlon.random>
	 <20041106100516.GA22514@logos.cnet>
	 <20041106154415.GD3851@dualathlon.random>
Content-Type: text/plain
Message-Id: <1099756374.2814.18.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 06 Nov 2004 16:52:54 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> yes. oom killing should be avoided as far as we can avoid it. Ideally we
> should never invoke the oom killer and we should always return -ENOMEM
> to applications. If a syscall runs oom then we can return -ENOMEM and
> handle the failure gracefully instead of getting a sigkill.
> 
> With 2.4 -ENOMEM is returned and the machine doesn't deadlock when the
> zone normal is full and that works fine.

the harder case is where you do an mmap and then in the fault path find out that there's no memory to allocate the PMD ...
killing the task that has that failing isn't per se the right answer.

