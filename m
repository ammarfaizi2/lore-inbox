Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267883AbUHESac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267883AbUHESac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUHESaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:30:00 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:53135 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267859AbUHESPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:15:51 -0400
Date: Thu, 5 Aug 2004 20:13:56 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, colpatch@us.ibm.com,
       wli@holomorphy.com, pj@sgi.com, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
In-Reply-To: <20040805104236.6b2750b6.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0408052007350.20635@scrub.home>
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com>
 <20040731232126.1901760b.pj@sgi.com> <Pine.LNX.4.58.0408010316590.4095@montezuma.fsmlabs.com>
 <20040801124053.GS2334@holomorphy.com> <20040801060529.4bc51b98.pj@sgi.com>
 <20040801131004.GT2334@holomorphy.com> <20040801063632.66c49e61.pj@sgi.com>
 <20040801134112.GU2334@holomorphy.com> <1091484032.4415.55.camel@arrakis>
 <871xiljzqo.fsf@devron.myhome.or.jp> <20040805104236.6b2750b6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 5 Aug 2004, Andrew Morton wrote:

> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> >
> >  >  #define next_node(n, src) __next_node((n), &(src), MAX_NUMNODES)
> >  >  static inline int __next_node(int n, const nodemask_t *srcp, int nbits)
> >  >  {
> >  > -	return find_next_bit(srcp->bits, nbits, n+1);
> >  > +	return min_t(int, nbits, find_next_bit(srcp->bits, nbits, n+1));
> >  >  }
> > 
> >  Shouldn't these use simply min()?  I worry min_t() may hide the real bug...
> 
> The problem is that on some architectures, find_next_bit() returns an
> unsigned long, on others it returns an int and I think some even return a
> long.

Personally I prefer to cast only one argument:

+	return min(nbits, (int)find_next_bit(srcp->bits, nbits, n+1));

If the nbits type should change, it's not as easy to miss.

bye, Roman
