Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266555AbSKOSEv>; Fri, 15 Nov 2002 13:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266546AbSKOSEu>; Fri, 15 Nov 2002 13:04:50 -0500
Received: from mons.uio.no ([129.240.130.14]:24019 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S266841AbSKOSDi>;
	Fri, 15 Nov 2002 13:03:38 -0500
To: Richard Bouska <richard@bouska.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS mountned  directory  and apache2 (2.5.47)
References: <3DD4CB81.1050704@bouska.cz>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 15 Nov 2002 19:10:27 +0100
In-Reply-To: <3DD4CB81.1050704@bouska.cz>
Message-ID: <shsisyyzoto.fsf@helicity.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Richard Bouska <richard@bouska.cz> writes:

     > Hello In 2.45.47 and 2.5.46 (at least) did not try any other am
     > I not able to serve files bigger than 255 bytes by apache2 from
     > nfs mounted directory. The local files are served correctly.

     > The server is on 2.4.18. When I use the 2.4 also on client
     > everything works. When the content of the page is CGI generated
     > then the size is not limited like this.

     > Both client and server are x86 (athlon) kernel compiled with:
     > gcc version 2.95.4 20011002 (Debian prerelease)

     > sendfile() bug ??

Looks like whoever it was that changed the 'sendfile' API forgot to
update NFS. Try the following patch.

Cheers,
  Trond

--- linux-2.5.47/fs/nfs/file.c.orig	2002-11-08 14:16:27.000000000 -0500
+++ linux-2.5.47/fs/nfs/file.c	2002-11-15 13:06:06.000000000 -0500
@@ -175,6 +175,7 @@
 #ifdef CONFIG_NFS_DIRECTIO
 	.direct_IO = nfs_direct_IO,
 #endif
+	.sendfile = generic_file_sendfile,
 };
 
 /* 
