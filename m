Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbTAYDnt>; Fri, 24 Jan 2003 22:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbTAYDnt>; Fri, 24 Jan 2003 22:43:49 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:21170 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S266100AbTAYDns>; Fri, 24 Jan 2003 22:43:48 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Christian Reis <kiko@async.com.br>
Date: Sat, 25 Jan 2003 14:54:09 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15922.2657.267195.355147@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, NFS@lists.sourceforge.net
Subject: Re: NFS client locking hangs for period
In-Reply-To: message from Christian Reis on Friday January 24
References: <20030124184951.A23608@blackjesus.async.com.br>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday January 24, kiko@async.com.br wrote:
> 
> Hello Neil,

Hi.

> 
> I've been trying to get at this problem for a while now, ....

> 
> It seems to be reproducible by having the client hang or reboot without
> shutting down properly. Another tip is that the server gets files left
> over in /var/lib/nfs/sm/ for the hanging client(s). 

> 
> Mount options follow for the client filesystems:
> 
> anthem:/export/root/    /   nfs defaults,rw,rsize=8192,wsize=8192,nfsvers=2 0 0
> anthem:/home    /home   nfs defaults,rw,rsize=8192,wsize=8192,nfsvers=3 0 0
> 

Hmmm.  So you have several clients all mounting the same root
filesystem, and mounting it writable?  That doesn't sound like a plan
for success.  How do you make sure the clients don't tread over each
other when using /etc files?

I suspect that what you really want is to mount root read-only, or
mount separate roots for each client, and then in either case to mount
with the "nolock" flag.

I suspect that your problem is related to the client trying to do
locking, but no having statd running on the client.
You cannot meaningfully do locking on an NFS mounted root filesystem.
Infact, I think it would be good if the default mount options for nfs
root included nolock... and if I read fs/nfs/nfsroot.c:root_nfs_name
correctly, nolock is the default.  Are you overriding that default
be explicitly setting "lock"??

NeilBrown
