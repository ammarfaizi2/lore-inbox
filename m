Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310619AbSCMOrF>; Wed, 13 Mar 2002 09:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310625AbSCMOq4>; Wed, 13 Mar 2002 09:46:56 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:14313 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S310619AbSCMOqh>;
	Wed, 13 Mar 2002 09:46:37 -0500
Date: Wed, 13 Mar 2002 15:50:56 +0100
From: Sebastian Droege <sebastian.droege@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [2.5.7-pre1] Reiserfs mounting oops patch
Message-Id: <20020313155056.3918d052.sebastian.droege@gmx.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.:yG7pxqY9b7Jo9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.:yG7pxqY9b7Jo9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
here is a patch somebody has posted some time ago (Oleg Drokin I think), but it isn't included in 2.5.7-pre1 and some people might miss it first (like me ;) )
I think the patch is really important, because you can't mount a reiserfs partition without it
It fixes an oops when mounting a reiserfs partition and it works for me

Bye

--- fs/reiserfs/journal.c.old   Wed Mar 13 15:40:14 2002
+++ fs/reiserfs/journal.c       Wed Mar 13 15:41:23 2002
@@ -1958,8 +1958,7 @@
                SB_ONDISK_JOURNAL_DEVICE( super ) ?
                to_kdev_t(SB_ONDISK_JOURNAL_DEVICE( super )) : super -> s_dev;
        /* there is no "jdev" option and journal is on separate device */
-       if( ( !jdev_name || !jdev_name[ 0 ] ) && 
-           SB_ONDISK_JOURNAL_DEVICE( super ) ) {
+       if( ( !jdev_name || !jdev_name[ 0 ] ) ) {
                journal -> j_dev_bd = bdget( kdev_t_to_nr( jdev ) );
                if( journal -> j_dev_bd )
                        result = blkdev_get( journal -> j_dev_bd, 
@@ -1974,9 +1973,6 @@
                return result;
        }
 
-       /* no "jdev" option and journal is on the host device */
-       if( !jdev_name || !jdev_name[ 0 ] )
-               return 0;
        journal -> j_dev_file = filp_open( jdev_name, 0, 0 );
        if( !IS_ERR( journal -> j_dev_file ) ) {
                struct inode *jdev_inode;
--=.:yG7pxqY9b7Jo9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8j2dXe9FFpVVDScsRAuQ2AKD0tAqUkbvP9f7pz70rKdGohDwhgwCg1DND
KaWltWPkUfGEBgenHoetbus=
=lUeV
-----END PGP SIGNATURE-----

--=.:yG7pxqY9b7Jo9--

