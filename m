Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282757AbRLOQDG>; Sat, 15 Dec 2001 11:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282769AbRLOQC4>; Sat, 15 Dec 2001 11:02:56 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7948 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282757AbRLOQCx>; Sat, 15 Dec 2001 11:02:53 -0500
Date: Sat, 15 Dec 2001 16:02:39 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS woes in 2.5.1-pre8
Message-ID: <20011215160239.A32750@flint.arm.linux.org.uk>
In-Reply-To: <20011212164334.B16377@flint.arm.linux.org.uk> <shsofl49mpi.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <shsofl49mpi.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Dec 12, 2001 at 10:02:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 10:02:01PM +0100, Trond Myklebust wrote:
> There are (as of yet) no changes to the NFS client in 2.5.x.
> 
> Do you have any idea which syscall the above EIO is coming from? From
> your tcpdump, it didn't appear to be coming from the server, and the
> file attributes are getting displayed...

Ok, I've just seen it again.  Here's the call that's failing:

lstat("../lib/libts_variance-0.0.so.0", 0xbffffb98) = -1 EIO (Input/output error)

It seems that sometimes I can provoke it 4 or more times in a row, other
times no matter how hard I try, I can't.  "4 times in a row" here means
umounting and then remounting the export on the assabet.

As I mentioned in my last (private) mail, the setup was slightly different
from my first description.

flint (nfs client) is responsible for writing these files onto the NFS server
(raistlin), and the programs are run on assabet (nfs client).

flint
-----
  kernel 2.2.18-cdhs (raid)

  mount indicates:
  raistlin:/usr/src on /net/raistlin/src type nfs (rw,rsize=4096,wsize=4096,addr=192.168.0.3)

raistlin
--------
  kernel 2.4.16
  universal NFS server 2.2beta48

  raistlin's exports file looks similar to the following:

  /usr/src	flint(rw,no_root_squash)
  /usr/src/v2.5	assabet(ro)

assabet
-------
  kernel 2.5.1-pre10

  mount indicates:
  raistlin:/usr/src/v2.5 on /usr/src/v2.5 type nfs (ro,nolock,addr=192.168.0.3)

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

