Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262702AbRGDMCD>; Wed, 4 Jul 2001 08:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263416AbRGDMBx>; Wed, 4 Jul 2001 08:01:53 -0400
Received: from pat.uio.no ([129.240.130.16]:50914 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S262702AbRGDMBp>;
	Wed, 4 Jul 2001 08:01:45 -0400
To: Dima Brodsky <dima@cs.ubc.ca>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: RPC: rpciod waiting on sync task!
In-Reply-To: <20010703164436.A20309@cascade.cs.ubc.ca>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 04 Jul 2001 14:01:33 +0200
In-Reply-To: Dima Brodsky's message of "Tue, 3 Jul 2001 16:44:36 -0700"
Message-ID: <shs1ynwdhsy.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dima Brodsky <dima@cs.ubc.ca> writes:

     > Hi, I modified the linux NFS client, kernel 2.4.5 and
     > 2.4.6-pre7, to send an extra SETATTR, with special values,
     > within nfs_open and nfs_release so that I would be able to
     > track file open and close.  For the server I am using a
     > slightly modified linux user level nfs server.

     > What I noticed is that after this change I get:

     > RPC: rpciod waiting on sync task!

That probably means that you've put this setattr code somewhere in the
rpciod read,write or delete callbacks.

You should never mix asynchronous and synchronous calls as this can
cause the rpciod task to deadlock by waiting on itself...

Cheers,
  Trond
