Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbTHBAqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 20:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270858AbTHBAqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 20:46:45 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:28813
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S267378AbTHBAqo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 20:46:44 -0400
Date: Fri, 1 Aug 2003 21:02:05 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x NFS and NFSD
Message-ID: <20030801210205.A21542@animx.eu.org>
References: <20030730185115.B16021@animx.eu.org> <16169.58331.996181.236352@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <16169.58331.996181.236352@gargle.gargle.HOWL>; from Neil Brown on Fri, Aug 01, 2003 at 01:51:55PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2.6.x as a server:
> > I'm using nfs-kernel-server v1.0.5-1 (debian).
> > Config Ops:
> > CONFIG_NFSD=m
> > CONFIG_NFSD_V3=y
> > # CONFIG_NFSD_V4 is not set
> > CONFIG_NFSD_TCP=y
> > CONFIG_LOCKD=m
> > CONFIG_LOCKD_V4=y   << I didn't configure this, where'd it come
> > from?
> 
> If either NFS_V3 or NFSD_V3, then LOCKD_V4 is automatically added.

Ok, I see.

> > CONFIG_EXPORTFS=m
> > CONFIG_SUNRPC=m
> > This is in /etc/exports:
> > / vegeta(rw,no_root_squash,async,nohide)
> 
> "nohide" is incorrect here.

previous experience.  IIRC, if I didn't have it on /, I couldn't see /usr,
/raid-0, or others (2.4.x).

> > ls, and ls hangs.  client uses kernel 2.4.20 with NFSv3 enabled and it was
> > mounted v3.
> 
> I have a hunch what this might be, and it'll require fixing both the
> kernel and nfs-utils ;-(
> 
> Could you try using
>    mount -t nfsd nfsd /proc/fs/nfs

This worked.  Of course I also removed nohide from / and added the rest of
my FSs.  There were 4 in all on this test machine. / /usr /usr/src and
/home.  All are exported as above except / has nohide removed.

> before starting the nfs-kernel-server (particularly before starting
> mountd or running exportfs).
> 
> Also, if you are brave, could you try with the following two patches,
> one against linux-2.6.0-test2 and one against nfs-utils.  Then run the
> nfs kernel server *without* mounting /proc/fs/nfs first.

I did not try the patches.  This work around seems to be what I was looking
for.  I'll wait for the patches to be merged.  I did not patch the
nfs-kernel-server either.

I tried 2.6.x as a client to a v2 server running the userland server.  I do
get a ton of nfs not responding messages, but I did a find /mnt/usr on it. 
Doesn't seem to be going into D state this time.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
