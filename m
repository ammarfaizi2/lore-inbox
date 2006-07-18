Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWGRUjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWGRUjD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 16:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWGRUjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 16:39:03 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:51181
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932375AbWGRUjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 16:39:02 -0400
Date: Tue, 18 Jul 2006 13:39:24 -0700 (PDT)
Message-Id: <20060718.133924.71552173.davem@davemloft.net>
To: chrisw@sous-sol.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, jeremy@goop.org, ak@suse.de,
       akpm@osdl.org, rusty@rustcorp.com.au, zach@vmware.com,
       ian.pratt@xensource.com, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [RFC PATCH 23/33] subarch TLB support
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060718091954.271792000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	<20060718091954.271792000@sous-sol.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wright <chrisw@sous-sol.org>
Date: Tue, 18 Jul 2006 00:00:23 -0700

> +        BUG_ON(HYPERVISOR_mmuext_op(&op, 1, NULL, DOMID_SELF) < 0);

Although it happens to work currently, I think we should get out of
the habit of putting operations with wanted side effects into BUG_ON()
calls.  The following is therefore more preferable:

	ret = HYPERVISOR_mmuext_op(&op, 1, NULL, DOMID_SELF);
	BUG_ON(ret < 0);

If this were ASSERT() in userspace, turning off debugging at build
time would make the evaluations inside of the macro never occur.  It
is my opinion that BUG_ON() should behave similarly.

