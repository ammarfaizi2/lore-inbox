Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310207AbSCEUjA>; Tue, 5 Mar 2002 15:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310204AbSCEUiv>; Tue, 5 Mar 2002 15:38:51 -0500
Received: from pD951D150.dip.t-dialin.net ([217.81.209.80]:38372 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S310201AbSCEUik>;
	Tue, 5 Mar 2002 15:38:40 -0500
To: linux-kernel@vger.kernel.org
Cc: support@sistina.com, trond.myklebust@fys.uio.no
Subject: Re: PROBLEM: Oops during iozone over NFS against 2.4.18-rc4 +
 Trond's NFS Patches + Sistina's LVM2
In-Reply-To: <m3zo1q8kr2.fsf@venus.fo.et.local>
From: Joachim Breuer <jmbreuer@gmx.net>
Date: Tue, 05 Mar 2002 21:38:19 +0100
In-Reply-To: <m3zo1q8kr2.fsf@venus.fo.et.local> (Joachim Breuer's message of
 "Sun, 03 Mar 2002 03:09:53 +0100")
Message-ID: <m3eliykax0.fsf@venus.fo.et.local>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I received a patch from Sistina (thanks!) which does indeed fix the
oops occuring on the server. The patch apparently cleans up concurrent
usage of a _private buffer_head data field by ext3 and lvm. It does
*not*, however, alleviate the iozone error - that still occurs with
different semantics: iozone now exits cleanly after the i/o error is
displayed, NFS stays usable.

Trond: Is there anything I can do to get error messages/traces out of
the nfs layer? Or do analysis of the server (as it's fully usable
during/after the iozone run). Syslog (in full *.*) shows
nothing. Kudos for the patch btw - w/out I can't get write performance
better than 1.5MBps, with the patch it's an even 7.something MBps.

The iozone error reported below is 100% reproducible between those two
boxen.

Since the original report I've moved all mentioned machines to 2.4.18
(final, not -rc4) including Sistina's cleanup as mentioned above.

On a half-related note: I'm not subscribed to the nfs list and can't
subscribe to it without bending over backwards (the mail server
doesn't accept the confirmation mail targeted at it from an "dial-up"
(rather: dynamic-ip) account). No, the obvious simple solution is not
really viable.


Joachim Breuer <jmbreuer@gmx.net> writes:

> [1.] One line summary of the problem:
>
>   During performance test (using iozone) against nfs server with
>   kernel 2.4.18-rc4 + linux-2.4.18-NFS_ALL.dif (provided against
>   2.4.18-rc2, went in cleanly) from nfs.sourceforge.net + Sistina's
>   LVM2 beta1.1, Oops occurs.
>
> [2.] Full description of the problem/report:
>
>   Client and Server running same aforementioned kernel, NFS parameters
>   set to rsize==wsize==4096; udp. Exported FS is an ext3 on a LV on
>   two PVs (linear/segmented, not striped), one is a complete SCSI disk
>   (sda), the other is a partition of an IDE disk (hda5). "./iozone -ac
>   -R -n 256m" showed results for write/rewrite/read/reread; showed
>   "Error writing block at 219414528", "write: Input/output error",
>   "iozone: interrupted" before random read result. Result "never"
>   comes up (not in 15+ minutes), iozone appears hung (Ctrl-C won't
>   break it, kill -9 does).
>
>   Checking at the server shows oops detailed below, and high load
>   (around 8, stays up even after iozone was killed). No processes on
>   server show responsible for the load average in "top".
>
>   Same iozone against other NFS server works (more than one iteration,
>   this NFS server will be called "reference server" from here on). The
>   reference server is different hardware (see next paragraph and
>   [7.7]), esp. different ethernet controller. Reference server does
>   *NOT* employ LVM; but *does* also use ext3.
>
>   All boxen X86, server is a Celeron 900 (PIII-Core-based); client is
>   a Pentium III 850; running identical kernels. Reference server is a
>   dual Pentium Pro 200 SMP, using the same kernel modulo SMP turned
>   on. More info on hardware available on request.

[Rest of original problem report, including setup/machine description,
in <m3zo1q8kr2.fsf@venus.fo.et.local> posted on Sun, 03 Mar 2002 03:09:53 +0100]


So long,
   Joe

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
