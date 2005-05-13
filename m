Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVEMGGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVEMGGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 02:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVEMGGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 02:06:44 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:36623 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262255AbVEMGGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 02:06:40 -0400
To: linuxram@us.ibm.com
CC: jamie@shareable.org, ericvh@gmail.com, 7eggert@gmx.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
In-reply-to: <1115946620.6248.299.camel@localhost> (message from Ram on Thu,
	12 May 2005 18:10:20 -0700)
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
References: <20050511170700.GC2141@mail.shareable.org>
	 <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
	 <1115840139.6248.181.camel@localhost>
	 <20050511212810.GD5093@mail.shareable.org>
	 <1115851333.6248.225.camel@localhost>
	 <a4e6962a0505111558337dd903@mail.gmail.com>
	 <20050512010215.GB8457@mail.shareable.org>
	 <a4e6962a05051119181e53634e@mail.gmail.com>
	 <20050512064514.GA12315@mail.shareable.org>
	 <a4e6962a0505120623645c0947@mail.gmail.com>
	 <20050512151631.GA16310@mail.shareable.org>
	 <E1DWIms-0005nC-00@dorka.pomaz.szeredi.hu> <1115946620.6248.299.camel@localhost>
Message-Id: <E1DWTJJ-0000qP-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 13 May 2005 08:06:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> r u sure, this program works?

Yes :)

> Sorry if I am saying something dumb here.
> Correct me.  When a file descriptor is sent from one process to other,
> arn't they referring to different files in each of the processes.
> fd=5 may be pointing to file 'xyz' in parent process, 
> where as fd=5 will be pointing to 'abc' in the child process.  

See 'man 7 unix' SCM_RIGHTS.

How do you know the program did not work?

Note: the program starts a new shell, it doesn't exit!  Do this in the
started shell (do not 'cd' before it):

  ls tmp/clonetest/mnt
  ls /tmp/clonetest/mnt

If you see different things, then the program worked.

It's not such a magic thing.  You can also do something similar for
example by:

shell1>  mount --bind / /tmp/mnt
shell1>  cd /tmp/mnt
sheel2>  umount -l /tmp/mnt

Now shell1 sees two separate "namespaces" in in CWD and /

Miklos
