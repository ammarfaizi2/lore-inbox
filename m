Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267792AbUHEQxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267792AbUHEQxg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267810AbUHEQwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:52:32 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:56839 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S267801AbUHEQv2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:51:28 -0400
To: colpatch@us.ibm.com
Cc: William Lee Irwin III <wli@holomorphy.com>, Paul Jackson <pj@sgi.com>,
       zwane@linuxpower.ca, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com>
	<20040731232126.1901760b.pj@sgi.com>
	<Pine.LNX.4.58.0408010316590.4095@montezuma.fsmlabs.com>
	<20040801124053.GS2334@holomorphy.com>
	<20040801060529.4bc51b98.pj@sgi.com>
	<20040801131004.GT2334@holomorphy.com>
	<20040801063632.66c49e61.pj@sgi.com>
	<20040801134112.GU2334@holomorphy.com>
	<1091484032.4415.55.camel@arrakis>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 06 Aug 2004 01:50:23 +0900
In-Reply-To: <1091484032.4415.55.camel@arrakis>
Message-ID: <871xiljzqo.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson <colpatch@us.ibm.com> writes:

> >  #define first_cpu(src) __first_cpu(&(src), NR_CPUS)
> >  static inline int __first_cpu(const cpumask_t *srcp, int nbits)
> >  {
> > -	return find_first_bit(srcp->bits, nbits);
> > +	return min_t(int, nbits, find_first_bit(srcp->bits, nbits));
> >  }
> >  
> >  #define next_cpu(n, src) __next_cpu((n), &(src), NR_CPUS)
> >  static inline int __next_cpu(int n, const cpumask_t *srcp, int nbits)
> >  {
> > -	return find_next_bit(srcp->bits, nbits, n+1);
> > +	return min_t(int, nbits, find_next_bit(srcp->bits, nbits, n+1));
> >  }

>  #define first_node(src) __first_node(&(src), MAX_NUMNODES)
>  static inline int __first_node(const nodemask_t *srcp, int nbits)
>  {
> -	return find_first_bit(srcp->bits, nbits);
> +	return min_t(int, nbits, find_first_bit(srcp->bits, nbits));
>  }
>  
>  #define next_node(n, src) __next_node((n), &(src), MAX_NUMNODES)
>  static inline int __next_node(int n, const nodemask_t *srcp, int nbits)
>  {
> -	return find_next_bit(srcp->bits, nbits, n+1);
> +	return min_t(int, nbits, find_next_bit(srcp->bits, nbits, n+1));
>  }

Shouldn't these use simply min()?  I worry min_t() may hide the real bug...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
