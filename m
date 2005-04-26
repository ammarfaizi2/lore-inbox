Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVDZMJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVDZMJB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 08:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVDZMJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 08:09:00 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:18336 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261488AbVDZMIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 08:08:49 -0400
To: hch@infradead.org
CC: jamie@shareable.org, linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-reply-to: <20050426100953.GB30762@infradead.org> (message from Christoph
	Hellwig on Tue, 26 Apr 2005 11:09:53 +0100)
Subject: Re: [PATCH] private mounts
References: <20050425191015.GC28294@mail.shareable.org> <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu> <20050426091921.GA29810@infradead.org> <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org> <E1DQMkX-0000Fy-00@dorka.pomaz.szeredi.hu> <20050426095608.GA30554@infradead.org> <E1DQMsX-0000IX-00@dorka.pomaz.szeredi.hu> <20050426100953.GB30762@infradead.org>
Message-Id: <E1DQOrK-0000Uh-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 26 Apr 2005 14:08:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Problem 1:
> 
>  - you're mounting things into the global namespace, but expect it only
>    be visible to a certain subset of processes.  these processes are also
>    not specicified by a tradition unix session / process group / etc but
>    against all the process attributes we have based on the uid

Yes, so?  You are harping on this without ever telling a concrete
technical problem with it.

Yes root will assume it's a directory that can be read.  And it will
get -EACCESS.  Is there a problem with this?  Is there a problem with
NFS exports with root_squash (which is the default btw)?  See the
similarity?

> Problem 2, which is related:
> 
>  - in fuse you're re-routing filesystem request to userspace, so fine so good
>  - mount is currently a privilegued operation, and expects a privilegued
>    filesystem implementation, not an ordinary user
>  - to bypass that you have a suid mount wrapper
>  - now you need various hacks to make sure this can't be used by other users

Why is this a hack?  What is the problem with it?

NFSv3 implements it's own permission checking based on credentials
returned by the server.  If client doesn't support Posix ACL and
server does, the permission bits _will_ be out of sync with the actual
permission you get on the file, and you will never know why.  Is it a
problem?  Can it be avoided?

How would sshfs client create permission bits for files, which match
the exact permissions that the user has on the server.  The client
doesn't even know the uid of the user on the remote system let alone
what groups it belongs to.

Think about these problems, and if you have a _solution_ that you
think is better, then pray tell me.  If you don't have a solution, but
just want to bad-mouth the current FUSE imlementation, I'm not
interested.

Miklos
