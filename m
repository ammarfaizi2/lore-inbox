Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWFTOyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWFTOyP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWFTOyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:54:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39902 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751191AbWFTOyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:54:14 -0400
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock
	and NMI)
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Dave Olson <olson@unixfolk.com>, ccb@acm.org,
       linux-kernel@vger.kernel.org, Peter Chubb <peter@chubb.wattle.id.au>
In-Reply-To: <4497F9F1.8060708@yahoo.com.au>
References: <fa.VT2rwoX1M/2O/aO5crhlRDNx4YA@ifi.uio.no>
	 <fa.Zp589GPrIISmAAheRowfRgZ1jgs@ifi.uio.no>
	 <Pine.LNX.4.61.0606192231380.25413@osa.unixfolk.com>
	 <20060619233947.94f7e644.akpm@osdl.org> <4497A5BC.4070005@yahoo.com.au>
	 <20060620083305.GB7899@elte.hu> <4497C1BC.9090601@yahoo.com.au>
	 <20060620095135.GC11037@elte.hu>  <4497D4FF.6000706@yahoo.com.au>
	 <1150808692.2891.194.camel@laptopd505.fenrus.org>
	 <4497F9F1.8060708@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 16:53:57 +0200
Message-Id: <1150815237.2891.205.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Taking the lock is going to transiation the cacheline to exclusive. If
> the next locker tries to take the lock, they transfer the cacheline and
> exclusive access and fail. If they have already tried to take the lock
> earlier, they might only request a readonly state, but it still requires
> a cacheline transfer (which is the expensive part).

the "which is the expensive part" isn't entirely true on modern hardware
(and for sure not on multicore systems); due to various bus snooping
tricks and other "pass-the-cacheline" tricks this is relatively cheap;
not free obviously but not nearly as expensive as the exclusive part.


