Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVCTAhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVCTAhg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 19:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVCTAhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 19:37:36 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:31673
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261945AbVCTAhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 19:37:32 -0500
Date: Sat, 19 Mar 2005 16:27:29 -0800
From: "David S. Miller" <davem@davemloft.net>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, rohit.seth@intel.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] arch hook for notifying changes in PTE protections bits
Message-Id: <20050319162729.12d6789d.davem@davemloft.net>
In-Reply-To: <16956.35789.229286.442052@napali.hpl.hp.com>
References: <01EF044AAEE12F4BAAD955CB75064943033468DE@scsmsx401.amr.corp.intel.com>
	<16956.35789.229286.442052@napali.hpl.hp.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Mar 2005 12:30:05 -0800
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> I agree about your concern about cost.  Accessing the page_map is
> expensive (integer division + memory access) and we have to do that in
> order to find out if the page is i-cache clean.

First, it's a multiply by reciprocol.  At least on sparc64 I get
this emitted by the compiler.

Secondly, if you're willing to sacrifice 8 bytes per page struct
simply define WANT_PAGE_VIRTUAL and page struct will be exactly
64 bytes and thus the divide a will turn into a simple shift.
