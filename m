Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280825AbRLHOkq>; Sat, 8 Dec 2001 09:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280836AbRLHOkh>; Sat, 8 Dec 2001 09:40:37 -0500
Received: from [217.118.66.254] ([217.118.66.254]:6220 "EHLO
	backtop.namesys.com") by vger.kernel.org with ESMTP
	id <S280825AbRLHOkS>; Sat, 8 Dec 2001 09:40:18 -0500
From: Alexander Zarochentcev <zam@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15378.8955.835551.333970@backtop.namesys.com>
Date: Sat, 8 Dec 2001 17:26:03 +0300
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org, vs@namesys.com
Subject: Re: reiserfs_delete_solid_item [ xxx xxx 0(1) DIR ] not found when FS full?
In-Reply-To: <20011208062921.GA3002@alpha.of.nowhere>
In-Reply-To: <20011208062921.GA3002@alpha.of.nowhere>
X-Mailer: VM 7.00 under Emacs 21.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan on Alpha writes:

 > I was copying some tree and didn't notice my file-system filling up, but
 > I did notice this on the console (and in the logs):
 > 
 > Dec 8 07:17:31 alpha sudo: jurriaan : TTY=tty3 ; PWD=/var/spool ; USER=root
 > ; COMMAND=/bin/cp -ax news testnews Dec 8 07:22:03 alpha kernel: vs-5355:
 > reiserfs_delete_solid_item: [434934 434961 0(1) DIR] not found<4>vs-5355:
 > reiserfs_delete_soli d_item: [434933 434961 0(1) DIR] not found<4>vs-5355:
 > reiserfs_delete_solid_item: [434961 434962 0(1) DIR] not found<4>vs-5355:
 > reise rfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355:
 > reiserfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4 >vs-5355:
 > reiserfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355:
 > reiserfs_delete_solid_item: [434962 434963 0(1) D IR] not found<4>vs-5355:
 > reiserfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355:
 > reiserfs_delete_solid_item: [43496 2 434963 0(1) DIR] not found<4>vs-5355:
 > reiserfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355:
 > reiserfs_delete_sol id_item: [434962 434963 0(1) DIR] not found<4>vs-5355:
 > reiserfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355:
 > reis erfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355:
 > reiserfs_delete_solid_it
 > 
 > Somehow, 'delete' is not what I expect when copying. Is this something
 > to worry about?

`Delete' is possible when copying. reiserfs_new_inode() fails due to no free
space and iput() is called on partially created inode. Some items could be
missing and delete_inode() => delete_solid_item() warns during attempt to
delete them.

I added Vladimir Saveliev (vs) to CC list. Hope he will participate in
discussion if those error messages look not normal.

 > linux-2.4.17pre5, Alpha (EV56) system, more details on request.
 > 
 > Thanks,
 > Jurriaan
 > -- 
 > I am Ginsu of Borg. You will be assimilated - but WAIT! There's MORE!
 > GNU/Linux 2.4.17-pre5 on Debian/Alpha 64-bits 988 bogomips load:1.24 0.54 0.39
 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/


Thanks,
Alex.
