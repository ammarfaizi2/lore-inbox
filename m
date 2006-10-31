Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422950AbWJaIHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422950AbWJaIHy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422949AbWJaIHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:07:35 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:24213 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1422948AbWJaIHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:07:09 -0500
Date: Tue, 31 Oct 2006 09:04:29 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Roland Dreier <rdreier@cisco.com>
cc: Al Viro <viro@ftp.linux.org.uk>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 2/7] severing fs.h, radix-tree.h -> sched.h
In-Reply-To: <adak62hyclr.fsf@cisco.com>
Message-ID: <Pine.LNX.4.61.0610310903080.23540@yvahk01.tjqt.qr>
References: <E1GeUeF-0002o7-6s@ZenIV.linux.org.uk> <adak62hyclr.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	0.0 UPPERCASE_25_50        message body is 25-50% uppercase
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +EXPORT_SYMBOL(lock_super);
> > +EXPORT_SYMBOL(unlock_super);
>
>isn't the current fashion to do this like:
>
>void lock_super(struct super_block * sb)
>{
>	get_fs_excl();
>	mutex_lock(&sb->s_lock);
>}
>EXPORT_SYMBOL(lock_super);
>
>void unlock_super(struct super_block * sb)
>{
>	put_fs_excl();
>	mutex_unlock(&sb->s_lock);
>}
>EXPORT_SYMBOL(unlock_super);


Seems to be a draw:

fs$ grep -nr EXPORT .
./dcache.c:2113:EXPORT_SYMBOL(d_move);
./dcache.c:2114:EXPORT_SYMBOL_GPL(d_materialise_unique);
./dcache.c:2115:EXPORT_SYMBOL(d_path);
./dcache.c:2116:EXPORT_SYMBOL(d_prune_aliases);
./dcache.c:2117:EXPORT_SYMBOL(d_rehash);
./dcache.c:2118:EXPORT_SYMBOL(d_splice_alias);
./dcache.c:2119:EXPORT_SYMBOL(d_validate);

vs

./debugfs/file.c:86:EXPORT_SYMBOL_GPL(debugfs_create_u8);
./debugfs/file.c:127:EXPORT_SYMBOL_GPL(debugfs_create_u16);
./debugfs/file.c:168:EXPORT_SYMBOL_GPL(debugfs_create_u32);
./debugfs/file.c:247:EXPORT_SYMBOL_GPL(debugfs_create_bool);
./debugfs/file.c:292:EXPORT_SYMBOL_GPL(debugfs_create_blob);



	-`J'
-- 
