Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751827AbWHNDTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbWHNDTM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 23:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbWHNDTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 23:19:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60379
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751809AbWHNDTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 23:19:11 -0400
Date: Sun, 13 Aug 2006 20:19:34 -0700 (PDT)
Message-Id: <20060813.201934.32734362.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: greg@kroah.com, nix@esperi.org.uk, linux-kernel@vger.kernel.org,
       neilb@suse.de, netdev@vger.kernel.org
Subject: Re: [2.6.17.8] NFS stall / BUG in UDP fragment processing / SKB
 trimming
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060813125910.GA18463@gondor.apana.org.au>
References: <87zme9fy94.fsf@hades.wkstn.nix>
	<20060813125910.GA18463@gondor.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sun, 13 Aug 2006 22:59:11 +1000

> On Sat, Aug 12, 2006 at 09:19:19PM +0000, Nix wrote:
> > 
> > The kernel log showed a heap of BUGs from somewhere inside the skb
> > management layer, somewhere in UDP fragment processing while
> > handling NFS requests. It starts like this:
> > 
> > Aug 12 21:31:08 hades warning: kernel: BUG: warning at include/linux/skbuff.h:975/__skb_trim()
> > Aug 12 21:31:08 hades warning: kernel: <c030ed39> ip_append_data+0x5b3/0x951  <c030fc18> ip_generic_getfrag+0x0/0x96
> 
> Oops, I missed this code path when I disallowed skb_trim from operating
> on a paged skb.  This patch should fix the problem.
> 
> Greg, we need this for 2.6.17 stable as well if Dave is OK with it.
> 
> [INET]: Use pskb_trim_unique when trimming paged unique skbs
 ...
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Signed-off-by: David S. Miller <davem@davemloft.net>

Looks good, Greg please push to -stable.  I'll push this into
2.6.18 under seperate cover.

