Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290805AbSARUd5>; Fri, 18 Jan 2002 15:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290812AbSARUds>; Fri, 18 Jan 2002 15:33:48 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:56211 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S290805AbSARUda>; Fri, 18 Jan 2002 15:33:30 -0500
Message-Id: <200201182033.g0IKXE2R004723@tigger.cs.uni-dortmund.de>
To: Rainer Krienke <krienke@uni-koblenz.de>
cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256? 
In-Reply-To: Message from Rainer Krienke <krienke@uni-koblenz.de> 
   of "Fri, 18 Jan 2002 13:12:16 +0100." <200201181212.g0ICCGq14563@bliss.uni-koblenz.de> 
Date: Fri, 18 Jan 2002 21:33:13 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rainer Krienke <krienke@uni-koblenz.de> said:

[...]

> At our site we store all user (~4000 users) data centrally on several NFS
> servers (running solaris up to now). In order to ease administration we
> chose the approach to mount each user directory direcly (via automount
> configured by NIS) on a NFS client where the user wants to access his
> data. The most important effect of this is, that each users directory is
> always reachable under the path /home/<user>. This proofed to be very
> useful (from the administrators point of view) when moving users from one
> server to another, installing additionl NFS servers etc, because the only
> path the user knows about and sees when e.g. issuing pwd is
> /home/<user>. The second advantage is, that there is no need to touch the
> client system: No need for NFS mounts in /etc/fstab to mount the servers
> export directory and so there are no unneeded dependencies frpm any
> client to the NFS servers.

This is exactly what we do with our (much more modest) 600 accounts at the
Departamento de Informatica of the UTFSM (Valparaiso, Chile).

> Now think of a setup where no user directory mounts are configured but
> the whole directory of a NFS server with many users is exported. Of
> course this makes things easyer for the NFS-system since only one mount
> is needed but on the client you need to create link trees or something
> similar so the user still can access his home under /home/<user> and not
> something like /home/server1/<user>. Moreover even if you create link
> trees when you issue commands like pwd you see the real path (eg
> /server1/<user>) instead of the logical (/home/<user>). Such paths are
> soon written into scripts etc, so that if the user is moved sometime
> later things will be broken.

> You simply loose a layer of abstraction if you do not mount the users dir 
> directly. The only other solution I know of would be amd. Amd automatically 
> places a link. But since we come from the sun world, we simply uses suns 
> automounter and there were no problems up to now. 

The SunOS automounter (which we used before Solaris) did this too. It was a
pain in the neck, as the "real" path to the home does show through, and you
get the same problems with scripts &c containing physical, not logical,
paths to files. Fixing the _users_ is much harder than fixing up the
configurations...
-- 
Horst von Brand			     http://counter.li.org # 22616
