Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264628AbUF1Bon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264628AbUF1Bon (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 21:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbUF1Bon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 21:44:43 -0400
Received: from ozlabs.org ([203.10.76.45]:44423 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264628AbUF1Bok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 21:44:40 -0400
Date: Mon, 28 Jun 2004 11:05:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH] kill mm_struct.used_hugetlb
Message-ID: <20040628010524.GA5006@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>
References: <40DD7814.779DEF17@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40DD7814.779DEF17@tv-sign.ru>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, Jun 26, 2004 at 05:20:20PM +0400, Oleg Nesterov wrote:
> Hello.
> 
> mm_struct.used_hugetlb used to eliminate costly find_vma()
> from follow_page(). Now it is used only in ia64 version of
> follow_huge_addr(). I know nothing about ia64, but this
> REGION_NUMBER() looks simple enough to kill used_hugetlb.
> 
> There is debug version (commented out) of follow_huge_addr()
> in i386 which looks at used_hugetlb, but it can work without
> this check.
> 
> Am i missed somethimg?

Sounds like an excellent idea to me.  The find_vma()s were already
bogus - no-one used the vma returned by hugepage_vma(), except to
check if it was NULL or not.  On all archs, whether the address is
hugepage or not can be determined from the address, either by walking
the pagetables or just by checking the address's range.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
