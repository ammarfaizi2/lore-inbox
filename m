Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbUBYXVL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUBYXNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:13:47 -0500
Received: from lakemtao08.cox.net ([68.1.17.113]:61928 "EHLO
	lakemtao08.cox.net") by vger.kernel.org with ESMTP id S261822AbUBYXKs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:10:48 -0500
From: "Michael Joy" <mdj00b@acu.edu>
To: "'Nathan Scott'" <nathans@sgi.com>,
       "'Nico Schottelius'" <nico-kernel@schottelius.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: another hard disk broken or xfs problems?
Date: Wed, 25 Feb 2004 17:10:59 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-reply-to: <20040225223428.GD640@frodo>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-index: AcP78Nyz5NW+qFE+QvacJ2ZzceMHjwAA3LQg
Message-Id: <20040225231045.LJJM25915.lakemtao08.cox.net@nagasaki>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One thing I've run into recently is that Hitachi drives come from the
factory with bad sectors out of the box. If you run a full format on the
drive checking for bad sectors the first time you use the drive, it will
occasionally find an error, the format will die, and the next time you
format nothing will be found.

It's a symptom of Hitachi not properly QC'ing their drives by fully
formatting them several times. The problem can reoccur over the first few
days until the drive finds all the questionable bad sectors and reallocates
backup sectors to cover for it.

This is OS independent as NTFS has serious issues with this :)

I hope this helps.

Michael

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Nathan Scott
Sent: Wednesday, February 25, 2004 4:34 PM
To: Nico Schottelius; Linux Kernel Mailing List
Subject: Re: another hard disk broken or xfs problems?

On Wed, Feb 25, 2004 at 11:00:51PM +0100, Nico Schottelius wrote:
> Hello!
> 
> I am now using a brand new 40GB Hitachi hard disk for my notebook and
> today I got the first problems:
> 
> 
> Starting XFS recovery on filesystem: hda3 (dev: hda3)
> Ending XFS recovery on filesystem: hda3 (dev: hda3)
> VFS: Mounted root (xfs filesystem) readonly.
> Mounted devfs on /dev
> Freeing unused kernel memory: 156k freed
> XFS mounting filesystem hda1
> Starting XFS recovery on filesystem: hda1 (dev: hda1)
> Ending XFS recovery on filesystem: hda1 (dev: hda1)
> XFS mounting filesystem loop0
> Starting XFS recovery on filesystem: loop0 (dev: loop0)
> XFS internal error XFS_WANT_CORRUPTED_GOTO at line 1589 of file
fs/xfs/xfs_alloc.c.  Caller 0xc0198272
> Call Trace: [<c0197151>]  [<c0198272>]  [<c0198272>]  [<c01c7fff>]
[<c01ee628>]  [<c01e5286>]  [<c01e5355>]  [<c01e6b04>]  [<c01d24fa>]
[<c01dd2cc>]  [<c01e83bd>]  [<c0203c60>]  [<c01d908f>]  [<c01f02c6>]
[<c02048e3>]  [<c02046c8>]  [<c0215517>]  [<c0185764>]  [<c015c835>]
[<c015c268>]  [<c0204890>]  [<c0204630>]  [<c015c4af>]  [<c0171ee8>]
[<c01721f4>]  [<c0172044>]  [<c01725ef>]  [<c010b34b>] 
> Ending XFS recovery on filesystem: loop0 (dev: loop0)
> Adding 192772k swap on /dev/discs/disc0/part2.  Priority:-1 extents:1
> 
> 
> I got this after a clean shutdown. Just tell me it's an xfs error and my
> harddisk is fine...

Filesystem recovery doesn't run after a clean shutdown...
the "Starting/Ending XFS recovery" messages indicate that
all of your filesystems were not unmounted by the look of
it.

Probably file data for the file backing your loopback device
has been lost/corrupted due to what looks like an "abrupt" end
before reboot (only metadata is journalled), and hence trying
to recover the loop device is going horribly wrong.

So, doesn't look like a hard disk error to me, and nor does it
look like an XFS problem.  You should be able to run xfs_repair
on your loopback file to fix the problem.

cheers.

-- 
Nathan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

