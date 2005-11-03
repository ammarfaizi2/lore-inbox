Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbVKCCN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbVKCCN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 21:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbVKCCN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 21:13:56 -0500
Received: from mail.ispwest.com ([216.52.245.18]:40200 "EHLO
	ispwest-email1.mdeinc.com") by vger.kernel.org with ESMTP
	id S1030280AbVKCCNz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 21:13:55 -0500
X-Modus-BlackList: 216.52.245.25=OK;kjak@ispwest.com=OK
X-Modus-Trusted: 216.52.245.25=YES
Message-ID: <310a17ad00f84c389e64ae26656ce1a1.kjak@ispwest.com>
X-EM-APIVersion: 2, 0, 1, 0
X-Priority: 3 (Normal)
Reply-To: "Kris Katterjohn" <kjak@users.sourceforge.net>
From: "Kris Katterjohn" <kjak@ispwest.com>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
CC: jschlst@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       davem@davemloft.net, acme@ghostprotocols.net, netdev@vger.kernel.org
Subject: Re: [PATCH] Merge __load_pointer() and load_pointer() in net/core/filter.c; kernel 2.6.14
Date: Wed, 2 Nov 2005 18:13:47 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wasn't actually changing it to add performance, but to make the code look
cleaner. The new load_pointer() is virtually the same as having the seperate
functions that are currently there, but the code, I think, is "better looking".
If you look at the current net/core/filter.c and then my patched version, the
steps are done in the exact same order and same way, but all in that one
function.

That may sound silly, but I just kept looking at it and asking myself, "Why?"

Of course, one way may still out-perform the other.


Thanks


----- Original Message -----
From: Herbert Xu [mailto:herbert@gondor.apana.org.au]
Sent: 11/2/2005 5:50:29 PM
To: kjak@users.sourceforge.net
Cc: jschlst@samba.org; torvalds@osdl.org; linux-kernel@vger.kernel.org; davem@davemloft.net; acme@ghostprotocols.net; netdev@vger.kernel.org
Subject: Re: [PATCH] Merge __load_pointer() and load_pointer() in net/core/filter.c; kernel 2.6.14

> Kris Katterjohn <kjak@ispwest.com> wrote:
> > Another patch for net/core/filter.c by me. I merged __load_pointer() into
> > load_pointer(). I don't see a point in having two seperate functions when
> > both functions are really small and load_pointer() calls __load_pointer().
> > Renamed the variable "k" to "offset" since that's what it is, and in
> > skb_header_pointer() it's "offset".
> > 
> > This patch is a diff from kernel 2.6.14
> 
> This code path is performance-critical so you should benchmark your
> changes.
> 
> In this particular case, __load_pointer is the unlikely case and
> therefore it wasn't inlined.
> 
> Cheers,
> -- 
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

