Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266590AbUGKVwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266590AbUGKVwE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 17:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266566AbUGKVwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 17:52:04 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:53774 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S266590AbUGKVwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 17:52:01 -0400
Date: Sun, 11 Jul 2004 23:54:46 +0200
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040711215446.GA21443@hh.idb.hist.no>
References: <20040710184357.GA5014@taniwha.stupidest.org> <E1BjPL3-00076U-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BjPL3-00076U-00@calista.eckenfels.6bone.ka-ip.net>
User-Agent: Mutt/1.5.6+20040523i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 11:24:53PM +0200, Bernd Eckenfels wrote:
> In article <20040710184357.GA5014@taniwha.stupidest.org> you wrote:
> > No, that's not the case.  Normally when files are written the data
> > isn't not flushed immediately, it sits in memory (the page-cache) for
> > some (usually) small amount of time.
> 
> Does that mean, that closing a tempfile and then renaming  the file is not 
> a reliable way to tell, that the data  is persited? I usually use a atomic
> rename to have a point from which on I can tell if the data is complete
> and persisted.
> 
> I thought close() has  fsync() semantics?
> 
No, it doesn't.

close() will flush the C library buffer.  That means the data
moves from theose buffers to the pagacache. The program crashing
after that will have no effect on the file.  It can still
be lost if the _kernel_ crashes though.
If you want the pagecache flushed to disk, use fsync (or sync)

Helge Hafting
