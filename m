Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbUAEEwo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 23:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUAEEwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 23:52:44 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:47023
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S262888AbUAEEwj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 23:52:39 -0500
Subject: Re: udev and devfs - The final word
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: rob@landley.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200401042148.24742.rob@landley.net>
References: <20040103040013.A3100@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0401041847370.2162@home.osdl.org>
	 <Pine.LNX.4.58.0401041903290.6089@dlang.diginsite.com>
	 <200401042148.24742.rob@landley.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1073278352.1165.36.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 04 Jan 2004 23:52:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 04/01/2004 klokka 22:48, skreiv Rob Landley:

> NFS always struck me as a peverse design.  "The fileserver must be stateless 
> with regard to clients, even though maintainging state is what a filesystem 
> DOES, and the point of the thing is to export a filesystem."  Okay...  (If it 
> was exporting read-only filesystems with no locking of any kind, maybe they'd 
> have a point, but come on guys...)

Sigh... What has that got to do with anything?

Read the RFCs: NFS *was* entirely stateless until v4 was drafted.
Locking was never part of the NFS protocol, but was an external addition
that was documented by the Open Group. So, yes, there is a history and a
reason behind all the talk of statelessness.

As for the current thread about remembering device numbers: as far as
NFS is concerned, that is entirely an implementation issue. There is no
need for any extra NFS protocol support for this sort of crap.

> So why, exactly, can the NFS server not maintain whatever extra state it needs 
> to remember between reboots in a filesystem?  (Not even necessarily the one 
> it's exporting, just some rc file something under /var.)  The device node it 
> was exporting USED to be in the filesystem, you know, ala mknod.  Now that 
> the kernel's not keeping that stable, have the #*%(&# server generate a 
> number and make a note of it somewhere.  (Is requiring an NFS server to have 
> access to persistent storage too much to ask?)

It could be done (and probably entirely in userspace). I assume you are
volunteering to do the work?

> Personally, I could never figure out why Samba servers are in userspace but 
> NFS servers seem to want to live in the kernel.  I can almost secure a samba 
> server for access to the outside world, but a NFS system that isn't behind a 
> firewall automatically says to me "this machine has already been compromised 
> eight ways from sunday within five minutes of being exposed to the internet".  
> Call me paranoid...

Sun was doing Kerberos for NFS years before the Samba project was
started.

Security has bugger all to do with kernel or userland and everything to
do with the short-sighted "munitions" policies of certain governments at
the time around when the Sun RPC protocol was being drafted. The same
policies were still around to dictate our implementation much later when
we were doing RPC for Linux. Now the laws have changed, and so we've
finally been able to add strong authentication in 2.6.x.

Cheers,
  Trond
