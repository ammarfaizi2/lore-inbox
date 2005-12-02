Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbVLBS6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbVLBS6d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 13:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbVLBS6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 13:58:33 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:46501 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1750891AbVLBS6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 13:58:32 -0500
Date: Fri, 2 Dec 2005 11:58:05 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
Message-ID: <20051202185805.GS14509@schatzie.adilger.int>
Mail-Followup-To: Takashi Sato <sho@bsd.tnes.nec.co.jp>,
	Dave Kleikamp <shaggy@austin.ibm.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <01e901c5f66e$d4551b70$4168010a@bsd.tnes.nec.co.jp> <1133447539.8557.14.camel@kleikamp.austin.ibm.com> <041701c5f742$d6b0a450$4168010a@bsd.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <041701c5f742$d6b0a450$4168010a@bsd.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 02, 2005  22:18 +0900, Takashi Sato wrote:
> I also found another problem on generic quota code.  In
> dquot_transfer(), the file usage is calculated from i_blocks via
> inode_get_bytes().  If the file is over 2TB, the change of usage is
> less than expected.
> 
> To solve this problem, I think inode.i_blocks should be 8 byte.

Actually, it should probably be "sector_t", because it isn't really
possible to have a file with more blocks than the size of the block
device.  This avoids memory overhead for small systems that have no
need for it in a very highly-used struct.  It may be for some network
filesystems that support gigantic non-sparse files they would need to
enable CONFIG_LBD in order to get support for this.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

