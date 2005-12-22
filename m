Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbVLVXXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbVLVXXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbVLVXXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:23:08 -0500
Received: from pat.uio.no ([129.240.130.16]:21967 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030369AbVLVXXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:23:07 -0500
Subject: Re: nfs insecure_locks / Tru64 behaviour
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ron Peterson <rpeterso@MtHolyoke.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051222133623.GE7814@mtholyoke.edu>
References: <20051222133623.GE7814@mtholyoke.edu>
Content-Type: text/plain
Date: Thu, 22 Dec 2005 18:21:53 -0500
Message-Id: <1135293713.3685.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.671, required 12,
	autolearn=disabled, AWL 1.33, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 08:36 -0500, Ron Peterson wrote:
> If I mount a linux export on Tru64, it seems the execute bit for 'other'
> needs to be set on a directory in order edit files within it using vi.
> 'Nobody' and 'nogroup' also appear to be special.

man 5 exports

read all about the "no_root_squash" option

As for your problem accessing files in the directory

drwxr-x---  2 root     system  4096 Dec 22 08:22 d/

as an unprivileged user on group 'kmw', the solution is obvious:

'chgrp kmw d'

or

chmod a+x d

Cheers,
  Trond

> I'm running 2.6.14.3 on Debian Sarge.
> 
> For example.
> 
> On linux, in directory /db/test:
> 
> 1185# ll
> total 16
> drwxr-x--x  2 root     kmw     4096 Dec 21 22:39 a/
> drwxr-x---  2 nobody   kmw     4096 Dec 21 22:39 b/
> drwxr-x---  2 rpeterso nogroup 4096 Dec 21 22:46 c/
> drwxr-x---  2 root     system  4096 Dec 22 08:22 d/
> 
> where /etc/exports looks like
> 
> /db/test  \
>               depot.p(rw,sync) \
>               polar.p(rw,sync,insecure_locks)
> 
> I mount this on Tru64 like:
> 
> mount -o tcp yogi.p:/db/test dbtest
> 
> Each directory a,b,c,d has a small text file named 'test':
> 
> -rw-rw-r--  1 root kmw 5 Dec 21 22:39 test
> 
> As a user in group kmw I can edit this file in directory a, b, and c.  I
> can't edit the file in directory d.
> 
> I understand that Tru64 doesn't send matching credentials with nfs lock
> requests.  The 'insecure_locks' option seems to help work around
> permission problems on the files themselves, but doesn't seem to work
> around the permissions of the owning directory.
> 
> It's probably fair to point fingers at Tru64, but it seems unlikely
> there will be any changes to nfs on that side...
> 
> I'm not subscribed the lkml, so cc's are appreciated.
> 
> Best.
> 

