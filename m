Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272359AbRIKJzh>; Tue, 11 Sep 2001 05:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272357AbRIKJz2>; Tue, 11 Sep 2001 05:55:28 -0400
Received: from [195.89.159.99] ([195.89.159.99]:11511 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S272359AbRIKJzT>; Tue, 11 Sep 2001 05:55:19 -0400
Date: Tue, 11 Sep 2001 10:55:32 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: nfs is stupid ("getfh failed")
Message-ID: <20010911105532.A20301@kushida.degree2.com>
In-Reply-To: <002b01c136e1$3bb36a80$81d4870a@cartman> <20010907025947.E7329@kushida.degree2.com> <15261.47090.893483.500877@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15261.47090.893483.500877@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Tue, Sep 11, 2001 at 05:06:26PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> > I'm seeing this message quite often with one Linux 2.4.7 system
> > automounting another.  As long as A has B's filesystem mounted, all is
> > ok.  Then A times out, unmounts, and later wants to remount B's
> > filesystem.  Then, sometimes, I see a message much like yours.
> > 
> > It doesn't seem to need a reboot to cause this problem, and the fix I
> > have found is to kill and restart the NFS server: /etc/init.d/nfs
> > restart.
> > 
> > I have no idea why it happens, or why restarting nfsd or mountd fixes it.
> 
> Show me your /etc/exports....
> 
> If you export a directory and a subdirectory of that directory - both
> on the same filesysem, you can get this.
> If you export a directory to both an IP address (or subnet) and a
> hostname (or wildcard or netgroup) this can also happen.

Yes, I'm doing the second of those.  No alternative -- I need write
access from some hosts, and read access to all the rest (who are
dynamically allocated) on the subnet.

It's clearly a bug in the NFS server then.

-- Jamie

/etc/exports:

# I want ro granted to all hosts in the 172.30.* subnet, but rw
# granted to the machines in @aquarius_outside which is within that
# subnet.  Doesn't work, whichever order I write the lines.
# (The machines in @aquarius_hosts always get read only access).
#
# Solution, though I don't like it: write the host names explicitly.
#
# The 192.168.64.192/19 subnetwork is for temporarily assigned IPs on
# the Aquarius test network.  /kickstart is used for kickstart
# installations on machines plugged in temporarily.

/home		172.30.0.0/16(ro,root_squash) \
		galatea.degree2.com(rw,root_squash) \
		ariel.degree2.com(rw,root_squash) \
		@aquarius_hosts(rw,root_squash) \
		@aquarius_outside(rw,root_squash)

/kickstart	172.30.0.0/16(ro,root_squash) \
		@aquarius_hosts(ro,root_squash) \
		@aquarius_outside(ro,root_squash) \
		192.168.64.192/255.255.255.224(ro,root_squash)
