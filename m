Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTIAT6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 15:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263247AbTIAT6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 15:58:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:13473 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263250AbTIAT6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 15:58:17 -0400
Date: Mon, 1 Sep 2003 12:58:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [BUG] mtime&ctime updated when it should not
Message-Id: <20030901125830.6f8d8f04.akpm@osdl.org>
In-Reply-To: <20030901193128.GA26983@atrey.karlin.mff.cuni.cz>
References: <20030901181113.GA15672@atrey.karlin.mff.cuni.cz>
	<20030901121807.29119055.akpm@osdl.org>
	<20030901193128.GA26983@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> wrote:
>
>  > Isn't this sufficient?
>    I think it is not (I tried exactly the same patch but it didn't work)
>  - the problem is that vmtruncate() is called when prepare_write() fails
>  and this function also updates mtime and ctime.

Oh OK.

So we would need to change each filesystem's ->truncate to not update the
inode times, then move the timestamp updating up into vmtruncate().

