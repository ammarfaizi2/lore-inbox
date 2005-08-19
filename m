Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbVHSP4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVHSP4F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 11:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVHSP4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 11:56:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34257 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751191AbVHSP4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 11:56:02 -0400
Date: Fri, 19 Aug 2005 16:58:58 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: vandrove@vc.cvut.cz, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and mmap
Message-ID: <20050819155858.GB29811@parcelfarce.linux.theplanet.co.uk>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk> <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk> <1124466246.2294.65.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124466246.2294.65.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 04:44:06PM +0100, Anton Altaparmakov wrote:
> I tried stracing nautilus to answer your question.  And this time for
> the first time instead of a Bad page state I got a BUG() triggered in
> fs/namei.c, the arrow below marks the spot:
> 
> void page_put_link(struct dentry *dentry, struct nameidata *nd)
> {
> 	if (!IS_ERR(nd_get_link(nd))) {
> 		struct page *page;
> 		page = find_get_page(dentry->d_inode->i_mapping, 0);
> 		if (!page)
> ---->			BUG();

Ergo, something had blown page cache for our inode.  Interesting...
