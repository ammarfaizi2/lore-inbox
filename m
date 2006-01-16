Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWAPQvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWAPQvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 11:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWAPQvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 11:51:54 -0500
Received: from ns2.suse.de ([195.135.220.15]:23508 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751109AbWAPQvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 11:51:54 -0500
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: Race in new page migration code?
Date: Mon, 16 Jan 2006 17:51:26 +0100
User-Agent: KMail/1.8.2
Cc: Christoph Lameter <clameter@engr.sgi.com>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
References: <20060114155517.GA30543@wotan.suse.de> <Pine.LNX.4.62.0601160807580.19672@schroedinger.engr.sgi.com> <Pine.LNX.4.61.0601161620060.9395@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0601161620060.9395@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601161751.26991.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 January 2006 17:28, Hugh Dickins wrote:
> On Mon, 16 Jan 2006, Christoph Lameter wrote:
> > On Mon, 16 Jan 2006, Hugh Dickins wrote:
> > 
> > > > It also applies to the policy compliance check.
> > > 
> > > Good point, I missed that: you've inadventently changed the behaviour
> > > of sys_mbind when it encounters a zero page from a disallowed node.
> > > Another reason to remove your PageReserved test.
> > 
> > The zero page always come from node zero on IA64. I think this is more the 
> > inadvertent fixing of a bug. The policy compliance check currently fails 
> > if an address range contains a zero page but node zero is not contained in 
> > the nodelist.
> 
> To me it sounds more like you introduced a bug than fixed one.
> If MPOL_MF_STRICT and the zero page is found but not in the nodelist
> demanded, then it's right to refuse, I'd say.  If Andi shares your
> view that the zero pages should be ignored, I won't argue; but we
> shouldn't change behaviour by mistake, without review or comment.

I agree with Christoph that the zero page should be ignored - old behaviour
was really a bug.

-Andi
