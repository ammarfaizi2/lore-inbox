Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131348AbRC0OyX>; Tue, 27 Mar 2001 09:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131349AbRC0OyD>; Tue, 27 Mar 2001 09:54:03 -0500
Received: from ns2.servicenet.com.ar ([200.41.148.12]:49413 "EHLO
	servnet.servicenet.com.ar") by vger.kernel.org with ESMTP
	id <S131348AbRC0OyA>; Tue, 27 Mar 2001 09:54:00 -0500
Message-ID: <A0C675E9DC2CD411A5870040053AEBA028413C@MAINSERVER>
From: Sardañons@localhost, Eliel 
	<Eliel.Sardanons@philips.edu.ar>
To: linux-kernel@vger.kernel.org
Subject: linux/mm/memory.c [ void clear_page_tables(...); ] question...
Date: Tue, 27 Mar 2001 11:54:55 -0300
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.0.1461.28)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Function taked from: linux/mm/memory.c

void clear_page_tables(struct mm_struct *mm, unsigned long first, int nr) {
        pgd_t * page_dir = mm->pgd;

        if (page_dir && page_dir != swapper_pg_dir) {
                page_dir += first;
                do {
                        free_one_pgd(page_dir);
                        page_dir++;
                } while (--nr);

                /* keep the page table cache within bounds */
                check_pgt_cache();
        }
} 

Hello:
I'm trying to understand the code, and sorry if this is a stupid question.
Here in this function you check if mm->pgd is the swapper_pg_dir if it's you
don't clear it, but then you increment page_dir++ in the loop and you don't
check if 
page_dir != swapper_pg_dir  ...why? may be when you increment page_dir it
can't become swapper_pg_dir because swapper_pg_dir is always <= page_dir?..
or is something else?

Thanks in advance

Eliel Sardanons

