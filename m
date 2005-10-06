Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVJFRmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVJFRmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVJFRmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:42:18 -0400
Received: from pat.uio.no ([129.240.130.16]:27038 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751261AbVJFRmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:42:17 -0400
Subject: Re: [RFC] atomic create+open
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu>
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
	 <1128619526.16534.8.camel@lade.trondhjem.org>
	 <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 13:42:07 -0400
Message-Id: <1128620528.16534.26.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.928, required 12,
	autolearn=disabled, AWL 1.07, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 06.10.2005 Klokka 19:30 (+0200) skreiv Miklos Szeredi:

> Say you have NFS mount on /mnt and a bind mount over the regular file
> /mnt/foo.  You do open("/mnt/foo", O_RDWR | O_CREAT, 0644).  How do
> you solve the atomic open case.

> If you open in ->lookup("foo") you will be opening the wrong file,
> unless you want to follow mounts inside ->lookup.

Firstly, if that is the case, then you will have dentries for both the
covered and the covering copies of /mnt/foo. A simple test of
have_submounts() on the dentry will suffice to tell the filesystem.
whether or not it should open the file.

Secondly, Linux doesn't actually allow bind mounts on top of regular
files.

Either one of these two points suffices to resolve the "race".

Cheers,
  Trond

