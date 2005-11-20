Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVKTUnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVKTUnr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 15:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVKTUnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 15:43:46 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:34827 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932076AbVKTUnq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 15:43:46 -0500
Date: Mon, 21 Nov 2005 07:43:25 +1100
To: Paul Clements <paul.clements@steeleye.com>
Cc: akpm@osdl.org, djani22@dynamicweb.hu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NBD] Use per-device semaphore instead of BKL
Message-ID: <20051120204325.GB11043@gondor.apana.org.au>
References: <200511190345.jAJ3jFC3016406@shell0.pdx.osdl.net> <437F4C85.3070108@steeleye.com> <20051119223419.GA1751@gondor.apana.org.au> <20051120015807.GA3593@gondor.apana.org.au> <4380B015.9060005@steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4380B015.9060005@steeleye.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2005 at 12:19:17PM -0500, Paul Clements wrote:
> 
> The dropping of the lock in nbd_do_it is actually critical to the way 
> nbd functions. nbd_do_it runs for the lifetime of the nbd device, so if 
> nbd_do_it were holding some lock (BKL or otherwise), we'd have big problems.

Why would you want to issue an ioctl from a different process while
nbd-client is still running?

Allow ioctl's while nbd_do_it is in progress is a *serious* bug.  For a
start, if someone else clears the socket then nbd_read_stat will crash.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
