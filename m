Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264969AbSJPITr>; Wed, 16 Oct 2002 04:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264970AbSJPITr>; Wed, 16 Oct 2002 04:19:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:36851 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S264969AbSJPITq>;
	Wed, 16 Oct 2002 04:19:46 -0400
Message-ID: <3DAD2263.2C8EAF7D@mvista.com>
Date: Wed, 16 Oct 2002 01:25:07 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Linus Torvalds <torvalds@transmeta.com>, rread@clusterfs.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.43 nfs fails to boot, fix
References: <Pine.NEB.4.44.0210160922280.20607-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: multipart/mixed;
 boundary="------------0A8F24DC55619D8C41286B2F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------0A8F24DC55619D8C41286B2F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Don't know if this is the correct fix, but it at least lets
the system boot with nfs.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------0A8F24DC55619D8C41286B2F
Content-Type: text/plain; charset=us-ascii;
 name="fix-2.5.43-nfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-2.5.43-nfs.patch"

--- /usr/src/linux-2.5.43-posix/fs/nfs/proc.c~	Wed Oct 16 00:18:10 2002
+++ linux/fs/nfs/proc.c	Wed Oct 16 01:10:40 2002
@@ -490,7 +490,7 @@
 
 	dprintk("NFS call  fsinfo\n");
 	info->fattr->valid = 0;
-	status = rpc_call(server->client, NFSPROC_STATFS, fhandle, &info, 0);
+	status = rpc_call(server->client, NFSPROC_STATFS, fhandle, info, 0);
 	dprintk("NFS reply fsinfo: %d\n", status);
 	if (status)
 		goto out;


--------------0A8F24DC55619D8C41286B2F--

