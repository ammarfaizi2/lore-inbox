Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131105AbRCGQdB>; Wed, 7 Mar 2001 11:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131110AbRCGQcw>; Wed, 7 Mar 2001 11:32:52 -0500
Received: from colorfullife.com ([216.156.138.34]:53003 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131105AbRCGQcn>;
	Wed, 7 Mar 2001 11:32:43 -0500
Message-ID: <004701c0a724$45004240$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <linux-kernel@vger.kernel.org>
Subject: BUG? race between kswapd and ptrace (access_process_vm )
Date: Wed, 7 Mar 2001 17:32:43 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is kswapd now running without lock_kernel()?

Then there is a race between swapout and ptrace:
access_process_vm() accesses the page table entries, only protected with
the mmap_sem semaphore and lock_kernel().

Isn't

    spin_lock(&mm->page_table_lock);

missing in access_one_page() [in linux/kernel/ptrace.c]?

--
    Manfred

