Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268304AbUIMRRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268304AbUIMRRN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 13:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268404AbUIMRRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 13:17:12 -0400
Received: from clusterfw.beelinegprs.com ([217.118.66.232]:30838 "EHLO
	crimson.namesys.com") by vger.kernel.org with ESMTP id S268304AbUIMRRA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 13:17:00 -0400
Date: Mon, 13 Sep 2004 21:09:11 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix reiser4 compilation for ->permission changes
Message-ID: <20040913170911.GB27411@backtop.namesys.com>
References: <20040913140226.GA23510@lst.de> <20040913140440.GA23541@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913140440.GA23541@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 04:04:40PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 13, 2004 at 04:02:26PM +0200, Christoph Hellwig wrote:
> > remove reiser4 permission.  It only ends up calling generic_permission
> > with no additional bits so it's completely unessecary.
> 

> Actually not.  I'm lost in the CPP abuse in reiser4, sorry.  Could someone of
> the namesys folks please remove all the perm_plugin mess?

yes, if you mean that check_perm() macro.  

> ->permission is the only access checking method for filesystems,
> everything else is supposed to happen through LSM which may use xattr
> storage in the filesystem.

I think what reiser4 needs is exactly the fs-specific per-object permission
check.   Is i_op->permission() going to be obsolete?   If not, ->permission()
is the best (available) way to call reiser4 permission plugin methods.  

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Alex.
