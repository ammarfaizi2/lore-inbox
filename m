Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbUBXWsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbUBXWsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:48:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59850 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262518AbUBXWpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:45:44 -0500
Date: Tue, 24 Feb 2004 17:45:49 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Christophe Saout <christophe@saout.de>
cc: Matt Mackall <mpm@selenic.com>, Jean-Luc Cooke <jlcooke@certainkey.com>,
       Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       =?iso-2022-jp?Q?YOSHIFUJI_Hideaki_=2F_=1B$B5HF#1QL=40=1B=28B?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
In-Reply-To: <1077661909.26811.1.camel@leto.cs.pocnet.net>
Message-ID: <Xine.LNX.4.44.0402241737230.26464-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Christophe Saout wrote:

> Am Di, den 24.02.2004 schrieb James Morris um 23:26:
> 
> > > BTW: I think there's a bug in the ipv6 code, it uses spin_lock to
> > > protect itself, this will cause a sleep-inside-spinlock warning. (found
> > > while grepping through the source for other cryptoapi users)
> > 
> > Where is the bug?
> 
> net/ipv6/addrconf.c: __ipv6_regen_rndid
> 
> >        spin_lock(&md5_tfm_lock);
> >        if (unlikely(md5_tfm == NULL)) {
> >                spin_unlock(&md5_tfm_lock);
> >                return -1;
> >        }
> >        crypto_digest_init(md5_tfm);
> >        crypto_digest_update(md5_tfm, sg, 2);
> >        crypto_digest_final(md5_tfm, idev->work_digest);
> >        spin_unlock(&md5_tfm_lock);

This looks like too much work to be done under a spinlock, and generally,
that's why the API does not support these kinds of functions from being
called under one.


- James
-- 
James Morris
<jmorris@redhat.com>



