Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262084AbTCRBlE>; Mon, 17 Mar 2003 20:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262085AbTCRBlE>; Mon, 17 Mar 2003 20:41:04 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:8367 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id <S262084AbTCRBlC>;
	Mon, 17 Mar 2003 20:41:02 -0500
Date: Tue, 18 Mar 2003 02:47:00 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: nfs and getattr
Message-ID: <20030318014700.GA28769@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A NFS client through 100Mb Ether takes a loooooooong time to read a database
from the server, which the server itself reads in less than 10 seconds.
The database is a scene description for render that basically 'includes'
the same small set of files (around 10) many times, instanced all over the
place...

Mount in client:
10.0.0.1:/home on /home type nfs (rw,nfsvers=2,noac,addr=10.0.0.1)

Looking at nfsstats in the server:
Server rpc stats:
calls      badcalls   badauth    badclnt    xdrcall
491811     0          0          0          0       
Server nfs v2:
null       getattr    setattr    root       lookup     readlink   
1       0% 429338 87% 0       0% 0       0% 61474  12% 26      0% 
read       wrcache    write      create     remove     rename     
963     0% 0       0% 1       0% 1       0% 0       0% 1       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 3       0% 0       0% 2       0% 0       0% 

Server nfs v3:
null       getattr    setattr    lookup     access     readlink   
1      100% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       write      create     mkdir      symlink    mknod      
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
0       0% 0       0% 0       0% 0       0% 

What is that ton of getattr ? Do they come from nfs itself or must be
done by the reader via stat()s (perhaps it checks for file presence before
opening) ?

Is there any way to speedup that ?
Will nfs-v3 perform better ?

TIA

(Kernel is a patched (only bugfixes and bproc) 2.4.21-pre5. No -aa included.)

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre5-jam0 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))
