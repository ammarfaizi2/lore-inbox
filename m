Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWFNKe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWFNKe1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 06:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWFNKe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 06:34:27 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:19408 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932285AbWFNKe0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 06:34:26 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17551.58643.704359.815153@gargle.gargle.HOWL>
Date: Wed, 14 Jun 2006 14:29:39 +0400
To: Nathan Scott <nathans@sgi.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
Newsgroups: gmane.linux.kernel
In-Reply-To: <20060614084155.C888012@wobbly.melbourne.sgi.com>
References: <20060613143230.A867599@wobbly.melbourne.sgi.com>
	<448EC51B.6040404@argo.co.il>
	<20060614084155.C888012@wobbly.melbourne.sgi.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott writes:
 > On Tue, Jun 13, 2006 at 05:00:59PM +0300, Avi Kivity wrote:
 > > Nathan Scott wrote:
 > > > Such a change would would indeed break XFS, in exactly the way you
 > 
 > Oh, I should clarify - the suggestion of using sb->s_blocksize/
 > s_blocksize_bits was what I meant by "would break XFS".
 > 
 > > > suggest Jan - the realtime subvolume does typically use a different
 > > > blocksize from the data subvolume (the realtime extent size is used,
 > > > and this can be set per-inode too), and there would now be no way to
 > > > distinguish this preferred IO size difference.
 > > 
 > > It can be made into an inode operation:
 > 
 > *nod* - that'd work fine for our needs here.

Sorry, but why this operation is needed? Generic code (in fs/*.c)
doesn't use ->i_blksize at all. If XFS wants to provide per-inode
st_blksize, all it has to do is to store preferred buffer size in its
file system specific inode (struct xfs_inode), and use something
different from generic_fillattr() as its ->i_op->getattr() callback
(xfs_vn_getattr()).

 > 
 > cheers.
 > 
 > -- 
 > Nathan

Nikita.
