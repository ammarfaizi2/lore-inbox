Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVCVXqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVCVXqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 18:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVCVXqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 18:46:42 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:11454
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262423AbVCVXqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 18:46:39 -0500
Date: Tue, 22 Mar 2005 15:44:59 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: hugh@veritas.com, akpm@osdl.org, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322154459.7afb4f4f.davem@davemloft.net>
In-Reply-To: <4240AAFA.1040206@yahoo.com.au>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
	<20050322034053.311b10e6.akpm@osdl.org>
	<Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com>
	<20050322110144.3a3002d9.davem@davemloft.net>
	<20050322112125.0330c4ee.davem@davemloft.net>
	<20050322112329.70bde057.davem@davemloft.net>
	<Pine.LNX.4.61.0503221931150.9348@goblin.wat.veritas.com>
	<20050322123301.090cbfa6.davem@davemloft.net>
	<Pine.LNX.4.61.0503222142280.9761@goblin.wat.veritas.com>
	<4240AAFA.1040206@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005 10:32:10 +1100
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> I think David's on the right track - I think there's something a
> bit wrong at the top. In my reply to Andrew in this thread I
> posted a patch which may at least get things working...

We have to do the "if (ceiling)" check in every spot where
we mask it in some way, and if it falls to zero from non-zero
due to the masking, we skip.

That gives me a mostly working kernel.

Bad news is that while lat_proc's fork and exec tests improve
dramatically, shell performance is way down on sparc64.
I'll post before and after numbers in a bit.  Note, this is
just with Hugh's base patch plus bug fixes.
