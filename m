Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161315AbWHEM0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161315AbWHEM0v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 08:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161313AbWHEM0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 08:26:51 -0400
Received: from verein.lst.de ([213.95.11.210]:35204 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1161312AbWHEM0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 08:26:50 -0400
Date: Sat, 5 Aug 2006 14:25:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Jesse Barnes <jesse.barnes@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, Chris Wedgwood <cw@f00f.org>,
       jsipek@cs.sunysb.edu, Al Viro <viro@ftp.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC] [PATCH] Relative lazy atime
Message-ID: <20060805122537.GA23239@lst.de>
References: <20060803063622.GB8631@goober>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803063622.GB8631@goober>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -0.6 () BAYES_01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 11:36:22PM -0700, Valerie Henson wrote:
> (Corrected Chris Wedgwood's name and email.)
> 
> My friend Akkana followed my advice to use noatime on one of her
> machines, but discovered that mutt was unusable because it always
> thought that new messages had arrived since the last time it had
> checked a folder (mbox format).  I thought this was a bummer, so I
> wrote a "relative lazy atime" patch which only updates the atime if
> the old atime was less than the ctime or mtime.  This is not the same
> as the lazy atime patch of yore[1], which maintained a list of inodes
> with dirty atimes and wrote them out on unmount.

Another idea, similar to how atime updates work in xfs currently might
be interesting:  Always update atime in core, but don't start a
transaction just for it - instead only flush it when you'd do it anyway,
that is another transaction or evicting the inode.

