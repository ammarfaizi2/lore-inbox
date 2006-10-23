Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751883AbWJWKd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbWJWKd6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 06:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWJWKd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 06:33:58 -0400
Received: from stinky.trash.net ([213.144.137.162]:55426 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751883AbWJWKd5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 06:33:57 -0400
Message-ID: <453C9A91.90203@trash.net>
Date: Mon, 23 Oct 2006 12:33:53 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: jeff@garzik.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] sata_sis: fix flags handling for the secondary port
References: <453A3F0C.3000406@trash.net> <20061023034821.GI13677@htj.dyndns.org>
In-Reply-To: <20061023034821.GI13677@htj.dyndns.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> sis_init_one() modifies probe_ent->port_flags after allocating and
> initializing it using ata_pci_init_native_mode().  This makes
> port_flags for the secondary port (probe_ent->pinfo2->flags) go out of
> sync resulting in misdetection of device due to incorrectly
> initialized SCR access flag.
> 
> This patch make probe_ent alloc/init happen after the final port flags
> value is determined.  This is fragile but probe_ent and all the
> related mess are scheduled to go away soon for exactly this reason.
> We just need to hold everything together till then.
> 
> This has been spotted and diagnosed by Patrick McHardy.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Patric McHardy <kaber@trash.net>
> ---
> Patrick, can you test this patch and post result?


The patch fixes the problem, both ports are properly detected and work
fine. Thanks Tejun.

