Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265245AbSJaVS1>; Thu, 31 Oct 2002 16:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265284AbSJaVS1>; Thu, 31 Oct 2002 16:18:27 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:4 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S265245AbSJaVSW>;
	Thu, 31 Oct 2002 16:18:22 -0500
Message-ID: <3DC19F61.5040007@namesys.com>
Date: Fri, 01 Nov 2002 00:23:45 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Reiserfs-List@namesys.com
Subject: [BK][PATCH] Reiser4, will double Linux FS performance, please apply
Content-Type: multipart/mixed;
 boundary="------------090606000401060509080601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090606000401060509080601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Scary costume sent separately in case your spam filters reject it.

Reasons to apply:

* will more than double linux filesystem performance (see 
http://www.namesys.com/v4/fast_reiser4.html), this was measured for 
reading and writing the linux source code tree

* applying will allow vm and vfs changes to be tested and benchmarked on 
what will be the fastest linux fs by a factor of two when 2.6.0 ships

* performs all fs operations as an atomic transaction, so that, for 
instance, write() and truncate() system calls either happen entirely or 
not at all

* creates necessary infrastructure for an atomic fs transaction API (not 
yet included in Reiser4).  

* scalable by design to arbitrarily large numbers of CPUs (use per node 
locks rather than system wide locks)

* eliminates fixed size journal area

* creates a complete plugin based infrastructure.  This will allow 
folding in such features as constraints and inheritance as easily coded 
plugins.  It will make it possible to implement new security attributes 
as just files with new plugins.

* First installment of an effective competitor to the Microsoft OFS 
project.  No other Linux FS is even trying to provide an alternative to OFS.

We are quite excited over having combined such dramatic performance 
increases with atomic transactions, even better packing of small files, 
and a plugin infrastructure.  This functionality that has killed 
performance in other filesystems.  (BeFS for instance was forced to 
abandon important parts of its original vision for performance reasons.)

You once told me that you agreed that filesystems should have until 6 
weeks after VM/VFS stabilizes.   I regret that I have the need to remind 
you of that.  Reiser4 could not be ready earlier.  The changes we need 
in the core code are all fairly trivial, exporting functions and the 
like, I'll let you read the details yourself.   I hope that my fellow 
tribesman will look at the wooly mammoth on my shoulders as I come back 
from the hunt, forgive me for being late for dinner, think a thought for 
the poor hungry MS tribe, and help me make a roasting spit.;-)

We circulated all of the changes we needed in the core something like 
two weeks ago, nobody objected, and Andrew Morton actually read through 
them and ok'd them.  Viro and Hellwig of course didn't read them on the 
first posting, and then waited until today to find something to object 
to, and complained there wasn't enough time left in today.  (Being just 
as helpful to our integration as with V3....)  We will be happy to fix 
things in the manner the discussion leads to as soon as the discussion 
resolves, it seems to be still in progress as I write.

Reiser4 is clearly labeled as EXPERIMENTAL with notes that it should 
only be used by developers, benchmarkers, and testers for now.  It 
passes fsx and dbench, it passes mongo.pl for ump, it crashes for 
mongo.pl smp.  We expect it to be suitable for removal of the 
EXPERIMENTAL label before 2.6.0 ships (when it is suitable to remove it 
from the rest of the kernel. ;-) )  

I'd like to offer you a seminar on Reiser4 if you have time.   I am in 
the US/bayarea for Halloween and next month.  (My kids get to try their 
first Halloween today.  I hope your kids have fun too.)

I won't send you the other Nikita patches emails as I see you are 
already reading them.  Please consider Nikita to be authorized as the 
official maintainer of Reiser4 for the next month (until my return to 
Moscow).

Best,

Hans


--------------090606000401060509080601
Content-Type: message/rfc822;
 name="[reiserfs-list] [PATCH]: reiser4 [0/8] overview"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[reiserfs-list] [PATCH]: reiser4 [0/8] overview"

Return-Path: <reiserfs-list-return-11856-reiser=namesys.com@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 13529 invoked by uid 501); 31 Oct 2002 16:02:50 -0000
Mailing-List: contact reiserfs-list-help@namesys.com; run by ezmlm
Precedence: bulk
list-help: <mailto:reiserfs-list-help@namesys.com>
list-unsubscribe: <mailto:reiserfs-list-unsubscribe@namesys.com>
list-post: <mailto:reiserfs-list@namesys.com>
Errors-To: flx@namesys.com
X-Mailing-List: reiserfs-list@namesys.com
Delivered-To: mailing list reiserfs-list@namesys.com
Received: (qmail 13518 invoked from network); 31 Oct 2002 16:02:50 -0000
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.21545.509551.601735@laputa.namesys.com>
Date: Thu, 31 Oct 2002 19:02:49 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
	Reiserfs mail-list <Reiserfs-List@Namesys.COM>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-NSA-Fodder: JFK ECHELON Ft. Bragg Saddam Hussein White Water Qaddafi Nazi
Subject: [reiserfs-list] [PATCH]: reiser4 [0/8] overview

Hello, Linus,

This message starts set of 8 patches against your current BK tree to
include reiser4.

Changes to the core code are fairly small and trivial: mostly function
exports, plus one patch to share ->journal_info pointer with Ext3.

All patches are available at http://namesys.com/snapshots/2002.10.31/,
they can be applied in any order.

Utilities, including mkfs.reiser4 are available at
http://namesys.com/snapshots/2002.10.31/reiser4progs-0.1.0.tar.gz

Nikita.



--------------090606000401060509080601--

