Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTB0JLH>; Thu, 27 Feb 2003 04:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTB0JLH>; Thu, 27 Feb 2003 04:11:07 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:10508 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S262780AbTB0JLG>; Thu, 27 Feb 2003 04:11:06 -0500
Date: Thu, 27 Feb 2003 01:21:21 -0800
From: jw schultz <jw@pegasys.ws>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
Message-ID: <20030227092121.GG15254@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk> <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DB2CA.32539D41@daimi.au.dk> <buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DCB89.9086582F@daimi.au.dk> <buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 05:42:30PM +0900, Miles Bader wrote:
> Kasper Dupont <kasperd@daimi.au.dk> writes:
> > > Yes.  On some systems, /var and /tmp are the _only_ read-write filesystems.
> > 
> > OK, but then on such a system with my approach it would be possible to
> > make /mtab.d a symlink pointing to somewhere under /var.
> 
> ... you could do the same with /etc/mtab.
> 
> In fact since /etc is almost guaranteed to be on the same filesystem as
> /, it seems like "/mtab.d" offers zero advantages over just /etc/mtab --
> the case where /etc/mtab is the most annoying is when /etc is R/O, but
> this almost always means that / will be R/O, making /mtab.d useless too.

If you netboot /etc as its own filesystem make sense.  Why
duplicate the rest of root just for /etc.  /etc, /var and
/tmp are the only filesystems that have much reason to be
unique to a system; all others are easily sharable and most
others read-only.

> 
> > But AFAIK fsck uses mtab.
> 
> It uses /etc/fstab.
> 
> > If mtab does not exist mount will attempt to create a new one with
> > only the root listed.
> 
> Unless you use the `-n' flag, which an init-script should do if it
> knows there's something wierd required to get /var mounted or something.

<voice of annoyance>
/etc/mtab is a hack.  I suspect it was done so that fsck, df
and umount wouldn't have to read /dev/kmem.  We now have
much better ways to get data out of the kernel.

The idea of storing the list of mounted filesystems on a
mounted filesystem is a bad idea from the get-go.  The only
advantage it ever really had was the possibility to manually
play mountpoint monte with mv.  Duplicating the in-kernel
data externally begs for inconsistencies that only get worse
with pivot root.

Let the data reside in the kernel and have a procfs or sysfs
entity for it.  A symlink from /etc/mtab can keep the old
tools happy.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
