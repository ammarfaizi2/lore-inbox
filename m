Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSIEG0l>; Thu, 5 Sep 2002 02:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSIEG0l>; Thu, 5 Sep 2002 02:26:41 -0400
Received: from holomorphy.com ([66.224.33.161]:30633 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316578AbSIEG0k>;
	Thu, 5 Sep 2002 02:26:40 -0400
Date: Wed, 4 Sep 2002 23:22:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, riel@surriel.com
Subject: Re: statm_pgd_range() sucks!
Message-ID: <20020905062228.GA888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, riel@surriel.com
References: <20020830015814.GN18114@holomorphy.com> <3D6EDDC0.F9ADC015@zip.com.au> <20020905032035.GY888@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020905032035.GY888@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 07:51:44PM -0700, Andrew Morton wrote:
>> BTW, Rohit's hugetlb patch touches proc_pid_statm(), so a diff on -mm3
>> would be appreciated.

On Wed, Sep 04, 2002 at 08:20:35PM -0700, William Lee Irwin III wrote:
> I lost track of what the TODO's were but this is of relatively minor
> import, and I lagged long enough this is against 2.5.33-mm2:

doh! I dropped a line merging by hand and broke VSZ

on top of the prior one:


diff -u linux-wli/fs/proc/array.c linux-wli/fs/proc/array.c
--- linux-wli/fs/proc/array.c		2002-09-02 23:37:17.000000000 -0700
+++ linux-wli/fs/proc/array.c		2002-09-02 23:37:17.000000000 -0700
@@ -409,6 +409,7 @@
 	resident = mm->rss;
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		int pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+		size += pages;
 		if (is_vm_hugetlb_page(vma)) {
 			if (!(vma->vm_flags & VM_DONTCOPY))
 				shared += pages;
