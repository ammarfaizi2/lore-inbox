Return-Path: <linux-kernel-owner+w=401wt.eu-S1945989AbWLVInj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945989AbWLVInj (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 03:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945987AbWLVInj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 03:43:39 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2095 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945989AbWLVIni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 03:43:38 -0500
Date: Fri, 22 Dec 2006 08:43:18 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Randolph Chung <randolph@tausq.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
Message-ID: <20061222084318.GA5132@flint.arm.linux.org.uk>
Mail-Followup-To: Randolph Chung <randolph@tausq.org>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
References: <20061221152621.GB3958@flint.arm.linux.org.uk> <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu> <20061221171739.GE3958@flint.arm.linux.org.uk> <E1GxS8x-0000q5-00@dorka.pomaz.szeredi.hu> <20061221181156.GG3958@flint.arm.linux.org.uk> <E1GxSgF-0000uV-00@dorka.pomaz.szeredi.hu> <20061221185512.GH3958@flint.arm.linux.org.uk> <E1GxTED-0000yy-00@dorka.pomaz.szeredi.hu> <458B1E06.1030209@tausq.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458B1E06.1030209@tausq.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 07:51:34AM +0800, Randolph Chung wrote:
> >I understand now.  I'm not sure how the PARISC implementation can be
> >correct in this light.
> 
> According to cachetlb.txt:
> 
>   void flush_anon_page(struct page *page, unsigned long vmaddr)
>         When the kernel needs to access the contents of an anonymous
>         page, it calls this function (currently only
>         get_user_pages()).  Note: flush_dcache_page() deliberately
>         doesn't work for an anonymous page.  The default
>         implementation is a nop (and should remain so for all coherent
>         architectures).  For incoherent architectures, it should flush
>         the cache of the page at vmaddr in the current user process.
>                                                ^^^^^^^^^^^^^^^^^^^^
> 
> Is the documentation wrong?

Yes.  As I've already explained there is no guarantee that
get_user_pages() is only called to obtain pages for the current
process, and flush_anon_pages() is called irrespective of which
user process is being 'got'.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
