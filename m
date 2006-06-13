Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWFMR2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWFMR2X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 13:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWFMR2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 13:28:23 -0400
Received: from gold.veritas.com ([143.127.12.110]:4995 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750807AbWFMR2W (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 13:28:22 -0400
X-IronPort-AV: i="4.06,128,1149490800"; 
   d="scan'208"; a="60564170:sNHT29093900"
Date: Tue, 13 Jun 2006 18:28:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Rohit Seth <rohitseth@google.com>
cc: Andi Kleen <ak@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, Linux-mm@kvack.org,
       Linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number of
 physical pages backing it
In-Reply-To: <1150217948.9576.67.camel@galaxy.corp.google.com>
Message-ID: <Pine.LNX.4.64.0606131814110.4501@blonde.wat.veritas.com>
References: <1149903235.31417.84.camel@galaxy.corp.google.com> 
 <200606121958.41127.ak@suse.de>  <1150141369.9576.43.camel@galaxy.corp.google.com>
  <200606130551.23825.ak@suse.de> <1150217948.9576.67.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Jun 2006 17:28:22.0301 (UTC) FILETIME=[C4EFECD0:01C68F0E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006, Rohit Seth wrote:
> On Tue, 2006-06-13 at 05:51 +0200, Andi Kleen wrote:
> > 
> > I think we first need to identify the basic need.
> > Don't see why we even need per VMA information so far.
> 
> This information is for user land applications to have the knowledge of
> which virtual ranges are getting actively used and which are not.
> This information then can be fed into a new system call
> sys_change_page_activation(pid, start_va, len, flag).  The purpose of
> this system call would be to give hints to kernel that certain physical
> pages are okay to be inactivated (or vice versa).   

Then perhaps you want a sys_report_page_activation(pid, start_va, len, ...)
which would examine and report on the range in question, instead of adding
your count to so many vmas on which this will never be used.

Though your syscall sounds like pid_madvise: perhaps the call name
should be less specific and left to the flags (come, gentle syscall
multiplexing flames, and warm me).

Looking through the existing fields of a vma, it seems a vm_area_struct
would commonly be on clean cachelines: your count making one of them
now commonly and bouncily dirty.

Hugh
