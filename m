Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVJLNVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVJLNVh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 09:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbVJLNVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 09:21:36 -0400
Received: from pat.uio.no ([129.240.130.16]:55281 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751465AbVJLNVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 09:21:35 -0400
Subject: Re: [RFC] atomic create+open
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1EPeM4-0000Xz-00@dorka.pomaz.szeredi.hu>
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
	 <1128619526.16534.8.camel@lade.trondhjem.org>
	 <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu>
	 <1128620528.16534.26.camel@lade.trondhjem.org>
	 <E1ENZu1-0003SP-00@dorka.pomaz.szeredi.hu>
	 <1128623899.31797.14.camel@lade.trondhjem.org>
	 <E1ENani-0003c4-00@dorka.pomaz.szeredi.hu>
	 <1128626258.31797.34.camel@lade.trondhjem.org>
	 <E1ENcAr-0003jz-00@dorka.pomaz.szeredi.hu>
	 <1128633138.31797.52.camel@lade.trondhjem.org>
	 <E1ENlI2-0004Gt-00@dorka.pomaz.szeredi.hu>
	 <1128692289.8519.75.camel@lade.trondhjem.org>
	 <E1ENslH-00057W-00@dorka.pomaz.szeredi.hu>
	 <1128698035.8583.36.camel@lade.trondhjem.org>
	 <E1ENu8h-0005Kd-00@dorka.pomaz.szeredi.hu>
	 <1128702227.8583.69.camel@lade.trondhjem.org>
	 <E1ENvzx-0005VT-00@dorka.pomaz.szeredi.hu>
	 <1129061494.11164.38.camel@lade.trondhjem.org>
	 <E1EPeM4-0000Xz-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 09:20:57 -0400
Message-Id: <1129123257.8561.27.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.721, required 12,
	autolearn=disabled, AWL 2.09, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 12.10.2005 Klokka 13:01 (+0200) skreiv Miklos Szeredi:

> However I don't really like that the filesystem is reentered from
> lookup_instantiate_filp() via __dentry_open() and ->open().  Is this
> necessary?

If filesystems need to be able to change the value of f_mapping, then
yes, however if none of the potential users of lookup_instantiate_filp()
care about doing so, then we can get rid of it.
I don't care either way since we will not be supporting non-intent based
opens for NFSv4.

> I see you've fixed the O_TRUNC problem.  The accmode==3 case is still
> slightly broken, since now the file is being opened in read-write mode
> instead of no-read-no-write mode.  This probably won't break anything
> too badly though.

It is non-portable and it was never supported on NFSv4 anyway. If
someone cares, they can fix it, but I don't see much need.

> Equivalent and simpler:
> 
>      flags = nd->intent.open.flags - 1;
> 
> Note, that the access bits of intent.open.flags will never both be
> zero, so this is safe.

Agreed.

Cheers,
  Trond

