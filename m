Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268345AbUIMRU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268345AbUIMRU1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 13:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268317AbUIMRU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 13:20:26 -0400
Received: from verein.lst.de ([213.95.11.210]:42707 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268404AbUIMRTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 13:19:23 -0400
Date: Mon, 13 Sep 2004 19:19:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alex Zarochentsev <zam@namesys.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix reiser4 compilation for ->permission changes
Message-ID: <20040913171916.GA26997@lst.de>
References: <20040913140226.GA23510@lst.de> <20040913140440.GA23541@lst.de> <20040913170911.GB27411@backtop.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913170911.GB27411@backtop.namesys.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 09:09:11PM +0400, Alex Zarochentsev wrote:
> > ->permission is the only access checking method for filesystems,
> > everything else is supposed to happen through LSM which may use xattr
> > storage in the filesystem.
> 
> I think what reiser4 needs is exactly the fs-specific per-object permission
> check.   Is i_op->permission() going to be obsolete?   If not, ->permission()
> is the best (available) way to call reiser4 permission plugin methods.  

Currently there is no permission checking in reiser4 that's different
from generic_permission so don't set a ->permission.  If you ever have
more checking set it for those objects that want more checking instead
of such a useless indirection.
