Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWAPPsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWAPPsK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWAPPsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:48:09 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:55454 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751027AbWAPPsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:48:08 -0500
Date: Mon, 16 Jan 2006 07:47:50 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
In-Reply-To: <Pine.LNX.4.61.0601161143190.7123@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.62.0601160739360.19188@schroedinger.engr.sgi.com>
References: <20060114155517.GA30543@wotan.suse.de>
 <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com>
 <20060114181949.GA27382@wotan.suse.de> <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0601151053420.4500@goblin.wat.veritas.com>
 <Pine.LNX.4.62.0601152251080.17034@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0601161143190.7123@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006, Hugh Dickins wrote:

> Indeed they are, at present and quite likely into posterity.  But
> they're not a common case here, and migrate_page_add now handles them
> silently, so why bother to complicate it with an unnecessary check?

check_range also is used for statistics and for checking if a range is 
policy compliant. Without that check zeropages may be counted or flagged 
as not on the right node with MPOL_MF_STRICT.

For migrate_page_add this has now simply become an optimization since
there is no WARN_ON occurring anymore.

> Or have you found the zero page mapcount distorting get_stats stats?
> If that's an issue, then better add a commented test for it there.

It also applies to the policy compliance check.

> Hmm, that battery of unusual tests at the start of migrate_page_add
> is odd: the tests don't quite match the comment, and it isn't clear
> what reasoning lies behind the comment anywa

Hmm.... Maybe better clean up the thing a bit. Will do that when I get 
back to work next week.

