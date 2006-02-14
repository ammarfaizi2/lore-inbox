Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWBNAA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWBNAA6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbWBNAA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:00:58 -0500
Received: from smtp1.ist.utl.pt ([193.136.128.21]:62087 "EHLO smtp1.ist.utl.pt")
	by vger.kernel.org with ESMTP id S1030319AbWBNAA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:00:57 -0500
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: Mark Fasheh <mark.fasheh@oracle.com>
Subject: Re: OCFS2 Filesystem inconsistency across nodes
Date: Tue, 14 Feb 2006 00:00:48 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Jan Kara <jack@suse.cz>
References: <200602100536.02893.ctpm@rnl.ist.utl.pt> <200602110540.57573.ctpm@rnl.ist.utl.pt> <20060213222606.GC20175@ca-server1.us.oracle.com>
In-Reply-To: <20060213222606.GC20175@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602140000.48593.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday 13 February 2006 22:26, Mark Fasheh wrote:
> On Sat, Feb 11, 2006 at 05:40:57AM +0000, Claudio Martins wrote:
> > This is my /etc/ocfs2/cluster.conf on every node:
>
> Hi Claudio,
> 	Thanks for sending me your config files. Everything seems in order.
> I was easily able to reproduce your problem on my cluster and was able to
> git-bisect my way to some JBD changes which seem to be causing the issue.
> Reverting those patches fixes things. Can you apply the attached patch and
> confirm that it also fixes this particular problem for you? You'll have to
> apply to all kernels in your cluster and either run fsck.ocfs2 or create a
> new file system before testing again.

 Hi Mark,

 I'll apply the patch and rebuild my kernels and filesystem. Will be reporting 
the results ASAP.

Thanks

Claudio

>
> Linus, Andrew, Jan,
> 	OCFS2 uses journal_flush() to sync metadata out to disk when another
> node wants to obtain a lock on an inode which has pending journaled
> changes. Something in Jan Kara's patch titled "jbd: split checkpoint lists"
> broke this for OCFS2 (and I suspect for other users of JBD as well). As a
> result metadata is not always completely flushed to disk by the end of the
> journal_flush() call.

