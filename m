Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264042AbTE3XBm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 19:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264044AbTE3XBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 19:01:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19727 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264042AbTE3XBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 19:01:40 -0400
Date: Sat, 31 May 2003 00:14:58 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jun Sun <jsun@mvista.com>
Cc: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Properly implement flush_dcache_page in 2.4?  (Or is it possible?)
Message-ID: <20030531001458.H9419@flint.arm.linux.org.uk>
Mail-Followup-To: Jun Sun <jsun@mvista.com>, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>
References: <20030530103254.B1669@mvista.com> <20030530190929.E9419@flint.arm.linux.org.uk> <20030530160002.D1669@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030530160002.D1669@mvista.com>; from jsun@mvista.com on Fri, May 30, 2003 at 04:00:02PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 04:00:02PM -0700, Jun Sun wrote:
> Is this routine tested to be working?  At least passing a page
> index as a full virtual address to flush_cache_page() looks suspicious.

Well, given that it doesn't actually trip up any real life programs
(for me) its not that easy to say "yes, it works".  However, you are
correct, and the right flush_cache_page() call should be:

                flush_cache_page(mpnt, mpnt->vm_start + off << PAGE_SHIFT);

> In addition, I am not sure if the vma struct will show up in the
> "shared" list _if_ the page is only mapped in one user process and
> in kernel (for example, those pages you obtain through get_user_pages()
> call).

If a mapping is using MAP_SHARED, my understanding is that the pages should
appear on the i_mmap_shared list.

I don't see a reason to worry about privately mapped pages on the i_mmap
list since they are private, and therefore shouldn't be updated with
modifications to other mappings, which I'd have thought would include
writes to the file (although I'm not so sure atm.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

