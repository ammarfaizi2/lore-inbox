Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293151AbSCJShz>; Sun, 10 Mar 2002 13:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293154AbSCJShp>; Sun, 10 Mar 2002 13:37:45 -0500
Received: from 217-126-207-69.uc.nombres.ttd.es ([217.126.207.69]:7429 "EHLO
	server01.nullzone.prv") by vger.kernel.org with ESMTP
	id <S293151AbSCJShd>; Sun, 10 Mar 2002 13:37:33 -0500
Message-Id: <5.1.0.14.2.20020310193611.00caf1f8@192.168.2.131>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 10 Mar 2002 19:37:22 +0100
To: Edward Shushkin <edward@namesys.com>
From: system_lists@nullzone.org
Subject: Re: [reiserfs-list] Opss! on 2.5.6 with ReiserFS
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <3C8BCE86.17A5F7E8@namesys.com>
In-Reply-To: <5.1.0.14.2.20020310165035.00caf5c0@192.168.2.131>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Edward.
I'll apply and let me inform u about result ( just like a beta-tester )

At 21:22 10/03/2002 +0000, Edward Shushkin wrote:
>system_lists@nullzone.org wrote:
> >
> > Hi there,
> >
> >     i got a 'Opss' on my PII (one of my fileservers) just changing the
> > kernel version from 2.5.5 to .6
>
>Reiserfs in linux >= 2.5.6-pre3 does have broken stuff in journal area due 
>to vfs cleanups.
>Please wait, or apply this:
>
>--- linux-2.5.6-pre3/fs/reiserfs/journal.c.orig Thu Mar  7 12:44:43 2002
>+++ linux-2.5.6-pre3/fs/reiserfs/journal.c      Thu Mar  7 13:53:36 2002
>@@ -1960,8 +1960,7 @@
>                 SB_ONDISK_JOURNAL_DEVICE( super ) ?
>                 to_kdev_t(SB_ONDISK_JOURNAL_DEVICE( super )) : super -> 
> s_dev;
>         /* there is no "jdev" option and journal is on separate device */
>-       if( ( !jdev_name || !jdev_name[ 0 ] ) &&
>-           SB_ONDISK_JOURNAL_DEVICE( super ) ) {
>+       if( ( !jdev_name || !jdev_name[ 0 ] ) ) {
>                 journal -> j_dev_bd = bdget( kdev_t_to_nr( jdev ) );
>                 if( journal -> j_dev_bd )
>                         result = blkdev_get( journal -> j_dev_bd,
>@@ -1976,9 +1975,6 @@
>                 return result;
>         }
>
>-       /* no "jdev" option and journal is on the host device */
>-       if( !jdev_name || !jdev_name[ 0 ] )
>-               return 0;
>         journal -> j_dev_file = filp_open( jdev_name, 0, 0 );
>         if( !IS_ERR( journal -> j_dev_file ) ) {
>                 struct inode *jdev_inode;
>
>
>Thanks,
>Edward
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/




