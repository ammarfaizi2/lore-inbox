Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261718AbTCQOtm>; Mon, 17 Mar 2003 09:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261719AbTCQOtm>; Mon, 17 Mar 2003 09:49:42 -0500
Received: from pat.uio.no ([129.240.130.16]:45703 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S261718AbTCQOtk>;
	Mon, 17 Mar 2003 09:49:40 -0500
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS file consistency
References: <20030317145054.GA7030@ncsu.edu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 17 Mar 2003 16:00:25 +0100
In-Reply-To: <20030317145054.GA7030@ncsu.edu>
Message-ID: <shswuiyqbqu.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == jlnance  <jlnance@unity.ncsu.edu> writes:

     > Hello All,
     >     I am trying to track down some file consistency problems I
     >     am seeing
     > and I want to make sure my assumptions about NFS are correct.
     >     Say I have 2 NFS clients, machine A and machine B.  Machine
     >     A does
     > an open/write/close on a file.  After this machine B does an
     > open/read on the file.  Is machine B guaranteed to read the
     > same data that A wrote or is there a delay between the time A
     > closes the file and the time B can expect to see valid data?

No delay should be necessary. Machine B should see the data that A
wrote.

     > Also if the file already existed before A wrote it, and B had
     > already read from it and closed it, does this affect anything?

Nope.

However the Linux 2.4.x NFS server has a known bug/feature that may
affect things: because the mtime only has a 1 second resolution,
changes that occur within < 1 second of one another may not cause
mtime to be updated.  When this occurs, the NFS client has no way to
tell that the file has changed.
This limitation no longer exists in Linux 2.5.x...

Cheers,
  Trond
