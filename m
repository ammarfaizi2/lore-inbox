Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265027AbSJWOYl>; Wed, 23 Oct 2002 10:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265030AbSJWOYl>; Wed, 23 Oct 2002 10:24:41 -0400
Received: from host179.debill.org ([64.245.56.179]:17345 "EHLO mail.debill.org")
	by vger.kernel.org with ESMTP id <S265027AbSJWOXp>;
	Wed, 23 Oct 2002 10:23:45 -0400
Date: Wed, 23 Oct 2002 09:29:56 -0500
To: jbradford@dial.pipex.com
Cc: Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Report Status
Message-ID: <20021023142956.GA1317@debill.org>
References: <Pine.LNX.4.44.0210222038380.8594-100000@dad.molina> <200210231226.g9NCQcBr004068@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210231226.g9NCQcBr004068@darkstar.example.net>
User-Agent: Mutt/1.3.28i
From: erik@debill.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 01:26:38PM +0100, jbradford@dial.pipex.com wrote:
> >                                2.5 Kernel Problem Reports as of 22 Oct
> >    Status                 Discussion  Problem Title
> >
> > --------------------------------------------------------------------------
> >    open                   17 Oct 2002 IDE not powered down on shutdown
> >   55. http://marc.theaimsgroup.com/?l=linux-kernel&m=103476420012508&w=2
> > 
> > --------------------------------------------------------------------------
> >
> > --------------------------------------------------------------------------
> >    open                   22 Oct 2002 2.5.44 fs corruption
> >   77. http://marc.theaimsgroup.com/?l=linux-kernel&m=103532467828806&w=2
> > 
> > --------------------------------------------------------------------------
> 
> Any possibility that the above two problems are related - I.E. disks
> are not being flushed properly on shutdown?

Nope.  Mine didn't get to shutdown.  Basically the whole system went
nuts - I couldn't run commands other than shell builtins, eth0
transmit timeouts, IDE complaining about attempts to access beyond the
end of device.  I couldn't do a proper shutdown - hard to sudo
shutdown -r now when you can execute anything.

The first thing to show in the log was:

Oct 22 06:27:40 hagbard kernel: is_tree_node: node level 0 does not match to the expected one 1
Oct 22 06:27:40 hagbard kernel: vs-5150: search_by_key: invalid format found in block 2162976. Fsck?
Oct 22 06:27:40 hagbard kernel: is_tree_node: node level 0 does not match to the expected one 1
Oct 22 06:27:40 hagbard kernel: vs-5150: search_by_key: invalid format found in block 2162976. Fsck?
Oct 22 06:27:40 hagbard kernel: is_tree_node: node level 3748 does not match to the expected one 1
Oct 22 06:27:40 hagbard kernel: vs-5150: search_by_key: invalid format found in block 80570. Fsck?
Oct 22 06:27:40 hagbard kernel: is_tree_node: node level 4831 does not match to the expected one 1
Oct 22 06:27:40 hagbard kernel: vs-5150: search_by_key: invalid format found in block 80626. Fsck?
Oct 22 06:27:40 hagbard kernel: is_tree_node: node level 3760 does not match to the expected one 1
Oct 22 06:27:40 hagbard kernel: vs-5150: search_by_key: invalid format found in block 80655. Fsck?
Oct 22 06:27:40 hagbard kernel: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [1040516 1315261 0x0 SD]
Oct 22 06:27:40 hagbard kernel: is_tree_node: node level 269 does not match to the expected one 1

after 3 seconds of that:

Oct 22 06:27:43 hagbard kernel: attempt to access beyond end of device
Oct 22 06:27:43 hagbard kernel: ide0(3,2): rw=0, want=928907664, limit=6152895
Oct 22 06:27:43 hagbard kernel: attempt to access beyond end of device
Oct 22 06:27:43 hagbard kernel: ide0(3,2): rw=0, want=1208618096, limit=6152895

which went on for a few iterations, then:

Oct 22 06:28:33 hagbard kernel: NETDEV WATCHDOG: eth0: transmit timed out
Oct 22 06:28:33 hagbard kernel: eth0: Transmit timed out: status 0150  0c00 at 3896/3957 command 00001622.
Oct 22 06:29:23 hagbard kernel: NETDEV WATCHDOG: eth0: transmit timed out
Oct 22 06:29:23 hagbard kernel: eth0: Transmit timed out: status 0150  0c00 at 3958/4018 command 00020000.


Interestingly enough, reiserfs didn't complain on reboot.  it was only
the root fs (on ext2/3) that complained - and had lots of problems.


Erik
