Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbQLTQPU>; Wed, 20 Dec 2000 11:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbQLTQPK>; Wed, 20 Dec 2000 11:15:10 -0500
Received: from moot.mb.ca ([64.4.83.10]:23305 "EHLO moot.cdir.mb.ca")
	by vger.kernel.org with ESMTP id <S129572AbQLTQPC>;
	Wed, 20 Dec 2000 11:15:02 -0500
Date: Wed, 20 Dec 2000 09:44:27 -0600 (CST)
From: "Michael J. Dikkema" <mjd@moot.ca>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 question (fh_lock_parent)
In-Reply-To: <14911.53776.854761.710519@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.21.0012200939180.7919-100000@sliver.moot.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2000, Neil Brown wrote:

> On Tuesday December 19, mjd@moot.ca wrote:
> > 
> > I've been getting tonnes of these since I installed 2.2.18. Is this a
> > problem? Should I even worry about this? If I don't need to worry about
> > it, is there a way to stop displaying this message?
> > 
> > fh_lock_parent: mqueue/xfBAA14279 parent changed or child unhashed
> > fh_lock_parent: mqueue/xfBAA16413 parent changed or child unhashed
> 
> You are running sendmail on an NFS client with /var/spool mounted off
> the NFS server which is giving these message - right?
> 
> These messages tend to indicate a race between two different NFS
> requests that try to do something to the one file - probably unlink
> it, though possibly rename it.

That's what you'd think. All these machines have a drive mounted on
/var.

[root@www /root]# df
Filesystem           1k-blocks      Used Available Use% Mounted on
10.0.0.10:/nfsroot    34020868  24061800   8230876  75% /
/dev/sda1              8744304   1473776   6826336  18% /var

I've checked to see if mtab was lying to me, and it's not.. I can unmount
and remount the drive on /var.. 

The system runs with one nfs server, and 4 children, all using nfs
root. They all mount /dev/sda1 on /var. Yet for some reason I get these
messages. I went from 2.2.16 -> 2.2.18 without changing anything but the
kernel. Has something changed? This doesn't look right to me at all.



,.;::
: Michael J. Dikkema
| Systems / Network Admin - Internet Solutions, Inc.
| http://www.moot.ca   Work: (204) 982-1060
; mjd@moot.ca
',.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
