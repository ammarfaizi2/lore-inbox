Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293258AbSCAEl2>; Thu, 28 Feb 2002 23:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310350AbSCAEjj>; Thu, 28 Feb 2002 23:39:39 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:9742 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S310356AbSCAEgU>; Thu, 28 Feb 2002 23:36:20 -0500
Date: Fri, 1 Mar 2002 05:36:15 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: rsync kills 2.4.1X, also -ac and 2.4.18-rc4+XFS.
Message-ID: <20020301043615.GA1668@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have some tough stuff to debug for VM hackers.

I "killed" my kernel (it was just swapping and otherwise irresponsive)
with just aborting rsync v2.5.2.

0. Hardware: Single Duron 700, 320 MB RAM, 1.5 GB swap distributed over
   some disks. One SCSI (Fujitsu, attached to SYM53C875) holding the
   system (LVM), three IDE (Maxtor and IBM) holding data (no LVM,
   attached to VIA KT133). -ac kernels were compiled with gcc 2.95.3,
   not sure about SuSE's kernel.

1. Use rsync v2.5.2 to copy some files from one partition (reiserfs, on
   IDE) to another partition (ext3).

2. Watch the kernel nicely use all free RAM for Cache, no swap.

3. While rsync is sill running, press Ctrl+C.

4. Now watch how the kernel turns CACHE into USED RAM (xosview), starts
   swapping like hell (page out is high, swaps like 100 MB in just some few
   seconds) and makes the machine unusable.

Careful, save your data before you try this!

With 2.4.18-pre9-ac3 + Morton's Mini-LL patch, I was able to do "swapoff
-av" to have the machine recover in some minutes' time, with 2.4.18-rc4
or with 2.4.19-pre1-ac2 without LL patch, no way to get a single
character into my xterm.

Using GNU cp v4.1 instead of rsync v2.5.2 does not exhibit this
behaviour, but I'm not sure what rsync does that messes the kernel.
Initially, I thought it was related to rmap, but I cannot find hints
that Hubert's kernel uses rmap. I didn't get around to try -aa kernels
yet. Will do later unless someone has a fix until then ;-)

Some bug must lurk in the kernel which lets rsync wreak havoc with the
memory management.

-- 
Matthias Andree

GPG encrypted mail welcome, unless it's unsolicited commercial email.
