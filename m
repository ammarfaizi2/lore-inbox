Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264957AbUFRXXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbUFRXXB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265682AbUFRXTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:19:07 -0400
Received: from cantor.suse.de ([195.135.220.2]:31434 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265785AbUFRXQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:16:19 -0400
Subject: Re: [PATCH RFC] __bd_forget should wait for inodes using the
	mapping
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20040618142710.5d467d1b.akpm@osdl.org>
References: <1087523668.8002.103.camel@watt.suse.com>
	 <20040618021043.GV12308@parcelfarce.linux.theplanet.co.uk>
	 <1087563810.8002.116.camel@watt.suse.com>
	 <20040618142207.GW12308@parcelfarce.linux.theplanet.co.uk>
	 <1087570031.8002.153.camel@watt.suse.com>
	 <20040618151558.GX12308@parcelfarce.linux.theplanet.co.uk>
	 <1087573303.8002.172.camel@watt.suse.com>
	 <20040618154330.GY12308@parcelfarce.linux.theplanet.co.uk>
	 <1087574752.8002.194.camel@watt.suse.com>
	 <20040618132628.45e1d364.akpm@osdl.org>
	 <1087591484.1512.14.camel@watt.suse.com>
	 <20040618142710.5d467d1b.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1087600516.1512.26.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 19:15:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 17:27, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:
> >
> > [ skip writing block-special inodes ]
> > 
> > Hmmm, any risk in missing data integrity syncs because of this?
> 
> Need to think about that.  sys_fsync(), sys_fdatasync() and sys_msync() go
> direct to file->f_mapping and sys_sync() will sync the blockdev via its
> kernel-internal inode.  What does that leave?

I was worried about O_SYNC, That actually looks safe though,
generic_osync_inode will first write the mapping via filemap_fdatawrite
(the mapping comes from f_mapping).

It doesn't really give me warm fuzzies, but looks safe enough.  Al had a
slightly different plan, maybe with your patch we can push his larger
changes off a bit?

-chris


