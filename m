Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVDCPVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVDCPVJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 11:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVDCPVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 11:21:08 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:49416 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261791AbVDCPVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 11:21:04 -0400
Date: Sun, 3 Apr 2005 12:21:01 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@davemloft.net>,
       James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix boot hang on some architectures
Message-ID: <20050403152101.GC640@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@davemloft.net>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1112471164.5786.23.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112471164.5786.23.camel@mulgrave>
X-Url: http://advogato.org/person/acme
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Apr 02, 2005 at 01:46:03PM -0600, James Bottomley escreveu:
> Well, this is a brown paper bag for someone.  The new protocol

/me using such bag now :(

Thanks a lot for the fix.

David, Please apply.

> registration locking uses a rwlock to limit access to the protocol list.
> Unfortunately, the initialisation:
> 
> static rwlock_t proto_list_lock;
> 
> Only works to initialise the lock as unlocked on platforms whose unlock
> signal is all zeros.  On other platforms, they think it's already locked
> and hang forever.
> 
> Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
> 
> 
> ===== net/core/sock.c 1.67 vs edited =====
> --- 1.67/net/core/sock.c	2005-03-26 17:04:35 -06:00
> +++ edited/net/core/sock.c	2005-04-02 13:37:20 -06:00
> @@ -1352,7 +1352,7 @@
>  
>  EXPORT_SYMBOL(sk_common_release);
>  
> -static rwlock_t proto_list_lock;
> +static DEFINE_RWLOCK(proto_list_lock);
>  static LIST_HEAD(proto_list);
>  
>  int proto_register(struct proto *prot, int alloc_slab)
