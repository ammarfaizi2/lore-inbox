Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270932AbUJVJ5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270932AbUJVJ5n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 05:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270930AbUJVJ5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 05:57:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:62896 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270942AbUJVJzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 05:55:48 -0400
Date: Fri, 22 Oct 2004 02:53:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: blaisorblade_spam@yahoo.it
Cc: agk@redhat.com, neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org,
       blaisorblade_spam@yahoo.it
Subject: Re: [patch 1/1] dm: fix printk errors about whether %lu/%Lu is
 right for sector_t - revised
Message-Id: <20041022025340.058837f7.akpm@osdl.org>
In-Reply-To: <20041021224554.402233F37@zion.localdomain>
References: <20041021224554.402233F37@zion.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade_spam@yahoo.it wrote:
>
> The Device Manager code barfs when sector_t is 64bit wide (i.e. an u64) and
>  CONFIG_LBD is off. This happens on printk(), resulting in wrong memory
>  accesses, but also on sscanf(), resulting in overflows (because it uses %lu
>  for a long long in this case). And region_t, chunk_t are typedefs for
>  sector_t, so we have warnings for these, too.

This patch caused the x86_64 build to puke: "Not allowed to define
CONFIG_LBD on this architecture" or some such.

I'd much prefer that you simply remove SECTOR_FORMAT completely.
