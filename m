Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbUJYVnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbUJYVnk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbUJYVnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:43:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:62871 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261267AbUJYVmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 17:42:36 -0400
Date: Mon, 25 Oct 2004 14:46:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: agk@redhat.com, neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] dm: fix printk errors about whether %lu/%Lu is
 right for sector_t - revised
Message-Id: <20041025144628.5944df19.akpm@osdl.org>
In-Reply-To: <200410252255.08217.blaisorblade_spam@yahoo.it>
References: <20041021224554.402233F37@zion.localdomain>
	<20041022025340.058837f7.akpm@osdl.org>
	<200410252255.08217.blaisorblade_spam@yahoo.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
>
> > I'd much prefer that you simply remove SECTOR_FORMAT completely.
> 
> Impossible - doing a scanf and then copying the value is much uglier.

Put this in ll_rw_blk.c:

/*
 * Parse an ascii decimal number into a sector_t.  Return 1 on success
 */
int str_to_sector_t(const char *str, sector_t *sector)
{
	unsigned long long val;
	int ret;

	ret = sscanf(str, "%llu", &val);
	if (ret == 1)
		*sector = val;
	return ret;
}
EXPORT_SYMBOL(str_to_sector_t);

