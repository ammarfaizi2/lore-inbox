Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVC1R0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVC1R0P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVC1R0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:26:15 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:24072 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261961AbVC1R0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:26:03 -0500
Date: Mon, 28 Mar 2005 19:25:58 +0200
From: Willy Tarreau <willy@w.ods.org>
To: vherva@viasys.com
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems
Message-ID: <20050328172558.GU30052@alpha.home.local>
References: <20050326162801.GA20729@logos.cnet> <20050328073405.GQ16169@viasys.com> <20050328165501.GR16169@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050328165501.GR16169@viasys.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ville,

On Mon, Mar 28, 2005 at 07:55:01PM +0300, Ville Herva wrote:
(...) 
> I rebooted (fsck took the fs errors away, no big offenders), and after a few
> minutes, I got the same error ("journal commit I/O error"). So it doesn't
> appear all that random memory corruption. The error happened right when I
> logged out, but that might have been a coincidence. No ide nor md errors
> this time either. 
> 
> I don't know what to suspect. What I gather from changelogs, there haven't
> been any critical looking ext3 changes in 2.4 lately, but then again,
> vserver doesn't mess with block layer / ext3 journalling either.
> 
> Any ideas?

Since you don't seem to be willing to remove vserver, I guess you really
need it on this machine, and to be honnest, I too don't see what trouble
it could cause in this area. However, could you try removing the journal,
or simply mount the FS as ext2 ? It would help to narrow the problem down.

To resume, you have your root on ext3 on top of soft raid1 consisting in
two IDE disks, which works in 2.4.21 but not on 2.4.30-rc3, that's
correct ? There was a fix last week by Neil Brown about RAID1 rebuild
process (degraded array of 3 disks, etc...), unless it obviously does
not come from there, you might want to try reverting it first ? The
next one is from Doug Ledford on 2004/09/18 and should only affect SMP.

My different raid machines run either reiserfs or xfs on soft raid5 on
top of scsi and with kernel 2.4.27, so there's not much to compare...
Perhaps someone on the list has a setup similar to yours and could test
the kernel ?

Cheers,
Willy

