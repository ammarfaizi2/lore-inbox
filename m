Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbVCWCK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVCWCK7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 21:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbVCWCK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 21:10:58 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:14037
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262702AbVCWCKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 21:10:52 -0500
Date: Tue, 22 Mar 2005 18:09:13 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322180913.06910ce0.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0503230040210.10858@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
	<20050322034053.311b10e6.akpm@osdl.org>
	<Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com>
	<20050322110144.3a3002d9.davem@davemloft.net>
	<20050322112125.0330c4ee.davem@davemloft.net>
	<20050322112329.70bde057.davem@davemloft.net>
	<Pine.LNX.4.61.0503221931150.9348@goblin.wat.veritas.com>
	<20050322123301.090cbfa6.davem@davemloft.net>
	<Pine.LNX.4.61.0503222142280.9761@goblin.wat.veritas.com>
	<20050322144151.5b08b047.davem@davemloft.net>
	<Pine.LNX.4.61.0503230040210.10858@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005 00:51:02 +0000 (GMT)
Hugh Dickins <hugh@veritas.com> wrote:

> This actual example helped to focus my mind a lot, thank you.

No problem, I needed to work through specific examples
to see things clearly too.

> > and things seem to behave.  I'll try to analyze things
> > further and test this out on a real kernel, but all of
> > these adjustments at the top of free_pgd_range() really
> > start to look like pure spaghetti. :-)
> 
> Well, it's trying to decide in reasonably few steps that it's not
> worth wasting time going down to the deeper levels.  Lots of
> "return"s as it eliminates cases, yes.

Yes, I understand.

But let's recognize (as I mention in another email) that all of
the tests against ceiling are against "ceiling - 1".  If we pass
-1 instead of 0 (and "foo - 1" instead of "foo") as the ceiling
arg, then adjust the tests to be against plain "ceiling", so much
of the special casing disappears.

There are probably other simplifications.

This is kind of what I was hinting at when I said it looks like
spaghetti.  :-)
