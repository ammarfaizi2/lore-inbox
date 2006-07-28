Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWG1Nd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWG1Nd2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWG1Nd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:33:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48580 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030264AbWG1Nd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:33:27 -0400
Date: Fri, 28 Jul 2006 14:33:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 000 of 2] knfsd: Don't allow bad file handles to cause extX to go readonly
Message-ID: <20060728133321.GA439@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	NeilBrown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
	nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20060728102713.15132.patches@notabene>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728102713.15132.patches@notabene>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 10:31:20AM +1000, NeilBrown wrote:
> Currently, and file handle with a bad inode number in it can cause
> ext2 to go to readonly (as it looks like a corrupted filesystem)
> and could allow remote access to ext3 special files like the journal.
> 
> These patches give ext2/3 their own get_dentry method which checks the
> inode number early before other bits of the code can be freaked out by
> it.
> 
> These are revised versions of earlier patches.  Rather than exporting
> export_iget, we open code it and simplify it slightly.  This avoids
> and extra module dependancy.

This looks much better, agreed.  Long-term we should switch ext2/ext2
to use iget_locked so we can propagate errors in finding the inode much
better.

