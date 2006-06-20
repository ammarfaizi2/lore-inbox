Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWFTQZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWFTQZm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWFTQZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:25:41 -0400
Received: from mx1.mail.ru ([194.67.23.121]:52832 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1751389AbWFTQZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:25:14 -0400
Date: Tue, 20 Jun 2006 20:30:45 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5]: ufs: missed brelse and wrong baseblk
Message-ID: <20060620163045.GA17903@rain.homenetwork>
Mail-Followup-To: Al Viro <viro@ftp.linux.org.uk>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20060617101403.GA22098@rain.homenetwork> <20060618162054.GW27946@ftp.linux.org.uk> <20060618175045.GX27946@ftp.linux.org.uk> <20060619064721.GA6106@rain.homenetwork> <20060619073229.GI27946@ftp.linux.org.uk> <20060619131750.GA14770@rain.homenetwork> <20060619182833.GJ27946@ftp.linux.org.uk> <20060619185816.GA26513@rain.homenetwork> <20060619191306.GK27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619191306.GK27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 08:13:06PM +0100, Al Viro wrote:
> Which is fsck-all protection, since then you proceed to do a lot of
> blocking operations.  Now, lock_super() down in balloc.c _might_ be
> enough, but I wouldn't bet on that.

There is still leak of proper locking model for inode's metadata,
for example we don't lock/unlock buffer_head when check if 
we've already allocated block or not,
so lock_kernel still necessary.

-- 
/Evgeniy

