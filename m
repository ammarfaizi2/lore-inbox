Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265219AbUGGQor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265219AbUGGQor (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 12:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUGGQor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 12:44:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:35725 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265219AbUGGQop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 12:44:45 -0400
Date: Wed, 7 Jul 2004 09:40:08 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Leszek <leszek@serwer.3miasto.net>
Cc: linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>, urban@teststation.com
Subject: [PATCH] smbfs compilation warning in 2.6.7
Message-Id: <20040707094008.5504bf05.rddunlap@osdl.org>
In-Reply-To: <Pine.NEB.4.60.0407071528060.25796@serwer.3miasto.net>
References: <Pine.NEB.4.60.0407071528060.25796@serwer.3miasto.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004 15:33:46 +0200 (CEST) Leszek wrote:

| 
| gcc 2.95.4  ( Debian Woody's default ) , kernel 2.6.7 from kernel.org 
| gives me the following compilation warning:
| 
| fs/smbfs/file.o
|    in function smb_file_sendfile
|    line 274: unknown conversion type character 'z' in format
| 
| Please CC me in your answers as I am not subscribed to the list.



Use %Zd to eliminate a compiler warning in printk.

diffstat:=
 fs/smbfs/file.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./fs/smbfs/file.c~smbfs_printk ./fs/smbfs/file.c
--- ./fs/smbfs/file.c~smbfs_printk	2004-06-15 22:19:53.000000000 -0700
+++ ./fs/smbfs/file.c	2004-07-07 09:39:21.886168160 -0700
@@ -271,7 +271,7 @@ smb_file_sendfile(struct file *file, lof
 
 	status = smb_revalidate_inode(dentry);
 	if (status) {
-		PARANOIA("%s/%s validation failed, error=%zd\n",
+		PARANOIA("%s/%s validation failed, error=%Zd\n",
 			 DENTRY_PATH(dentry), status);
 		goto out;
 	}

--
~Randy
