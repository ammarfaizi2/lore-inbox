Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282945AbRLTJpO>; Thu, 20 Dec 2001 04:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282907AbRLTJpF>; Thu, 20 Dec 2001 04:45:05 -0500
Received: from elin.scali.no ([62.70.89.10]:28433 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S282702AbRLTJo6>;
	Thu, 20 Dec 2001 04:44:58 -0500
Message-ID: <3C21B30D.871B6BE4@scali.no>
Date: Thu, 20 Dec 2001 10:44:45 +0100
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, nfs list <nfs@lists.sourceforge.net>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.4.8 NFS Problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I was searching on google for some reports on the problem I'm seeing with our NFS server/clients and
found this thread. It looked somewhat the same (atleast the result with the EIO is the same).

Parts of old message :

>From: Mike Black (mblack@csihq.com)
>Date: Sep 05 2001 

>I've been getting random NFS EIO errors for a few months but
>now it's repeatable. 
>Trying to copy a large file from one 2.4.8 SMP box to another
>is consistently failing (at different offsets >each time). 



Our setup is like this :

Server:
	RedHat 7.2 - kernel 2.4.9-13smp
        nfs-utils-0.3.1-13.7.2.1
	ext3 filesystem (73GB)


Clients:
	ia32 client - RedHat 6.2 - kernel 2.2.19-6.2.7enterprise
	mount-2.10r-0.6.x


	alpha client - RedHat 6.2 - kernel 2.2.19 (vanilla)
	mount-2.10r-5


	ia64 client - RedHat 7.1 - kernel 2.4.3-12smp
	mount-2.10r-5



I've seen the "Input/Output error" problem only on the Alpha and the IA64 clients and the problem is
occuring when making a static library (with 'ar'). The message is like this :

ar: xxxxxx/libmpi.a: Input/output error


The mountpoints is mounted like this :

ia32 client:
huey:/export/home/mpitest /home/mpitest nfs rw,v3,rsize=8192,wsize=8192,addr=huey 0 0

alpha client:
huey:/export/home/mpitest /home/mpitest nfs rw,v3,rsize=8192,wsize=8192,addr=huey 0 0

ia64 client:
huey:/export/home/mpitest /home/mpitest nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=huey 0 0


I don't know why the "hard" and "lock" options doesn't appear on ia32 and alpha, but this might be
related to the /proc/mounts interface on the running kernel (these clients are running 2.2.19 while
the ia64 client is running 2.4). The automount entry looks like this :

/home           auto_home       rsize=8192,wsize=8192

So according to the nfs man pages the "hard" option should be default :

       hard           If an NFS file operation has a major timeout then report "server not
                      responding" on the console and continue retrying indefinitely.  This
                      is the default.


So what could be the problem here ? Is it a NFS server bug, a NFS client bug or a NFS/ext3 bug ? We
used to run RedHat 7.0 on this server with the 2.2.19-enterprise kernel, nfs-utils-0.3.1-7 and with
a ext2 filesystem. This problem did not occur back then.

Thanks,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best   
 mailto:sp@scali.no  |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.12.2 -         
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >300MBytes/s and <4uS latency
