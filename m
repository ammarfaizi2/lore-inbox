Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTGBRyD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 13:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTGBRyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 13:54:03 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:43408 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264256AbTGBRxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 13:53:55 -0400
Date: Wed, 02 Jul 2003 10:52:42 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@redhat.com>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <528080000.1057168362@flay>
In-Reply-To: <20030702174700.GJ23578@dualathlon.random>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <Pine.LNX.4.53.0307021641560.11264@skynet> <20030702171159.GG23578@dualathlon.random> <461030000.1057165809@flay> <20030702174700.GJ23578@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, July 02, 2003 19:47:00 +0200 Andrea Arcangeli <andrea@suse.de> wrote:

> On Wed, Jul 02, 2003 at 10:10:09AM -0700, Martin J. Bligh wrote:
>> Maybe I'm just taking this out of context, and it's twisting my brain,
>> but as far as I know, the nonlinear vma's *are* backed by pte_chains.
>> That was the whole problem with objrmap having to do conversions, etc.
>> 
>> Am I just confused for some reason? I was pretty sure that was right ...
> 
> you're right:
> 
> int install_page(struct mm_struct *mm, struct vm_area_struct *vma,
> 		unsigned long addr, struct page *page, pgprot_t prot)
> [..]
> 	flush_icache_page(vma, page);
> 	set_pte(pte, mk_pte(page, prot));
> 	pte_chain = page_add_rmap(page, pte, pte_chain);
> 	pte_unmap(pte);
> [..]
> 
> (this make me understand better some of the arguments in the previous
> emails too ;)

OK, nice to know I haven't totally lost it ;-)
 
> So ether we declare 32bit archs obsolete in production with 2.6, or we
> drop rmap behind remap_file_pages.

Indeed - if we could memlock it, it'd be OK to drop that stuff. Would
make everything a lot simpler.

M.

