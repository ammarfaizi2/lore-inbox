Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263639AbUJ2Vhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbUJ2Vhv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263617AbUJ2Vd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:33:28 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:57057 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263608AbUJ2VbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:31:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=AeOVXw9Ex5O0tihaN+wqdK4Yl/1CEnA/MlXZUIwX5TkgNecCJHCAGqKyCcaPyeKRV5nl68T9PSPU5wwf8ScbqiSIfngeYX7raBlVzMsoT5KEQMqoXaMOHr5sYP9/9iUtdX8zvsUxznIIrVd/O12UCPYGctXEuml5nozmSx/+Yt0=
Message-ID: <3f250c71041029143074a8221e@mail.gmail.com>
Date: Fri, 29 Oct 2004 19:30:59 -0200
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Segmentation fault to detect resident memory size
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I had implemented a new entry in proc directory called smaps for
kernel 2.6.1 and it is working.

I have tried to upgrade it to kernel 2.6.9 but a segmentation fault is
thrown on my shell when I cat the /proc/PID/smaps entry.

Below is the code. It is the same code I had implemented for kernel
2.6.1 but it is not working for kernel 2.6.9. I have done some
debugging and I notice if I comment the instructions after the second
"if statement" the segmentation fault problem is removed. But if I
write a simple printk after it a segmentation fault is invoked.  It is
very strange. I do not know what is going on. Does anyone can help me?


void resident_mem_size(struct mm_struct *mm, unsigned long start_address,
			unsigned long end_address, unsigned long *size) {
	pgd_t *my_pgd;
	pmd_t *my_pmd;
	pte_t *my_pte;
	unsigned long page;

	for (page = start_address; page < end_address; page += PAGE_SIZE) {
		my_pgd = pgd_offset(mm, page);
		if (pgd_none(*my_pgd) || pgd_bad(*my_pgd)) continue;
		my_pmd = pmd_offset(my_pgd, page);
		if (pmd_none(*my_pmd) || pmd_bad(*my_pmd)) continue;
		my_pte = pte_offset_map(my_pmd, page);
		if (pte_present(*my_pte)) {
			*size += PAGE_SIZE;
		}
	  }
}

Mauricio Lin.
