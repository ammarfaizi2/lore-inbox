Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWCVIJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWCVIJT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWCVIJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:09:18 -0500
Received: from muan.mtu.ru ([195.34.34.229]:44048 "EHLO muan.mtu.ru")
	by vger.kernel.org with ESMTP id S1751087AbWCVIJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:09:18 -0500
Subject: Re: 2.6.16-rc6-mm2: reiser4 BUG when unmounting fs
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com
In-Reply-To: <44206428.1080005@free.fr>
References: <20060318044056.350a2931.akpm@osdl.org>
	 <442061C0.4020702@free.fr>  <44206428.1080005@free.fr>
Content-Type: multipart/mixed; boundary="=-bqzNI1rISivNjNdoJGf+"
Date: Wed, 22 Mar 2006 10:43:26 +0300
Message-Id: <1143013406.6245.46.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bqzNI1rISivNjNdoJGf+
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hello

On Tue, 2006-03-21 at 21:38 +0100, Laurent Riffard wrote:
> Le 21.03.2006 21:27, Laurent Riffard a écrit :
> > Le 18.03.2006 13:40, Andrew Morton a écrit :
> > 
> >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm2/
> > 
> >  
> > Hello, 
> > 
> > This BUG is 100% reproducible. Simply boot to runlevel 1 and then 
> > unmount a reiser4 fs:
> 

The attached patch fixes the problem.

--=-bqzNI1rISivNjNdoJGf+
Content-Disposition: attachment; filename=reiser4-cleanup_init_fake_inode.patch
Content-Type: text/x-patch; name=reiser4-cleanup_init_fake_inode.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

 fs/reiser4/page_cache.c |    4 ----
 1 files changed, 4 deletions(-)

diff -puN fs/reiser4/page_cache.c~reiser4-fix-bd_inode fs/reiser4/page_cache.c
--- linux-2.6.16-rc6-mm2/fs/reiser4/page_cache.c~reiser4-fix-bd_inode	2006-03-21 06:42:42.000000000 +0300
+++ linux-2.6.16-rc6-mm2-vs/fs/reiser4/page_cache.c	2006-03-21 07:21:54.000000000 +0300
@@ -198,10 +198,6 @@ init_fake_inode(struct super_block *supe
 {
 	assert("nikita-2168", fake->i_state & I_NEW);
 	fake->i_mapping->a_ops = &formatted_fake_as_ops;
-	fake->i_blkbits = super->s_blocksize_bits;
-	fake->i_size = ~0ull;
-	fake->i_rdev = super->s_bdev->bd_dev;
-	fake->i_bdev = super->s_bdev;
 	*pfake = fake;
 	/* NOTE-NIKITA something else? */
 	unlock_new_inode(fake);

_

--=-bqzNI1rISivNjNdoJGf+--

