Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268130AbUIAVPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268130AbUIAVPZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267519AbUIAVL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:11:26 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:49712 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267992AbUIAVC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:02:56 -0400
To: Chris Wright <chrisw@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
X-Message-Flag: Warning: May contain useful information
References: <20040901072245.GF13749@mellanox.co.il>
	<20040901073218.GQ16297@parcelfarce.linux.theplanet.co.uk>
	<52zn4a0ysg.fsf@topspin.com> <20040901110225.D1973@build.pdx.osdl.net>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 01 Sep 2004 13:54:33 -0700
In-Reply-To: <20040901110225.D1973@build.pdx.osdl.net> (Chris Wright's
 message of "Wed, 1 Sep 2004 11:02:25 -0700")
Message-ID: <52llftzp4m.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Sep 2004 20:54:33.0376 (UTC) FILETIME=[E22AAA00:01C49065]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Chris> You forgot a driver specific filesystem which exposes
    Chris> requests in a file per request type style.  Also, there's a
    Chris> simple_transaction type of file which can allow you
    Chris> send/recv data and should eliminate the need for tagging.
    Chris> Example, look at nfsd fs (fs/nfsd/nfsctl.c).

Thanks for the pointer -- I had a look at this stuff.  It seems that
using the simple_transaction stuff is fairly heavyweight -- if I
understand correctly, every operation requires userspace to do
open()-write()-read()-close(), and also uses a page of lowmem.  I'm
not sure if this is the best fit for our requirements with InfiniBand
drivers: although the user->kernel calls are not in the data path,
there can still be quite a few of them.

On the other hand, ioctl() holds the BKL through the whole operation
so that's suboptimal as well.

Thanks,
  Roland

