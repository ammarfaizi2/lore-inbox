Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265218AbUFRPwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbUFRPwh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbUFRPuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:50:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42168 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265218AbUFRPne
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:43:34 -0400
Date: Fri, 18 Jun 2004 16:43:30 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Chris Mason <mason@suse.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] __bd_forget should wait for inodes using the mapping
Message-ID: <20040618154330.GY12308@parcelfarce.linux.theplanet.co.uk>
References: <1087523668.8002.103.camel@watt.suse.com> <20040618021043.GV12308@parcelfarce.linux.theplanet.co.uk> <1087563810.8002.116.camel@watt.suse.com> <20040618142207.GW12308@parcelfarce.linux.theplanet.co.uk> <1087570031.8002.153.camel@watt.suse.com> <20040618151558.GX12308@parcelfarce.linux.theplanet.co.uk> <1087573303.8002.172.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087573303.8002.172.camel@watt.suse.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 11:41:43AM -0400, Chris Mason wrote:
> > And yes, ->i_mapping flips on "normal" bdev inodes will go away - we set
> > ->f_mapping on open directly.
> 
> Fair enough, I'll cook up some code to bump the inode->bdev->bd_inode
> i_count in __sync_single_inode  It won't be pretty either though, I'll
> have to drop the inode_lock so that some function can take the bdev_lock
> to safely use inode->i_bdev.

*Ugh*

You do realize that ->i_bdev is not promised to be there either?  Could you
show the actual code that steps into this mess?
