Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261373AbTCaC0D>; Sun, 30 Mar 2003 21:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261374AbTCaC0D>; Sun, 30 Mar 2003 21:26:03 -0500
Received: from [12.47.58.205] ([12.47.58.205]:5215 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S261373AbTCaC0C>; Sun, 30 Mar 2003 21:26:02 -0500
Date: Sun, 30 Mar 2003 18:37:19 -0800
From: Andrew Morton <akpm@digeo.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Wrong comment due to pte_file()
Message-Id: <20030330183719.325908c1.akpm@digeo.com>
In-Reply-To: <20030330212201.A4155@devserv.devel.redhat.com>
References: <20030330212201.A4155@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Mar 2003 02:37:16.0320 (UTC) FILETIME=[716B2A00:01C2F72E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> wrote:
>
> How about abolishing all comments?

Or all code.

> --- linux-2.5.66/include/asm-i386/pgtable.h	2003-03-24 14:01:14.000000000 -0800
> +++ linux-2.5.66-sparc/include/asm-i386/pgtable.h	2003-03-30 16:35:04.000000000 -0800

Thanks.  There's another bogus comment doing the rounds as well:

#define _PAGE_FILE      0x040   /* pagecache or swap */

This is exactly wrong - this bit is used to distinguish pagecache from swap. 
See handle_pte_fault():


	if (pte_file(entry))
		return do_file_page(mm, vma, address, write_access, pte, pmd);
	return do_swap_page(mm, vma, address, pte, pmd, entry, write_access);


Some architectures got sneaky:

#define _PAGE_FILE  0x80000 /* pagecache or swap? */

ah-hah!  That question mark *totally* changes the meaning and reveals all.

Pity those who follow after us.  I shall fix it up.

