Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbVJDWbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbVJDWbY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 18:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbVJDWbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 18:31:24 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:11955 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S965021AbVJDWbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 18:31:23 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH] release_resource() check for NULL resource
To: Pekka Enberg <penberg@cs.helsinki.fi>, Ben Dooks <ben-linux@fluff.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 05 Oct 2005 00:31:07 +0200
References: <4TfvY-8ix-27@gated-at.bofh.it> <4Tg8u-Bn-15@gated-at.bofh.it> <4Tv7u-5Hd-15@gated-at.bofh.it> <4TvB0-6wD-3@gated-at.bofh.it> <4TvB7-6wD-5@gated-at.bofh.it> <4TxWv-1xD-37@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EMvJT-0001Jd-5v@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:

> static int driver_init(void)
> {
>      dev->resource1 = request_region(...);
>      if (!dev->resource1)
>              goto failed;

> failed:
>      driver_release(dev);

> static void driver_release(struct device * dev)
> {
>      release_resource(dev->resource1);
>      release_resource(dev->resource2);

If the dev struct* isn't properly initialized, it will try to free a random
resource.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
