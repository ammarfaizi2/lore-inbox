Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVCIWG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVCIWG3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVCIWGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:06:03 -0500
Received: from rev.193.226.232.162.euroweb.hu ([193.226.232.162]:22935 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261927AbVCIWCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:02:24 -0500
To: strombrg@dcs.nac.uci.edu
CC: linux-kernel@vger.kernel.org
In-reply-to: <pan.2005.03.09.18.53.47.428199@dcs.nac.uci.edu> (message from
	Dan Stromberg on Wed, 09 Mar 2005 10:53:48 -0800)
Subject: Re: huge filesystems
References: <pan.2005.03.09.18.53.47.428199@dcs.nac.uci.edu>
Message-Id: <E1D99Fe-0004s3-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 09 Mar 2005 23:01:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The group I work in has been experimenting with GFS and Lustre, and I did
> some NBD/ENBD experimentation on my own, described at
> http://dcs.nac.uci.edu/~strombrg/nbd.html
> 
> My question is, what is the current status of huge filesystems - IE,
> filesystems that exceed 2 terabytes, and hopefully also exceeding 16
> terabytes?
> 
> Am I correct in assuming that the usual linux buffer cache only goes to 16
> terabytes?

The page cache limit is PAGE_CACHE_BITS + BITS_PER_LONG - 1.  On i386
that's 12 + 32 - 1 = 43 bits or 8Tbytes.  On 64 bit architectures the
size of off_t is the only limit.

> Does the FUSE API (or similar) happen to allow surpassing either the 2T or
> 16T limits?

The API certainly doesn't have any limits.  The page cache limit holds
for FUSE too, though with the direct-io mount option the page cache is
not used, so the limit could be removed as well.  I'll fix that.

Thanks,
Miklos
