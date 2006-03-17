Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWCQRRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWCQRRe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932749AbWCQRRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:17:34 -0500
Received: from mx.pathscale.com ([64.160.42.68]:61381 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932748AbWCQRRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:17:33 -0500
Subject: Re: Remapping pages mapped to userspace (was: [PATCH 10 of 20]
	ipath - support for userspace apps using core driver)
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0603171631240.32660@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <20060309163740.0b589ea4.akpm@osdl.org>
	 <1142470579.6994.78.camel@localhost.localdomain>
	 <ada3bhjuph2.fsf@cisco.com>
	 <1142475069.6994.114.camel@localhost.localdomain>
	 <adaslpjt8rg.fsf@cisco.com>
	 <1142477579.6994.124.camel@localhost.localdomain>
	 <20060315192813.71a5d31a.akpm@osdl.org>
	 <1142485103.25297.13.camel@camp4.serpentine.com>
	 <20060315213813.747b5967.akpm@osdl.org>
	 <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
	 <adad5gmne20.fsf_-_@cisco.com>
	 <Pine.LNX.4.61.0603171631240.32660@goblin.wat.veritas.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 17 Mar 2006 09:17:28 -0800
Message-Id: <1142615848.28538.53.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 17:13 +0000, Hugh Dickins wrote:

> You seem to be asking to "revoke" an mmap:

Yes.  We'd like this ability, too.

> Though it looks like subsequent userspace accesses will then go to
> do_anonymous_page, giving ZERO_PAGE to read faults or a fresh anon
> page to write faults: I think I'd prefer it if pte_none accesses in
> a VM_PFNMAP area gave SIGBUS, but unsure if we can change that now.

It would be unfortunate if userspace were spinning on a chip register,
waiting for the register to transition from zero to non-zero, and we
replaced that mapping with an anonymous page.  In that case, userspace
could potentially spin forever, having no way to detect the demise of
the device.

	<b

