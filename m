Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268478AbTCCJfD>; Mon, 3 Mar 2003 04:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268490AbTCCJfD>; Mon, 3 Mar 2003 04:35:03 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:41091 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268478AbTCCJfC>; Mon, 3 Mar 2003 04:35:02 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15971.9271.619893.597694@laputa.namesys.com>
Date: Mon, 3 Mar 2003 12:45:27 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Andrew Morton <akpm@digeo.com>
Cc: Dawson Engler <engler@csl.stanford.edu>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] potential deadlocks
In-Reply-To: <20030302221806.59836766.akpm@digeo.com>
References: <20030302212500.72fe9b87.akpm@digeo.com>
	<200303030605.h2365oK08706@csl.stanford.edu>
	<20030302221806.59836766.akpm@digeo.com>
X-Mailer: VM 7.07 under 21.5  (beta9) "brussels sprouts" XEmacs Lucid
X-Drdoom-Fodder: root satan drdoom crash crypt CERT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Dawson Engler <engler@csl.stanford.edu> wrote:
 > >
 > > BTW, are there known deadlocks (harmless or otherwise)?  Debugging
 > > the checker is a bit hard since false negatives are silent...
 > 
 > Known deadlocks tend to get fixed.  But I am surprised that you did not
 > encounter more of them.
 > 
 > btw, the filesystem transaction operations can be treated as sleeping locks. 
 > So for ext3, journal_start()/journal_stop() may, for lock-ranking purposes,
 > be treated in the same way as taking and releasing a per-superblock
 > semaphore.  Other filesystems probably have similar restrictions.
 > 

So are page-fault and memory allocation events, because thread
blocks on them, and deadlocks involving servicing page fault or memory
laundering have definitely been seen.

We have (incomplete) description of kernel lock ordering, which is
centered around reiser4 locks, but also includes some core kernel stuff.

It is available at 

http://www.namesys.com/v4/lock-ordering.dot  --- source for Bell-Labs' dot(1)
http://www.namesys.com/v4/lock-ordering.ps   --- postscript output, produced from the .dot source

 > Other such "hidden" sleeping locks are lock_sock() and wait_on_inode().  The
 > latter is rather messy because there is no clear API function which sets
 > I_LOCK.

Nikita.

