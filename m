Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUHWUGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUHWUGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUHWUEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:04:44 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:33800 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266670AbUHWSts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:49:48 -0400
Date: Mon, 23 Aug 2004 19:49:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/7] xattr consolidation - libfs
Message-ID: <20040823194936.A20008@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org
References: <Xine.LNX.4.44.0408231408030.13728-100000@thoron.boston.redhat.com> <Xine.LNX.4.44.0408231414270.13728-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Xine.LNX.4.44.0408231414270.13728-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Mon, Aug 23, 2004 at 02:15:15PM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 02:15:15PM -0400, James Morris wrote:
> This patch consolidates common xattr handling logic into libfs, for
> use by ext2, ext3 and devpts, as well as upcoming ramfs and tmpfs xattr code.

Please don't do it this way.  By making the xattr handlers constant for
a superblock's lifetime you can get rid of all the locking, and the arbitrary
limit on the number of xattrs.  Please also move the code to xattr.c where
it belong (long-term I'd like to kill the old inode ops so we can do things
like moving the permission checks for user xattrs into common code where they
belong)

Also s/simple_// for most symbols as this stuff isn't simple, in fact it's
quite complex :)

