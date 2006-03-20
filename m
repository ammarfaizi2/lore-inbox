Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWCTLYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWCTLYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 06:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWCTLYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 06:24:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40337 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750812AbWCTLYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 06:24:52 -0500
Subject: Re: [3/3 PATCH] Kprobes: User space probes support- single
	stepping out-of-line
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: prasanna@in.ibm.com, ak@suse.de, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060320030922.4ea9445b.akpm@osdl.org>
References: <20060320060745.GC31091@in.ibm.com>
	 <20060320060931.GD31091@in.ibm.com> <20060320061014.GE31091@in.ibm.com>
	 <20060320061123.GF31091@in.ibm.com> <20060320030922.4ea9445b.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 12:24:01 +0100
Message-Id: <1142853841.3114.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And we'll need to actually *be* in-atomic.  That means we need an
> open-coded inc_preempt_count() and dec_preempt_count() in there and I don't
> see them.
> 

..

> Why is VM_LOCKED being set? (It needs a comment).
> 
> Where does it get unset?


if this is an attempt to make the copy_in_atomic to be atomic, then it
is a bug; the user can unset this bit after all via mprotect, even from
another thread, and concurrently. UnGood(tm).


