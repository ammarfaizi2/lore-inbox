Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbUBXWeK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbUBXWdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:33:35 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:40348 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262504AbUBXWbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:31:42 -0500
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
From: Christophe Saout <christophe@saout.de>
To: James Morris <jmorris@redhat.com>
Cc: Matt Mackall <mpm@selenic.com>, Jean-Luc Cooke <jlcooke@certainkey.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Morris <jmorris@intercode.com.au>
In-Reply-To: <Xine.LNX.4.44.0402241726450.26251-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0402241726450.26251-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1077661909.26811.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 24 Feb 2004 23:31:49 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, den 24.02.2004 schrieb James Morris um 23:26:

> > BTW: I think there's a bug in the ipv6 code, it uses spin_lock to
> > protect itself, this will cause a sleep-inside-spinlock warning. (found
> > while grepping through the source for other cryptoapi users)
> 
> Where is the bug?

net/ipv6/addrconf.c: __ipv6_regen_rndid

>        spin_lock(&md5_tfm_lock);
>        if (unlikely(md5_tfm == NULL)) {
>                spin_unlock(&md5_tfm_lock);
>                return -1;
>        }
>        crypto_digest_init(md5_tfm);
>        crypto_digest_update(md5_tfm, sg, 2);
>        crypto_digest_final(md5_tfm, idev->work_digest);
>        spin_unlock(&md5_tfm_lock);


