Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263324AbUFRV2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUFRV2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUFRVZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:25:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:56785 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262837AbUFRVYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:24:30 -0400
Date: Fri, 18 Jun 2004 14:27:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] __bd_forget should wait for inodes using the
 mapping
Message-Id: <20040618142710.5d467d1b.akpm@osdl.org>
In-Reply-To: <1087591484.1512.14.camel@watt.suse.com>
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
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> [ skip writing block-special inodes ]
> 
> Hmmm, any risk in missing data integrity syncs because of this?

Need to think about that.  sys_fsync(), sys_fdatasync() and sys_msync() go
direct to file->f_mapping and sys_sync() will sync the blockdev via its
kernel-internal inode.  What does that leave?
