Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVIBQkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVIBQkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 12:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVIBQkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 12:40:32 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:5089 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750713AbVIBQkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 12:40:32 -0400
Date: Fri, 02 Sep 2005 11:40:12 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: RE: [PATCH 1/1] Implement shared page tables
Message-ID: <3251CEDFF07A229DBFB81CE0@[10.1.1.4]>
In-Reply-To: <200509020158.j821wtg00465@unix-os.sc.intel.com>
References: <200509020158.j821wtg00465@unix-os.sc.intel.com>
X-Mailer: Mulberry/3.1.6 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, September 01, 2005 18:58:23 -0700 "Chen, Kenneth W"
<kenneth.w.chen@intel.com> wrote:

>> +		prio_tree_iter_init(&iter, &mapping->i_mmap,
>> +				    vma->vm_start, vma->vm_end);
> 
> 
> I think this is a bug.  The radix priority tree for address_space->
> i_mmap is keyed on vma->vm_pgoff.  Your patch uses the vma virtual
> address to find a shareable range, Which will always fail a match
> even though there is one.
>
> Do you really have to iterate through all the vma?  Can't you just break
> out of the while loop on first successful match and populating the pmd?
> I would think you will find them to be the same pte page. Or did I miss
> some thing?

Man, I spaced that whole search code.  I was sure I'd tested to make sure
it was finding matches.  I'll fix all that up in my next release.

Dave McCracken

