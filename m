Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTGFVtk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 17:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266728AbTGFVtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 17:49:40 -0400
Received: from air-2.osdl.org ([65.172.181.6]:41888 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263952AbTGFVtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 17:49:35 -0400
Date: Sun, 6 Jul 2003 15:03:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Paul.Clements@SteelEye.com, akpm@digeo.com, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH 2.5.74-mm2] nbd: make nbd and block layer agree about
 device and  block sizes
Message-Id: <20030706150333.28d61f4d.akpm@osdl.org>
In-Reply-To: <3F0896E4.4070003@pobox.com>
References: <3F089177.1A58BFE0@SteelEye.com>
	<3F089281.5BED1A25@SteelEye.com>
	<3F0896E4.4070003@pobox.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Also, I wonder if you found a bug/oversight in set_blocksize -- it sets 
>  bd_inode->i_blkbits but not bd_inode->i_size.  I think it should set 
>  i_size also.  Maybe Andrew or Al can confirm/refute this assertion.

set_blocksize() sets, err, the blocksize.

Lou was wanting to export bd_set_size() for setting i_size.  But
bd_set_size() goes and tries to set the blocksize too.

So the patch as-is will do I think, unless someone feels there's a need to
go and rework these things.

