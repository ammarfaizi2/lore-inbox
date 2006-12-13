Return-Path: <linux-kernel-owner+w=401wt.eu-S965138AbWLMT52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbWLMT52 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbWLMT51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:57:27 -0500
Received: from sbcs.cs.sunysb.edu ([130.245.1.15]:60152 "EHLO
	sbcs.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965127AbWLMT5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:57:25 -0500
Date: Wed, 13 Dec 2006 14:57:16 -0500 (EST)
From: Nikolai Joukov <kolya@cs.sunysb.edu>
X-X-Sender: kolya@compserv1
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
In-Reply-To: <Pine.LNX.4.61.0612132031220.32433@yvahk01.tjqt.qr>
Message-ID: <Pine.GSO.4.53.0612131443180.5969@compserv1>
References: <Pine.GSO.4.53.0612122217360.22195@compserv1>
 <Pine.LNX.4.61.0612132031220.32433@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >We have designed a new stackable file system that we called RAIF:
> >Redundant Array of Independent Filesystems.
> >
> >Similar to Unionfs, RAIF is a fan-out file system and can be mounted over
> >many different disk-based, memory, network, and distributed file systems.
> >RAIF can use the stable and maintained code of the other file systems and
> >thus stay simple itself.  Similar to standard RAID, RAIF can replicate the
> >data or store it with parity on any subset of the lower file systems.  RAIF
> >has three main advantages over traditional driver-level RAID systems:
> >
> >1. RAIF can be mounted over any set of file systems.  This allows users to
> >   create many more useful configurations.  For example, it is possible to
> >   replicate the data on the local and remote disks, and stripe the data on
> >   the local hard drives and keep the parity (or even ECC to tolerate
> >   multiple failures) on the remote server(s).  In the latter case, all the
> >   read requests will be satisfied from the fast local disks and no local
> >   disk space will be spent on parity.
>
> As for striping on a simplistic level, look at the Equal File
> Distribution patch for unionfs :-)
>
> http://www.mail-archive.com/unionfs@mail.fsl.cs.sunysb.edu/msg01936.html
>
> Files are stored normally so that after the union is unmounted, the
> files appear in one piece (unlike real RAID0 over two block devices).

RAIF supports rules that describe how to store particular files or groups
of files.  A rule with RAIF level 0 (which is similar to RAID level 0) and
a special striping unit size = '-1' will do the same (distribute the
files on the lower file systems) for files that match any given file name
pattern.  A rule with level 4 and striping unit size = '-1' will
distribute files on several file systems and store an extra copy of the
files on a dedicated file system (e.g., an NFS mount with lots of space).
Now guess what RAIF's level 6 will do with a special striping unit
size = '-1' :-)

Nikolai.
----------------
Nikolai Joukov, Ph.D.
Filesystems and Storage Laboratory
Stony Brook University
