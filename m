Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVBNSQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVBNSQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 13:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVBNSQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 13:16:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:41940 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261511AbVBNSQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 13:16:43 -0500
Date: Mon, 14 Feb 2005 10:16:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: davem@davemloft.net, jmorris@redhat.com, linux-kernel@vger.kernel.org,
       michal@logix.cz, adam@yggdrasil.com
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
 crypto_tfm
Message-Id: <20050214101615.6882c6ba.akpm@osdl.org>
In-Reply-To: <1108402135.23133.48.camel@ghanima>
References: <Xine.LNX.4.44.0502101247390.9159-100000@thoron.boston.redhat.com>
	<1108387234.8086.37.camel@ghanima>
	<20050214075655.6dec60cb.davem@davemloft.net>
	<1108400799.23133.34.camel@ghanima>
	<20050214090726.2d099d96.davem@davemloft.net>
	<1108402135.23133.48.camel@ghanima>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens <clemens@endorphin.org> wrote:
>
> First, one has to make kmap fallible.

I think it would be relatively simple and sane to modify the existing
kmap() implementations to add a new try_kmap() which is atomic and returns
failure if it would have needed to sleep.

That being said, kmap() is a sort of old and deprecated thing which scales
badly on SMP.  We've put considerable work into moving over to
kmap_atomic() and using nice tight short code regions where atomic
kmappings are held.

