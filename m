Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264233AbRFFW4X>; Wed, 6 Jun 2001 18:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264234AbRFFW4N>; Wed, 6 Jun 2001 18:56:13 -0400
Received: from pat.uio.no ([129.240.130.16]:47283 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S264233AbRFFW4C>;
	Wed, 6 Jun 2001 18:56:02 -0400
To: "Phil Oester" <phil@theoesters.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: NFS caching issues on 2.4
In-Reply-To: <LAEOJKHJGOLOPJFMBEFEEEFNDNAA.phil@theoesters.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 07 Jun 2001 00:55:58 +0200
In-Reply-To: "Phil Oester"'s message of "Wed, 6 Jun 2001 13:48:48 -0700"
Message-ID: <shs3d9dtdz5.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Phil Oester <phil@theoesters.com> writes:

     > I've stumbled upon a wierd NFS caching issue on 2.4 which does
     > not seem to exist in 2.2.  Our www docroot is NFS mounted on a
     > NetApp 760.  We have a cron job which make changes to the
     > index.html every 5 minutes.

     > Recently, we upgraded all the web servers to 2.4 and noticed
     > that there were big delays in seeing these 5 minute updates.
     > Yet, an ls -l in the nfs directory on each of the servers
     > clearly shows the new timestamp.  However, a cat of the file
     > shows that it is the old version (sometimes up to 1 hour old).
     > I was using NFSv3, so decided to try NFSv2, but got the same
     > results.

     > I reverted to 2.2.19 on the boxes (which are RedHat 7.1
     > incidentally), and these problems went away.

     > Any ideas why this is happening?

The main suspect would be if you're mmapping the file while the cron
job updates your file on the server. This would means that the cache
invalidation breaks (see all the conditions in
invalidate_inode_pages()).

Cheers,
  Trond
