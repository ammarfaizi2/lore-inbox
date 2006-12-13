Return-Path: <linux-kernel-owner+w=401wt.eu-S964896AbWLMR4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWLMR4b (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 12:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWLMR4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 12:56:31 -0500
Received: from sbcs.sunysb.edu ([130.245.1.15]:56785 "EHLO sbcs.cs.sunysb.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964896AbWLMR4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 12:56:30 -0500
X-Greylist: delayed 524 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 12:56:30 EST
Date: Wed, 13 Dec 2006 12:47:42 -0500 (EST)
From: Nikolai Joukov <kolya@cs.sunysb.edu>
X-X-Sender: kolya@compserv1
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
cc: unionfs@filer.fsl.cs.sunysb.edu, fistgen@filer.fsl.cs.sunysb.edu
Subject: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
Message-ID: <Pine.GSO.4.53.0612122217360.22195@compserv1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have designed a new stackable file system that we called RAIF:
Redundant Array of Independent Filesystems.

Similar to Unionfs, RAIF is a fan-out file system and can be mounted over
many different disk-based, memory, network, and distributed file systems.
RAIF can use the stable and maintained code of the other file systems and
thus stay simple itself.  Similar to standard RAID, RAIF can replicate the
data or store it with parity on any subset of the lower file systems.  RAIF
has three main advantages over traditional driver-level RAID systems:

1. RAIF can be mounted over any set of file systems.  This allows users to
   create many more useful configurations.  For example, it is possible to
   replicate the data on the local and remote disks, and stripe the data on
   the local hard drives and keep the parity (or even ECC to tolerate
   multiple failures) on the remote server(s).  In the latter case, all the
   read requests will be satisfied from the fast local disks and no local
   disk space will be spent on parity.

2. RAIF is a file system and thus has access to the meta-data.  This allows
   it to store different files differently.  For example, RAIF can replicate
   important files (*.c, *.doc, etc) on all the lower file systems and
   stripe the multimedia files with parity at the same time.

3. It is sometimes more convenient to work with file systems than devices as
   the lower storage.  For example, it is possible to mount RAIF over a
   directory on an existing file system.  The data is represented as files
   on the lower file systems.  Therefore, any lower file system is an exact
   replica of the RAIF file system in the case of replication.  It also
   makes it easy to backup the data on the lower file systems using existing
   tools.

We have performed some benchmarking on a 3GHz PC with 2GB of RAM and U320
SCSI disks.  Compared to the Linux RAID driver, RAIF has overheads of about
20-25% under the Postmark v1.5 benchmark in case of striping and
replication.  In case of RAID4 and RAID5-like configurations, RAIF performed
about two times *better* than software RAID and even better than an Adaptec
2120S RAID5 controller.  This is because RAIF is located above file system
caches and can cache parity as normal data when needed.  We have more
performance details in a technical report, if anyone is interested.

We started the project in April 2004.  Right now I am using it as my
/home/kolya file system at home.  We believe that at this stage RAIF is
mature enough for others to try it out.  The code is available at:

	<ftp://ftp.fsl.cs.sunysb.edu/pub/raif/>

The code requires no kernel patches and compiles for a wide range of kernels
as a module.  The latest kernel we used it for is 2.6.13 and we are in the
process of porting it to 2.6.19.

We will be happy to hear your back.

Nikolai Joukov on behalf of the RAIF team.
----------------------------------
Filesystems and Storage Laboratory
Stony Brook University
