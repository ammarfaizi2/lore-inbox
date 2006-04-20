Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWDTMPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWDTMPu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 08:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWDTMPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 08:15:50 -0400
Received: from pat.uio.no ([129.240.10.6]:34015 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750773AbWDTMPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 08:15:49 -0400
Subject: Re: NFS client: utime() doesn't work always
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Timo Sirainen <tss@iki.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1145534473.6851.63.camel@localhost.localdomain>
References: <1145534473.6851.63.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 08:15:36 -0400
Message-Id: <1145535336.8169.23.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.106, required 12,
	autolearn=disabled, AWL 1.71, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 15:01 +0300, Timo Sirainen wrote:
> Attached two straces where in first one stat() right after utime() gives
> wrong mtime in reply. The second strace has fstat() call added which
> makes it work properly for some reason (most of the time, but not
> always).
> 
> I tried creating a small test program which did the last steps in the
> straces, but I couldn't reproduce the problem with it. So I guess some
> other syscall before those causes it to get confused.
> 
> The NFS server's clock seems to be about 4 seconds in different time
> from the client. I guess that's part of the reason why it's wrong. Linux
> kernel figures that because utime() doesn't actually change the mtime it
> doesn't bother updating it? If this is the case, I think it should be
> changed because the clocks can't be perfectly sychronized, so there's
> always some possibility for it to break.
> 
> Kernel is from Debian package linux-image-2.6.16-1-686-smp version
> 2.6.16-7. NFS server is some Netapp, mounted with options
> rw,noatime,nfsvers=3,proto=udp,rsize=32768,wsize=32768,actimeo=30. Same
> with actimeo=0. 2.4.20 used to work fine.

...and 2.6.17-rcX should work fine. See the following patch which was
merged into 2.6.17-rc1:

http://client.linux-nfs.org/Linux-2.6.x/2.6.16/linux-2.6.16-007-fix_setattr_clobber.dif

Cheers,
  Trond

