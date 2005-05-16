Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVEPJe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVEPJe3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 05:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVEPJe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 05:34:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56743 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261525AbVEPJeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 05:34:11 -0400
Date: Mon, 16 May 2005 10:34:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
Message-ID: <20050516093408.GA20696@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
References: <4272A275.4030801@austin.rr.com> <20050429213108.GA15262@infradead.org> <4272B335.5090207@austin.rr.com> <20050511085619.GA24841@infradead.org> <42824CA7.9040201@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42824CA7.9040201@austin.rr.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 01:19:19PM -0500, Steve French wrote:
> OK - why don't we just add this (ie the ioctl removal) to the patch
> 
> [PATCH] unprivileged mount/umount
> 
> of Miklos et al, since that removes the need to modify showmounts (and 
> avoids any name collision/confusion
> with the existing meaning of the mount option "uid" ie as the default 
> uid to use for files on the system when
> mounting to servers which can not return inode owners as uids).

I think that would be best.  It still needs a little work first.

> On another topic relating to ioctls, various people have suggested 
> adding an ioctl to add a table to optionally map file owner (uid / gid 
> mapping tables) on remote filesystems. Although this is easy enough to 
> do for the case of CIFS, this seems like a function (loading the table) 
> that could be done via /proc or perhaps even sysfs. Is there are 
> precedent for doing this on Linux?

I don't think that mapping should happen in kernelspace.  It would
be nice if you could share that with nfs, maybe even generalizing the
nfsv4 one.

