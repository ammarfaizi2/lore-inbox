Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVBJBUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVBJBUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 20:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVBJBUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 20:20:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:23764 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262002AbVBJBUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 20:20:03 -0500
Date: Wed, 9 Feb 2005 17:19:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org, michal@logix.cz,
       davem@davemloft.net, adam@yggdrasil.com
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
 crypto_tfm
Message-Id: <20050209171943.05e9816e.akpm@osdl.org>
In-Reply-To: <1107997358.7645.24.camel@ghanima>
References: <Xine.LNX.4.44.0502091859540.6222-100000@thoron.boston.redhat.com>
	<1107997358.7645.24.camel@ghanima>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens <clemens@endorphin.org> wrote:
>
> It must be
>  possible to process more than 2 mappings in softirq context.

Adding a few more fixmap slots wouldn't hurt anyone.  But if you want an
arbitrarily large number of them then no, we cannot do that.

Taking more than one sleeping kmap at a time within the same process is
deadlocky, btw.  You can end up with N such tasks all holding one kmap and
waiting for someone else to release one.

Possibly one could arrange for the pages to not be in highmem at all.
