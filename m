Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUEQUyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUEQUyj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 16:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUEQUyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 16:54:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:21979 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261851AbUEQUyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 16:54:37 -0400
Date: Mon, 17 May 2004 13:57:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@ucw.cz>
Cc: torvalds@osdl.org, mark.williamson@imperial.ac.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Quota fix 3 - quota file corruption
Message-Id: <20040517135709.031a9311.akpm@osdl.org>
In-Reply-To: <20040517161028.GB23294@atrey.karlin.mff.cuni.cz>
References: <20040517161028.GB23294@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@ucw.cz> wrote:
>
> +	memset(&empty, 0, sizeof(struct v2_disk_dqblk));
> +	if (!memcmp(&empty, &ddquot, sizeof(struct v2_disk_dqblk)))
> +		ddquot.dqb_itime = cpu_to_le64(1);

hm, OK.

Comparing structures for equality might not work right if the compiler
added internal padding.  However in this case the structure is six u32's
followed by a couple of u64's so it will work out right.  And it's an
on-disk thing so it won't be changing in a hurry.


