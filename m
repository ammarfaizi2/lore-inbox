Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265901AbTGLTph (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 15:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266058AbTGLTph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 15:45:37 -0400
Received: from c180224.adsl.hansenet.de ([213.39.180.224]:40607 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S265901AbTGLTp3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 15:45:29 -0400
Message-ID: <3F1068C9.1070900@portrix.net>
Date: Sat, 12 Jul 2003 22:00:09 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-kernel@vger.kernel.org
Subject: 'NFS stale file handle' with 2.5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm experiencing really big problems with nfs on 2.5 - and I'm a bit 
stuck debugging.

Server:
Pentium II SMP Dual Server with Raid5/dm and nfs running 2.5.7[045][-mm]

Clients:
Athlon, same kernels
P3 800, same kernels and 2.4

Problem:
Accessing the nfs shares on the Server gives lots of 'nfs stale file 
handles', making it unusuable. A simple cp from nfs to nfs triggers it 
in a matter of seconds.
The shares are mounted with (hard,intr), that used to work with 2.4.20 
on the server, but I also tried no option, only hard and only soft, 
problem persists. Also I tried to remove nfs_directio from the build and 
only compiled in nfs2, all the same.
Being curious whats wrong I set up an export on the P3 800 and mounted 
it from the athlon (both running 2.5.75-mm1). This seems to work fine 
(just tested for 10 minutes or so, but typically the problem is 
triggered much earlier).
I also tried enabling the VERBOSE_DEBUG define in nfs source. But that 
doesn't give any more information.
Only one line that gets my attention:
NFS: giant filename in readdir (len 0x2f0a0969)

I'm really lost here. What can I try/do to further narrow this down? Any 
specific kernel revision I could try to go back, notice that already 
2.5.70 triggered it. With 2.4 on the server nothing of this happens.
Only thing left is to try booting the server without smp support, but I 
get some 'hde: lost interrupt' messages and it doesn't boot.
Note that I also tried to export a partition not on dm. Filesystem is 
ext3. I also tried the patches you posted some days ago in another thread.

Thanks for any suggestions,

Jan

# grep NFS .config
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y


-- 
Linux rubicon 2.5.75-mm1-jd10 #1 SMP Sat Jul 12 19:40:28 CEST 2003 i686

