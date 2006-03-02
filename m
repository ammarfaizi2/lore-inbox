Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWCBNp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWCBNp2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 08:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWCBNp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 08:45:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:53650 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751043AbWCBNp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 08:45:27 -0500
From: Chris Mason <mason@suse.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: o_sync in vfat driver
Date: Thu, 2 Mar 2006 08:45:08 -0500
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, col-pepper@piments.com,
       linux-kernel@vger.kernel.org
References: <op.s5lrw0hrj68xd1@mail.piments.com> <200603011023.38229.mason@suse.com> <87mzg9wst0.fsf@duaron.myhome.or.jp>
In-Reply-To: <87mzg9wst0.fsf@duaron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603020845.10083.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 20:15, OGAWA Hirofumi wrote:

> > Just to make sure we're using the same terms, do you mean the pages are
> > marked dirty and on the SB's dirty list, or do you mean the page has been
> > through writepage and is currently on its way to the disk?
>
> The page is already on device's request queue, and the page is already
> marked a PG_writeback. And that page is not processed by device yet.
>
> Then, you call next filemap_fdatawrite(), it just re-dirty the page
> and queues to sb->s_dirty, because the page's buffer_heads is still
> locked.  So, the re-dirtyed page is re-submited to device by
> periodically wb_kupdate()?

filemap_fdatawrite() won't redirty the page.  It will wait on the pending 
writeback.

-chris
