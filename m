Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267578AbTACQfM>; Fri, 3 Jan 2003 11:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267581AbTACQfL>; Fri, 3 Jan 2003 11:35:11 -0500
Received: from ermelo.utad.pt ([193.136.40.6]:64719 "EHLO marao.utad.pt")
	by vger.kernel.org with ESMTP id <S267578AbTACQfK>;
	Fri, 3 Jan 2003 11:35:10 -0500
Message-ID: <3E15BB58.9020900@alvie.com>
Date: Fri, 03 Jan 2003 16:33:28 +0000
From: Alvaro Lopes <alvieboy@alvie.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
CC: linux-kernel@vger.kernel.org
Subject: Re: [STUPID] Best looking code to transfer to a t-shirt
References: <Pine.LNX.4.44.0301031419560.11311-100000@dns.toxicfilms.tv>
In-Reply-To: <Pine.LNX.4.44.0301031419560.11311-100000@dns.toxicfilms.tv>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak wrote:

>Hi,
>
>I am in a t-shirt transfering frenzy and was wondering which part of the
>kernel code it would be best to have on my t-shirt.
>I was looking at my favourite: netfilter code, but it is to clean, short
>and simple functions, no tons of pointers, no mallocs, no hex numbers, too
>many defines used. I was looking for something terribly complicated and
>looking awesome to the eye.
>  
>
arch/i386/mm/fault.c

        /*
         * Synchronize this task's top level page-table
         * with the 'reference' page table.
         *
         * Do _not_ use "tsk" here. We might be inside
         * an interrupt in the middle of a task switch..
         */
        int offset = __pgd_offset(address);
        pgd_t *pgd, *pgd_k;
        pmd_t *pmd, *pmd_k;
        pte_t *pte_k;

        asm("movl %%cr3,%0":"=r" (pgd));
        pgd = offset + (pgd_t *)__va(pgd);
        pgd_k = init_mm.pgd + offset;

        if (!pgd_present(*pgd_k))
            goto no_context;
        set_pgd(pgd, *pgd_k);
       
        pmd = pmd_offset(pgd, address);
        pmd_k = pmd_offset(pgd_k, address);
        if (!pmd_present(*pmd_k))
            goto no_context;
        set_pmd(pmd, *pmd_k);

        pte_k = pte_offset_kernel(pmd_k, address);
        if (!pte_present(*pte_k))
            goto no_context;
        return;
    }

-- 

Álvaro Lopes 
---------------------
A .sig is just a .sig


