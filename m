Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbVCWCCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbVCWCCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 21:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbVCWCCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 21:02:12 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:46556
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262697AbVCWCCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 21:02:08 -0500
Date: Tue, 22 Mar 2005 18:00:20 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Andrew Morton <akpm@osdl.org>
Cc: hugh@veritas.com, tony.luck@intel.com, nickpiggin@yahoo.com.au,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322180020.7ce75c30.davem@davemloft.net>
In-Reply-To: <20050322171013.5c52dd18.akpm@osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03211851@scsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.61.0503230052500.10858@goblin.wat.veritas.com>
	<20050322171013.5c52dd18.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 17:10:13 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Hugh Dickins <hugh@veritas.com> wrote:
> >
> > On Tue, 22 Mar 2005, Luck, Tony wrote:
> >  > 
> >  > But I'm still confused by all the math on addr/end at each
> >  > level.
> > 
> >  You think the rest of us are not ;-?
> 
> umm, given the difficulty which you guys are having with this, I get a bit
> worried about clarity, simplicity and maintainability of the end result.

We're working on it, trust me :-)

I have a simplification in mind that should take care of the issue
that led us to these problems.  We should simply pass in "ceiling"
as "-1" instead of "0".  Every single test against ceiling is
really done against "ceiling - 1".

Therefore, passing ceiling in as "top - 1" and then adjusting the
tests will clean this up substantially and make is much simpler.

I'm even sure that other similar refactoring is possible.

Hugh took the quantum leap we needed by implementing this at all,
some spaghetti code tests do not detract from his work conceptually.
That kind of stuff can be cleaned up.
