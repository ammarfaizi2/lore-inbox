Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129860AbRBYFo0>; Sun, 25 Feb 2001 00:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129871AbRBYFoG>; Sun, 25 Feb 2001 00:44:06 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:7954 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129870AbRBYFoE>; Sun, 25 Feb 2001 00:44:04 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Fries <dfries@umr.edu>
Date: Sun, 25 Feb 2001 16:43:46 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15000.39826.947692.141119@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stale NFS handles on 2.4.2
In-Reply-To: message from David Fries on Saturday February 24
In-Reply-To: <20010214002750.B11906@unthought.net>
	<20010224141855.B12988@d-131-151-189-65.dynamic.umr.edu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday February 24, dfries@umr.edu wrote:
> I have my home directory mounted on one computer from another.  I
> rebooted the server and now the client is saying Stale NFS file handle
> anytime something goes to read my home directory.  It has been this  
> way for about a day.  Shouldn't any caches expire by now?

It isn't that a cache needs to expire.  It sounds like it is a cache
that needs to be filled.

The kernel keeps a cache of ip addresses that are allowed access to
particular filesystems.  This is visible through /proc/fs/nfs/exports.
It is filled at reboot by "exportfs -a" or "exportfs -r" which gets
information from /etc/exports and /var/lib/nfs/rmtab.

So check that /etc/exports contains the right info.
Check that /var/lib/nfs/rmtab lists the filesystems and clients that
you expect to have access, and then run "exportfs -av"

NeilBrown


> 
> Both server and client are running 2.4.2.
> 
> I'ved tried `mount /home -o remount`, and reading lots of other
> directories to flush out that entry if it was in cache without any
> results.
> 
> I was hopping to avoid unmounting, as I would have to shut about
> everything down to do that.
> 
> -- 
> 		+---------------------------------+
> 		|      David Fries                |
> 		|      dfries@umr.edu             |
> 		+---------------------------------+
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
