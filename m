Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267834AbUHERob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267834AbUHERob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267832AbUHERob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:44:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:47555 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267834AbUHERoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:44:19 -0400
Date: Thu, 5 Aug 2004 10:42:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, pj@sgi.com, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
Message-Id: <20040805104236.6b2750b6.akpm@osdl.org>
In-Reply-To: <871xiljzqo.fsf@devron.myhome.or.jp>
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com>
	<20040731232126.1901760b.pj@sgi.com>
	<Pine.LNX.4.58.0408010316590.4095@montezuma.fsmlabs.com>
	<20040801124053.GS2334@holomorphy.com>
	<20040801060529.4bc51b98.pj@sgi.com>
	<20040801131004.GT2334@holomorphy.com>
	<20040801063632.66c49e61.pj@sgi.com>
	<20040801134112.GU2334@holomorphy.com>
	<1091484032.4415.55.camel@arrakis>
	<871xiljzqo.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
>  >  #define next_node(n, src) __next_node((n), &(src), MAX_NUMNODES)
>  >  static inline int __next_node(int n, const nodemask_t *srcp, int nbits)
>  >  {
>  > -	return find_next_bit(srcp->bits, nbits, n+1);
>  > +	return min_t(int, nbits, find_next_bit(srcp->bits, nbits, n+1));
>  >  }
> 
>  Shouldn't these use simply min()?  I worry min_t() may hide the real bug...

The problem is that on some architectures, find_next_bit() returns an
unsigned long, on others it returns an int and I think some even return a
long.
