Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269132AbUINCTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269132AbUINCTn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269121AbUINCRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:17:42 -0400
Received: from holomorphy.com ([207.189.100.168]:656 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269132AbUINCPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:15:03 -0400
Date: Mon, 13 Sep 2004 19:14:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for fsync ignoring writing errors
Message-ID: <20040914021456.GL9106@holomorphy.com>
References: <20040913161255.A18665@castle.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913161255.A18665@castle.nmd.msu.ru>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 04:12:55PM +0400, Andrey Savochkin wrote:
> AFACS, currently metadata writing errors are ignored and not returned from
> sys_fsync on ext2 and ext3 filesystems.
> That is, at least ext2 and ext3.
> Both ext2 and ext3 resort to sync_inode() in their ->sync_inode method, which
> in turn calls ->write_inode.  ->write_inode method has void type, and any IO
> errors happening inside are lost.
> Any objections to making ->write_inode return the error code?
> Signed-off-by: Andrey Savochkin <saw@saw.sw.com.sg>

While I've not reviewed this in any detail I'm very much in favor of
propagating any and all errors to fsync(), particular for the benefit
of userspace applications responsible for maintaining data integrity.


-- wli
