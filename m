Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129958AbRB1AMk>; Tue, 27 Feb 2001 19:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129976AbRB1AMa>; Tue, 27 Feb 2001 19:12:30 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:45318 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129958AbRB1AMN>; Tue, 27 Feb 2001 19:12:13 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Fries <dfries@umr.edu>
Date: Wed, 28 Feb 2001 11:12:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15004.16978.439300.108625@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Stale NFS handles on 2.4.2
In-Reply-To: message from David Fries on Sunday February 25
In-Reply-To: <20010214002750.B11906@unthought.net>
	<20010224141855.B12988@d-131-151-189-65.dynamic.umr.edu>
	<15000.39826.947692.141119@notabene.cse.unsw.edu.au>
	<20010224235342.D483@d-131-151-189-65.dynamic.umr.edu>
	<15000.53110.664338.230709@notabene.cse.unsw.edu.au>
	<20010225131013.E483@d-131-151-189-65.dynamic.umr.edu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday February 25, dfries@umr.edu wrote:
> On Sun, Feb 25, 2001 at 08:25:10PM +1100, Neil Brown wrote:
> > On Saturday February 24, dfries@umr.edu wrote:
> > Verrry odd.  I can see why you were suspecting a cache.
> > I'm probably going to have to palm this off to Trond, the NFS client
> > maintainer (are you listening Trond?) but could please confirm that
> > from the client you can:
> > 
> >  1/ ping server
> >  2/ rpcinfo -p server
> >  3/ showmount -e server
> >  4/ mount server:/exported/filesys /some/other/mount/point
> > 
> > If all of these work, them I am mistified.  If one of these fails,
> > then that might point the way to further investigation.
> 
> I have server:/home mounted on /home, the directory /home/david is the
> mount file/directory on that mount that has a stale handle, everything
> else on that mount point works including accessing any file under
> /home/david.

So... you can access things under /home/david, but you cannot access
/home/david itself?
So, supposing that "fred" were some file that you happen to know is
in /home/david, then

    ls /home/david             fails with ESTALE and does not cause
			       any traffic to the server and
    ls -l /home/david/fred     succeeds.

Is that right?

Could you try:
  echo 255 > /proc/sys/sunrpc/nfs_debug 

and then do the "ls /home/david" and see what gets put in 
/var/log/messages (or kern_log or syslog or where such things go).

NeilBrown
