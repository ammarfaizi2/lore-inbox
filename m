Return-Path: <linux-kernel-owner+w=401wt.eu-S1751751AbWLNVCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbWLNVCF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 16:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbWLNVCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 16:02:05 -0500
Received: from sbcs.cs.sunysb.edu ([130.245.1.15]:63246 "EHLO
	sbcs.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbWLNVCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 16:02:04 -0500
Date: Thu, 14 Dec 2006 16:01:54 -0500 (EST)
From: Nikolai Joukov <kolya@cs.sunysb.edu>
X-X-Sender: kolya@compserv1
To: Al Boldi <a1426z@gawab.com>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
In-Reply-To: <200612132257.24399.a1426z@gawab.com>
Message-ID: <Pine.GSO.4.53.0612141538410.6095@compserv1>
References: <Pine.GSO.4.53.0612122217360.22195@compserv1>
 <200612132257.24399.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nikolai Joukov wrote:
> > We have designed a new stackable file system that we called RAIF:
> > Redundant Array of Independent Filesystems.
>
> Great!
>
> > We have performed some benchmarking on a 3GHz PC with 2GB of RAM and U320
> > SCSI disks.  Compared to the Linux RAID driver, RAIF has overheads of
> > about 20-25% under the Postmark v1.5 benchmark in case of striping and
> > replication.  In case of RAID4 and RAID5-like configurations, RAIF
> > performed about two times *better* than software RAID and even better than
> > an Adaptec 2120S RAID5 controller.
>
> I am not surprised.  RAID 4/5/6 performance is highly sensitive to the
> underlying hw, and thus needs a fair amount of fine tuning.

Nevertheless, performance is not the biggest advantage of RAIF.  For
read-biased workloads RAID is always slightly faster than RAIF.  The
biggest advantages of RAIF are flexible configurations (e.g., can combine
NFS and local file systems), per-file-type storage policies, and the fact
that files are stored as files on the lower file systems (which is
convenient).

> > This is because RAIF is located above
> > file system caches and can cache parity as normal data when needed.  We
> > have more performance details in a technical report, if anyone is
> > interested.
>
> Definitely interested.  Can you give a link?

The main focus of the paper is on a general OS profiling method and not
on RAIF.  However, it has some details about the RAIF benchmarking with
Postmark in Chapter 9:

  <http://www.fsl.cs.sunysb.edu/docs/joukov-phdthesis/thesis.pdf>

Figures 9.7 and 9.8 also show profiles of the Linux RAID5 and RAIF5
operation under the same Postmark workload.

Nikolai.
---------------------
Nikolai Joukov, Ph.D.
Filesystems and Storage Laboratory
Stony Brook University
