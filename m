Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbTDEEiU (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 23:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTDEEiU (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 23:38:20 -0500
Received: from franka.aracnet.com ([216.99.193.44]:31886 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261789AbTDEEiT (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 23:38:19 -0500
Date: Fri, 04 Apr 2003 20:49:25 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Rik van Riel <riel@surriel.com>
cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <8950000.1049518163@[10.10.2.4]>
In-Reply-To: <20030405041018.GG993@holomorphy.com>
References: <20030405024414.GP16293@dualathlon.random> <Pine.LNX.4.44.0304042255390.32336-100000@chimarrao.boston.redhat.com> <20030405041018.GG993@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The only issues with objrmap seems to be mremap, which Hugh
>> seems to have taken care of, and the case of a large number
>> of processes mapping different parts of the same file multiple
>> times (1000 processes mapping each 1000 parts of the same file),
>> which would grow the complexity of the VMA search from linear
>> to quadratical.
>> That last case is also fixable, though, probably best done using
>> k-d trees.
>> Except for nonlinear VMAs I don't think there are any big obstacles
>> left that would keep us from switching to object rmap.
> 
> The k-d trees only solve the "external" interference case, that is,
> it thins the search space by eliminating vma's the page must
> necessarily be outside of.
> 
> They don't solve the "internal" interference case, where the page does
> fall into all of the vma's, but only a few out of those have actually
> faulted the page into the pagetables. This is likely only "fixable" by
> pointwise methods, which seem to come with notable maintenance expense.

I don't think we have an app that has 1000 processes mapping the whole
file 1000 times per process. If we do, shooting the author seems like 
the best course of action to me.

M.

