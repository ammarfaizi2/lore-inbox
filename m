Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262937AbUKYCpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbUKYCpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 21:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbUKYCnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 21:43:00 -0500
Received: from zeus.kernel.org ([204.152.189.113]:54668 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262856AbUKYCmS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 21:42:18 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 1/2] setup_arg_pages can insert overlapping vma
Date: Thu, 25 Nov 2004 08:44:06 +0800
Message-ID: <894E37DECA393E4D9374E0ACBBE7427013C9B1@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/2] setup_arg_pages can insert overlapping vma
Thread-Index: AcTSQwwJZvyCpvApTtKEUrqIueWKcwAQ/wMg
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Hugh Dickins" <hugh@veritas.com>
Cc: "Chris Wright" <chrisw@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Luck, Tony" <tony.luck@intel.com>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
       "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 25 Nov 2004 00:44:07.0257 (UTC) FILETIME=[DEBD1C90:01C4D287]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Hugh Dickins [mailto:hugh@veritas.com]
> Sent: Thursday, November 25, 2004 12:31 AM
> To: Zou, Nanhai
> Cc: Chris Wright; Andrew Morton; Linus Torvalds; Luck, Tony; Martin
Schwidefsky;
> Andi Kleen; linux-kernel@vger.kernel.org; linux-ia64@vger.kernel.org
> Subject: RE: [PATCH 1/2] setup_arg_pages can insert overlapping vma
> 
> Thanks a lot for taking this further.
> 
> Yes, I agree, that's a welcome improvement.  I'm surprised if all
> those ia64_elf32_init checks are necessary, but better safe than
sorry.
> 
> Something crosses my mind, you'll know better than I: is it possible
to
> construct ELFs or A.OUTs which would need the check in
insert_vm_struct
> to be even more defensive?  That is, should it also be checking that
> vma->vm_end > vma->vm_start (vma being the one to be inserted)?
> Or that vma->vm_end <= TASK_SIZE?  If I remember rightly, a 0-length
> vma can cause confusion but survive quite well until exit_mmap's
> BUG_ON(mm->map_count).
  Since all elf and a.out sections are inserted with do_mmap which takes
start_addr and an unsigned length as parameters. And do_mmap also check
for zero lenth mapping.
I think we could not have vma with (vma->vm_end <= vm->vm_start) by
construct a bad binary executable.

Zou Nan hai 
