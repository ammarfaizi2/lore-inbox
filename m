Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUBKXxv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 18:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265765AbUBKXxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 18:53:51 -0500
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:62569 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S265691AbUBKXxt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 18:53:49 -0500
Date: Thu, 12 Feb 2004 00:53:45 +0100
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: 2.6.3-rc1-mm1
Message-Id: <20040212005345.1805b1d3@philou.gramoulle.local>
In-Reply-To: <20040209155823.6f884f23.akpm@osdl.org>
References: <20040209014035.251b26d1.akpm@osdl.org>
	<20040209151818.32965df6@philou.gramoulle.local>
	<20040209155823.6f884f23.akpm@osdl.org>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Andrew and Bruce,

Yes, with this patch applied, i can now start the NFSD kernel server again.

Much Thanks,

Bye,

Philippe

On Mon, 9 Feb 2004 15:58:23 -0800
Andrew Morton <akpm@osdl.org> wrote:

  | Philippe Gramoullé  <philippe.gramoulle@mmania.com> wrote:
  | >
  | > Starting with 2.6.3-rc1-mm1, nfsd isn't working any more. Exportfs just hangs.
  | 
  | Yes, sorry.  The nfsd patches had a painful birth.  This chunk got lost.
  | 
  | --- 25/net/sunrpc/svcauth.c~nfsd-02-sunrpc-cache-init-fixes	Mon Feb  9 14:04:03 2004
  | +++ 25-akpm/net/sunrpc/svcauth.c	Mon Feb  9 14:06:26 2004
  | @@ -150,7 +150,13 @@ DefineCacheLookup(struct auth_domain,
  |  		  &auth_domain_cache,
  |  		  auth_domain_hash(item),
  |  		  auth_domain_match(tmp, item),
  | -		  kfree(new); if(!set) return NULL;
  | +		  kfree(new); if(!set) {
  | +			if (new)
  | +				write_unlock(&auth_domain_cache.hash_lock);
  | +			else
  | +				read_unlock(&auth_domain_cache.hash_lock);
  | +			return NULL;
  | +		  }
  |  		  new=item; atomic_inc(&new->h.refcnt),
  |  		  /* no update */,
  |  		  0 /* no inplace updates */
  | 
  | _
  | 
