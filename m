Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262816AbVF3NaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbVF3NaO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 09:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVF3NaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 09:30:13 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:35854 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262967AbVF3NXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 09:23:33 -0400
Message-ID: <42C3F253.8060305@suse.com>
Date: Thu, 30 Jun 2005 09:23:31 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reiserfs: enable attrs by default if saf
References: <20050629225306.GA7287@locomotive.unixthugs.org> <20050630101334.GJ2243@suse.de>
In-Reply-To: <20050630101334.GJ2243@suse.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Doh. Thanks.

- -Jeff

Jens Axboe wrote:
> On Wed, Jun 29 2005, Jeff Mahoney wrote:
>> The following patch enables attrs by default if the reiserfs_attrs_cleared
>> bit is set in the superblock. This allows chattr-type attrs to be used
>> without any further action by the user.
>>
>> Please apply.
>>
>>Signed-off-by: Jeff Mahoney <jeffm@suse.com>
>> 
>>diff -ruNpX dontdiff linux-2.6.12-rc6/fs/reiserfs/super.c linux-2.6.12-rc6.devel/fs/reiserfs/super.c
>>--- linux-2.6.12-rc6/fs/reiserfs/super.c	2005-06-13 14:34:58.000000000 -0400
>>+++ linux-2.6.12-rc6.devel/fs/reiserfs/super.c	2005-06-22 17:34:55.000000000 -0400
>>@@ -884,6 +884,8 @@ static void handle_attrs( struct super_b
>> 				reiserfs_warning(s, "reiserfs: cannot support attributes until flag is set in super-block" );
>> 				REISERFS_SB(s) -> s_mount_opt &= ~ ( 1 << REISERFS_ATTRS );
>> 		}
>>+	} else if (le32_to_cpu( rs -> s_flags ) & reiserfs_attrs_cleared) {
>>+		REISERFS_SB(s)->s_mount_opt |= REISERFS_ATTRS;
>> 	}
>> }
> 
> Except rs isn't initialized there, causing a compile warning and a crash
> booting the resulting kernel when reiser mounts...
> 
> Signed-off-by: Jens Axboe <axboe@suse.de>
> 
> diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
> --- a/fs/reiserfs/super.c
> +++ b/fs/reiserfs/super.c
> @@ -1053,10 +1053,9 @@ static void handle_barrier_mode(struct s
>  
>  static void handle_attrs( struct super_block *s )
>  {
> -	struct reiserfs_super_block * rs;
> +	struct reiserfs_super_block * rs = SB_DISK_SUPER_BLOCK (s);
>  
>  	if( reiserfs_attrs( s ) ) {
> -		rs = SB_DISK_SUPER_BLOCK (s);
>  		if( old_format_only(s) ) {
>  			reiserfs_warning(s, "reiserfs: cannot support attributes on 3.5.x disk format" );
>  			REISERFS_SB(s) -> s_mount_opt &= ~ ( 1 << REISERFS_ATTRS );
> 


- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCw/JTLPWxlyuTD7IRAgM4AJ9Z12KyHZqvqeYEM1SySO7Dg/2vWwCfaH7Y
qz/pAeg2gy1JigcIbgbbghA=
=LHPR
-----END PGP SIGNATURE-----
