Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263586AbTCULTF>; Fri, 21 Mar 2003 06:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263587AbTCULTF>; Fri, 21 Mar 2003 06:19:05 -0500
Received: from mail.mediaways.net ([193.189.224.113]:47453 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S263586AbTCULTD>; Fri, 21 Mar 2003 06:19:03 -0500
Subject: Re: kswapd oops in 2.4.20 SMP+NFS
From: Soeren Sonnenburg <kernel@nn7.de>
To: Oleg Drokin <green@namesys.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030321135841.D17440@namesys.com>
References: <1048170204.5161.11.camel@calculon>
	 <20030321112834.A17330@namesys.com> <1048240247.9345.19.camel@fortknox>
	 <20030321130402.C17440@namesys.com> <1048243299.9338.23.camel@fortknox>
	 <20030321135841.D17440@namesys.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048245614.9338.41.camel@fortknox>
Mime-Version: 1.0
Date: 21 Mar 2003 12:20:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-21 at 11:58, Oleg Drokin wrote:
> Hello!
> 
> On Fri, Mar 21, 2003 at 11:41:39AM +0100, Soeren Sonnenburg wrote:
> > > > > > VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
> > > > > Hm, what is the underlying host filesystem?
> > > > oops sorry, it is running ext2 on the smaller disks... and reiserfs
> > > > everywhere else but the above files were on a reiserfs partition which
> > > > is rather young (i.e. has not seen anything else than kernel 2.4.20)...
> > > Do you have any idea of what filesystem was unmounted? (the one with busy inodes)
> > I *think* it was either reiserfs or some nfs share (on that machine
> > there is only reiserfs... its again a 2.4.20 SMP machine ... the most
> > stable one we have).
> 
> Wait-wait, I am confused. First of all you just said you also have ext2 on smaller disks,
> now you are saying there is only reiserfs.
> Do you routinely unmount (and mount back ?) some filesystems on that NFS server box? What are those
> filesystems? How many filesystems do you have at all on that box?
> Given the fact that you usually cannot unmount nfs-exported fs, I presume nfs server was stopped
> at the time of umount, or was that non-exported filesystem, that was unmounted?
> I am trying to understand from what FS that 'busy inodes' thing came.
> (as it seems we already verified that another message from nfs-fh is from reiserfs (And I am working
> on that)).

Ok, sorry for the confusion. I try to clear that up:

There is machine1 (the one with ksymoops trace). It mounts 6 ext2
partitions, 4 reiserfs partitions, a number of nfs partitions through
automounter (like maybe 2-10) and 1 nfs partitions to backup to (that
one is regularly mounted and umounted after the backup).

the machine it backs up to say machine2 is running reiserfs only but
also mounts stuff using automounter...

both machines{1,2} are smp, kernel 2.4.20, both are nfs-servers.

I just checked the logs... It seems that the oops occurs 24 seconds
after the backup script was started (which is run hourly). 
This script first mounts the nfs share, then looks for modified files
and tar's them over, then umounts the share.

So it is probably the umount of that nfs partion.

HTH,
Soeren.

