Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129964AbRBYJZq>; Sun, 25 Feb 2001 04:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129972AbRBYJZg>; Sun, 25 Feb 2001 04:25:36 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:33299 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129964AbRBYJZW>; Sun, 25 Feb 2001 04:25:22 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Fries <dfries@umr.edu>
Date: Sun, 25 Feb 2001 20:25:10 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15000.53110.664338.230709@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stale NFS handles on 2.4.2
In-Reply-To: message from David Fries on Saturday February 24
In-Reply-To: <20010214002750.B11906@unthought.net>
	<20010224141855.B12988@d-131-151-189-65.dynamic.umr.edu>
	<15000.39826.947692.141119@notabene.cse.unsw.edu.au>
	<20010224235342.D483@d-131-151-189-65.dynamic.umr.edu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday February 24, dfries@umr.edu wrote:
[problem summary: After restarting knfsd server on 2.4.2, client
                  reports Stale NFS file handle]

> On Sun, Feb 25, 2001 at 04:43:46PM +1100, Neil Brown wrote:
> > So check that /etc/exports contains the right info.
> > Check that /var/lib/nfs/rmtab lists the filesystems and clients that
> > you expect to have access, and then run "exportfs -av"
> 
> checked, verified, re-exported, still Stale NFS file handle on client.
> I also used tcpdump on server and when I do ls on my home directory
> (this is where I see the Stale NFS message), it does not generate any
> network traffic.  It can't be the server if the client isn't asking
> for it.

Verrry odd.  I can see why you were suspecting a cache.
I'm probably going to have to palm this off to Trond, the NFS client
maintainer (are you listening Trond?) but could please confirm that
from the client you can:

 1/ ping server
 2/ rpcinfo -p server
 3/ showmount -e server
 4/ mount server:/exported/filesys /some/other/mount/point

If all of these work, them I am mistified.  If one of these fails,
then that might point the way to further investigation.

NeilBrown

> 
> > > Both server and client are running 2.4.2.
> > > 
> > > I'ved tried `mount /home -o remount`, and reading lots of other
> > > directories to flush out that entry if it was in cache without any
> > > results.
> > > 
> > > I was hopping to avoid unmounting, as I would have to shut about
> > > everything down to do that.
> 
> -- 
> 		+---------------------------------+
> 		|      David Fries                |
> 		|      dfries@umr.edu             |
> 		+---------------------------------+
