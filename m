Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWAPQFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWAPQFw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 11:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWAPQFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 11:05:52 -0500
Received: from gold.veritas.com ([143.127.12.110]:39447 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751074AbWAPQFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 11:05:52 -0500
Date: Mon, 16 Jan 2006 16:06:21 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Christoph Lameter <clameter@engr.sgi.com>
cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
In-Reply-To: <Pine.LNX.4.62.0601160739360.19188@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0601161555130.9134@goblin.wat.veritas.com>
References: <20060114155517.GA30543@wotan.suse.de>
 <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com>
 <20060114181949.GA27382@wotan.suse.de> <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0601151053420.4500@goblin.wat.veritas.com>
 <Pine.LNX.4.62.0601152251080.17034@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0601161143190.7123@goblin.wat.veritas.com>
 <Pine.LNX.4.62.0601160739360.19188@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Jan 2006 16:05:51.0511 (UTC) FILETIME=[B8E65270:01C61AB6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006, Christoph Lameter wrote:
> On Mon, 16 Jan 2006, Hugh Dickins wrote:
> 
> > Or have you found the zero page mapcount distorting get_stats stats?
> > If that's an issue, then better add a commented test for it there.
> 
> It also applies to the policy compliance check.

Good point, I missed that: you've inadventently changed the behaviour
of sys_mbind when it encounters a zero page from a disallowed node.
Another reason to remove your PageReserved test.

Hugh
