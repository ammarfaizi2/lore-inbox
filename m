Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUG1NDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUG1NDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 09:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266908AbUG1NDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 09:03:09 -0400
Received: from cantor.suse.de ([195.135.220.2]:55956 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266905AbUG1NDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 09:03:07 -0400
Subject: Re: writepages drops bh on not uptodate page
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040728045156.GH15895@dualathlon.random>
References: <20040728045156.GH15895@dualathlon.random>
Content-Type: text/plain
Message-Id: <1091019818.6333.84.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 09:03:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 00:51, Andrea Arcangeli wrote:
> Hi Andrew,
> 
> I think I understood why some ext2 fs corruption still happens even
> after the last i_size fix.
> 
> what happened I believe is that the writepages layer got a not a fully
> uptodate page (in turn with bh mapped on top of it), and then right
> before unlocking the page and entering the writeback mode, it freed all
> the bh. 

Ahhhh, this really explains it, thanks andrea.  I agree your fix should
solve things, but I'm wondering if we shouldn't make readpage[s] do a
wait_on_page_writeback().  That might do a better job of protecting us
from future variations of this problem.

-chris


