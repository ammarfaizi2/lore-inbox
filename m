Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319331AbSH3Cfq>; Thu, 29 Aug 2002 22:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319339AbSH3Cfq>; Thu, 29 Aug 2002 22:35:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16132 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319331AbSH3Cfp>;
	Thu, 29 Aug 2002 22:35:45 -0400
Message-ID: <3D6EDDC0.F9ADC015@zip.com.au>
Date: Thu, 29 Aug 2002 19:51:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com
Subject: Re: statm_pgd_range() sucks!
References: <20020830015814.GN18114@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> Okay, I have *had it* with statm_pgd_range()!

It's certainly very bad.  A measurement tools shouldn't be perturbing
the system so much as to invalidate the results of other measurement
tools, and this one does.

I have several times had colleagues peering at kernel code wondering
why their application was spending so long in statm_pgd_range when
it really wasn't.

> ...
> (1) shared, lib, text, & total are now reported as what's mapped
>         instead of what's resident. This actually fixes two bugs:

hmm.  Personally, I've never believed, or even bothered to try to
understand what those columns are measuring.  Does anyone actually
find them useful for anything?  If so, what are they being used for?
What info do we really, actually want to know?

Reporting the size of the vma is really inaccurate for many situations, 
and the info which you're showing here can be generated from
/proc/pid/maps.  And it would be nice to get something useful out of this.

Would it be hard to add an `nr_pages' occupancy counter to vm_area_struct?
Go and add all those up?

BTW, Rohit's hugetlb patch touches proc_pid_statm(), so a diff on -mm3
would be appreciated.
