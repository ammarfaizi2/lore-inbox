Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131370AbQLNRzh>; Thu, 14 Dec 2000 12:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131363AbQLNRz1>; Thu, 14 Dec 2000 12:55:27 -0500
Received: from kazoo.cs.uiuc.edu ([128.174.237.133]:21945 "EHLO
	kazoo.cs.uiuc.edu") by vger.kernel.org with ESMTP
	id <S131091AbQLNRzO>; Thu, 14 Dec 2000 12:55:14 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: Chris Lattner <sabre@nondot.org>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Alexander Viro <viro@math.psu.edu>,
        "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012141442390.1437-100000@duckman.distro.conectiva>
From: Fredrik Vraalsen <vraalsen@cs.uiuc.edu>
Date: 14 Dec 2000 11:23:59 -0600
In-Reply-To: <Pine.LNX.4.21.0012141442390.1437-100000@duckman.distro.conectiva>
Message-ID: <sz2g0jq9as0.fsf@kazoo.cs.uiuc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rik van Riel
|
| On Wed, 13 Dec 2000, Chris Lattner wrote:
| 
| > 1. kORBit adds about 150k of code to the 2.4t10 kernel.
| > 2. kNFS adds about 100k of code to the 2.4t10 kernel.
| > 3. kORBit can do everything kNFS does, plus a WHOLE lot more: For example
| >    implement an NFS like server that uses SSL to send files and
| >    requests... so it is really actually "secure".
| 
| So can you implement a kNFS server in kORBit that takes
| less than 50kB of RAM?  Otherwise it's still a contributor
| to bloat and this argument won't work ;)

Well, kORBit itself is bigger than kNFS, but like Chris said, it can
do much more. :)

For testing kORBit we wrote a new filesystem CorbaFS.  The CorbaFS
client is a kernel module that basically forwards the Linux VFS calls
to the userspace CorbaFS server.

According to lsmod, the CorbaFS module takes up only 11KB of RAM.
Keep in mind that CorbaFS is currently only a proof-of-concept of the
kernel calling into userspace through kORBit (it is a read-only
filesystem at the moment, for example).  But it should give you some
idea.

The cool thing is that the CorbaFS userspace server can implement any
kind of filesystem you want, as long as it follows the CorbaFS
interface!  The current implementation exports the filesystem on the
host machine that it is running on, similar to NFS.  But we also have
ideas for FTP or web filesystems, for example.  Imagine being able to
mount the web CorbaFS onto /mnt/www and do a
 
  cat /mnt/www/www.kernel.org/index.html

and the CorbaFS userspace server takes care of loading the webpage and
returning it to the kernel client.  And these new filesystems don't
take up any extra space in the kernel, since they all talk to the same
CorbaFS kernel module!  Not to mention being able to implement the
filesystem in any language you like, debug the implementation in
userspace, etc.

-- 
Fredrik Vraalsen  -  Research Assistant, Pablo research group
Department of Computer Science, University of Illinois at U-C
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
