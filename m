Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293713AbSCSFGT>; Tue, 19 Mar 2002 00:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293717AbSCSFGK>; Tue, 19 Mar 2002 00:06:10 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:12020 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S293713AbSCSFF6>; Tue, 19 Mar 2002 00:05:58 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 18 Mar 2002 18:34:53 -0700
To: Paul Allen <allenp@nwlink.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ext2 zeros inode in directory entry when deleting files.
Message-ID: <20020319013453.GC470@turbolinux.com>
Mail-Followup-To: Paul Allen <allenp@nwlink.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020317131702.A16140@mark.mielke.cc> <Pine.LNX.4.44.0203171516540.21552-100000@waste.org> <20020317185356.C16140@mark.mielke.cc> <3C968B38.4070405@nwlink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 18, 2002  16:50 -0800, Paul Allen wrote:
> Perhaps you can imagine the trepidation with which I put
> forth the following fact:

Yes, it is always tough when you dip your toes into new waters.
In this case I think you may have something.  There is always
the chance that Al will still pipe in with "not doing that can
be exploited as a race condition by doing X, Y, and Z".

> With 2.4.6, the ext2_delete_entry() function moved from
> fs/ext2/namei.c to fs/ext2/dir.c and its behavior changed.
> Now, the inode number is always zeroed.

You could always just put an "else" in front of the zeroing, so
it looks like:

	if (pde)
                pde->rec_len = cpu_to_le16(to-from);
	else
		dir->inode = 0;

Let us know how it turns out (I think it will be OK).

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

