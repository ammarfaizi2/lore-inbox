Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVCNUHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVCNUHM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 15:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVCNUHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 15:07:11 -0500
Received: from roath.org ([212.227.22.120]:6278 "EHLO mail.roath.org")
	by vger.kernel.org with ESMTP id S261807AbVCNUG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 15:06:29 -0500
Date: Mon, 14 Mar 2005 21:06:26 +0100
From: Stefan Roas <sroas@roath.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Fix compiler warning in drivers/scsi/dpt_i2o.c
Message-ID: <20050314200626.GD1733@roath.org>
References: <20050313224351.GA1731@roath.org> <20050314182444.GA6903@home.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <20050314182444.GA6903@home.fluff.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon Mar 14, 2005 at 18:24:44, Ben Dooks wrote:

> This patch looks suspiciously like it is sweeping the problem
> `under the carpet`. Does bus_to_virt() return an `void __iomem *`?
> 
> reply should really be an `void __iomem *` 

bus_to_virt returns void *.

adpt_isr casts the return value to ulong though and adpt_i2o_to_scsi
takes an ulong as its first argument and passes it to readl without a
cast then.

But I agree, the patch just silences the compiler warning. Maybe it
would be a better solution to change the types of reply and msg in
adpt_isr as well as the first argument to adpt_i2o_to_scsi to void
__iomem *.


Best Regards,

- -- 
Stefan Roas
sroas@roath.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCNe7CwvfNuQ9pAq8RAmDBAJ0XyRMogsfgX3L6+SzIzp6VPYuynQCgjpZ0
94sI0Fr7V8anGTsQQw+COcM=
=+qfk
-----END PGP SIGNATURE-----
