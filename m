Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbRCWQSt>; Fri, 23 Mar 2001 11:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131221AbRCWQSk>; Fri, 23 Mar 2001 11:18:40 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:64975 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S131205AbRCWQSY>; Fri, 23 Mar 2001 11:18:24 -0500
Message-ID: <3ABB76A5.2031C1D4@austin.ibm.com>
Date: Fri, 23 Mar 2001 10:15:33 -0600
From: Dave Kleikamp <shaggy@austin.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andreas Dilger <adilger@turbolinux.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC] sane access to per-fs metadata (was Re: 
 [PATCH]Documentation/ioctl-number.txt)
In-Reply-To: <Pine.GSO.4.21.0103221720250.5619-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al,
I didn't know that creating file system ioctl's was such a hot topic. 
Since the functions I want to implement are for a very specific purpose
(I don't expect anything except the JFS utilities to invoke them), I
would expect an ioctl to be an appropriate vehicle.

If not ioctl's, why not procfs?  Your proposal is that each filesystem
implements its own mini-procfs.  What's the advantage of that?

My intentions so far are to use ioctl's for specific operations required
by the JFS utilities, and procfs for debugging output, tuning, and
anything else that make sense.

Alexander Viro wrote:
> That may look like an overkill, however
>         * You can get rid of any need to register ioctls, etc.

This is a one-time thing

>         * You can add debugging/whatever at any moment with no need to
>           update any utilities - everything is available from plain shell

We can do this with procfs right now.

>         * You can conveniently view whatever metadata you want - no need to
>           shove everything into ioctls on one object.

Again, why re-invent procfs?  We could put this under
/proc/fs/jfs/metadata.

>         * You can use normal permissions control - just set appropriate
>           permission bits for objects on jfsmeta
> 
> IOW, you can get normal filesystem view (meaning that you have all usual
> UNIX toolkit available) for per-fs control stuff. And keep the ability to
> do proper locking - it's the same driver that handles the main fs and you
> have access to superblock. No need to change the API - everything is already
> there...

I'm not sure how a utility would make atomic changes to several pieces
of metadata.  The underlying fs code would protect the integrity of
every metadata "file", but changes to more than one of these "files"
would not be done as a group without some additional locking that would
have to be coordinated between the utility and the fs.  This kind of
thing could be handled by writing some special command to a
"command-processor" type file, but why is this better than an ioctl?


-- 
David Kleikamp
IBM Linux Technology Center
