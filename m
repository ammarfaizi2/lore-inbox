Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVJVK4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVJVK4e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 06:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVJVK4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 06:56:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25279 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932222AbVJVK4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 06:56:33 -0400
Date: Sat, 22 Oct 2005 11:56:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [EXPERIMENT,RFC] FAT: Add "flush" option for hotplug devices
Message-ID: <20051022105632.GA3027@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org
References: <871x2gf8f5.fsf@devron.myhome.or.jp> <20051022101552.GA2403@infradead.org> <87hdb9de44.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hdb9de44.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2005 at 07:45:31PM +0900, OGAWA Hirofumi wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> >> +++ linux-2.6.14-rc4-hirofumi/fs/fat/flush.c	2005-10-21 00:25:22.000000000 +0900
> >> @@ -0,0 +1,90 @@
> >> +/*
> >> + * Copyright (C) 2005, OGAWA Hirofumi
> >> + * Released under GPL v2.
> >> 
> > Except for placing the flush time in the msdosfs SB there is nothing
> > filesystem-specific in this file.  Please place it in generic code,
> > that way there's no reason to export all these deeply internal
> > symbols either.
> 
> OK, except filemap_write_and_wait().
> 
> Many filesystems does
> 
> 	filemap_fdatawrite(mapping);
> 	filemap_fdatawait(mapping);
> 
> Don't you want filemap_write_and_wait()?

Yes, that doesn't fall under the odd exports above.  Care to submit a patch to
export it (non-_GPL) and convert all users of the above pattern to it?

