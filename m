Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWEXQWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWEXQWA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 12:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWEXQWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 12:22:00 -0400
Received: from pat.uio.no ([129.240.10.4]:56489 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932368AbWEXQV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 12:21:59 -0400
Subject: Re: Linux 2.6 NFS client read-ahead
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: German San Agustin <chamocarrot@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2bc0baf20605240453l89e5cd7w949377ead93e8b66@mail.gmail.com>
References: <2bc0baf20605240446h197b3d2fxc797404aa0e733ba@mail.gmail.com>
	 <2bc0baf20605240453l89e5cd7w949377ead93e8b66@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 24 May 2006 12:21:45 -0400
Message-Id: <1148487705.5872.34.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.826, required 12,
	autolearn=disabled, AWL 1.17, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 13:53 +0200, German San Agustin wrote:
> We have several linux 2.6.9 accesing to a netapp filer via nfs to
> update several thousands of files. The application only need to read a
> few blocks of the files when updating so we found out that disabling
> the read-ahead on the server improve greatly the performance by
> maintaining a clean cache and decreasing the number of access to disk.
> We have been trying to disable the read-ahead in the client as well to
> reduce the access to the server even further; but we couldn't find
>  where to do this in the 2.6 kernel family. Is it possible?, or it is
> simply that on 2.6 kernels it is not possible to tune the nfs client.

It is not possible, and in this case, it really shouldn't make much
difference to you either as the readahead code is adaptive: it should
automatically detect that you are doing short reads.

If you want to check that it is working, I suggest using tcpdump to
monitor the NFS traffic to that file, then comparing with a "strace"
dump.

Cheers,
  Trond

