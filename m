Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279627AbRK0Nza>; Tue, 27 Nov 2001 08:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279722AbRK0NzU>; Tue, 27 Nov 2001 08:55:20 -0500
Received: from mons.uio.no ([129.240.130.14]:54210 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S279627AbRK0NzG>;
	Tue, 27 Nov 2001 08:55:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15363.39718.446155.619699@charged.uio.no>
Date: Tue, 27 Nov 2001 14:54:46 +0100
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] Re: Fix knfsd readahead cache in 2.4.15
In-Reply-To: <20011126202509.J15582@redhat.com>
In-Reply-To: <15362.18626.303009.379772@charged.uio.no>
	<15362.53694.192797.275363@esther.cse.unsw.edu.au>
	<20011126.155347.45872112.davem@redhat.com>
	<20011126202509.J15582@redhat.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Benjamin LaHaise <bcrl@redhat.com> writes:

     > Hint: readahead via the page cache is the way to go...

That's not the problem: knfsd has always done readahead via the page
cache.

The problem is that the generic_file_read() stuff caches info about
the status of readaheads in the 'struct file', which is a volatile
object in NFS (it is released after the NFS request has been serviced).
To work around that, knfsd copies that readahead status data from the
struct file into a private cache, and trots it out again upon the next
READ call to reference that particular inode.

Cheers,
   Trond
