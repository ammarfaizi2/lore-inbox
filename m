Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268963AbRIHLYk>; Sat, 8 Sep 2001 07:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269041AbRIHLYb>; Sat, 8 Sep 2001 07:24:31 -0400
Received: from mons.uio.no ([129.240.130.14]:19700 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S268963AbRIHLYS>;
	Sat, 8 Sep 2001 07:24:18 -0400
To: Ben Greear <greearb@candelatech.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Blocking v/s Non-blocking NFS (and iSCSI) file reads/writes.
In-Reply-To: <3B992F7D.4E07D59B@candelatech.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 08 Sep 2001 13:24:32 +0200
In-Reply-To: Ben Greear's message of "Fri, 07 Sep 2001 13:35:09 -0700"
Message-ID: <shsu1yencwf.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Ben Greear <greearb@candelatech.com> writes:

     > So, does select() work for NFS reads?  (IE: I open a
     > file-descriptor on an NFS mounted file system, and start
     > reading.  The network goes down.  Will select() start not
     > marking that file as read/write-able?)

No.

     > If I set the file descriptor to be O_NONBLOCK, will it return
     > immediately if the network is down (regardless of what select
     > told me)?

No.

The NFS layer knows nothing at all about the network. It relies on the
RPC layer to handle all that for it. There are 2 ways in which it can
do this:
  1) keep the NFS layer in the dark (using the 'hard' mount option)
  2) pass an error back which then propagates back through NFS to the
     user (the 'soft' mount option).

Cheers,
  Trond
