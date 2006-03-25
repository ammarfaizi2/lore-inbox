Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWCYH3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWCYH3E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 02:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWCYH3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 02:29:04 -0500
Received: from fmr21.intel.com ([143.183.121.13]:9175 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751094AbWCYH3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 02:29:03 -0500
Message-Id: <200603250728.k2P7Sog25321@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <mrustad@mac.com>, <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.16 hugetlbfs problem - DEBUG_PAGEALLOC
Date: Fri, 24 Mar 2006 23:29:13 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZPt8w8jvh3AqMrQ36wszHss0cG1AAInGLw
In-Reply-To: <20060324185331.56837b0a.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Friday, March 24, 2006 6:54 PM
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> >
> > Mark Rustad wrote on Friday, March 24, 2006 9:52 AM
> >  > I have narrowed this down to DEBUG_PAGEALLOC. If that option is  
> >  > enabled, attempts to reference areas mmap-ed from hugetlbfs files  
> >  > fault forever. You can see that I had that set in the failing config  
> >  > I reported below.
> > 
> >  Yeah, it turns out that the debug option is not compatible with hugetlb
> >  page support. That debug option turns off PSE. Once it is turned off in
> >  CR4, cpu will ignore pse bit in the pmd and causing infinite page-not-
> >  present fault :-(
> 
> I wonder if any of the other architectures which implement both these
> features might have problems too.


Only 32-bit x86 arch implements both. We get away by not having DEBUG_PAGEALLOC
feature on any other arch.

I read the ia32 processor manual, it says the pse flag in CR4 controls
4K/4M mapping in addition to pse bit in page directory entry.  But in
PAE mode, cr4.pse is ignored and pse bit in pmd controls 4K/2M mapping.
I was going to verify that on my ia32 box, but apparently, turning on
64G highmem gives me machine reset at boot. (is it a known regression?)

X86-64 surly ignores cr4.pse for 4K/2M mapping. It is solely controlled
by pse bit in pmd.

- Ken

