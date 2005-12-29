Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbVL2JMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbVL2JMK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 04:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbVL2JMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 04:12:10 -0500
Received: from fmr20.intel.com ([134.134.136.19]:59317 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S965122AbVL2JMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 04:12:09 -0500
Subject: Re: [PATCH] ipw2200 stack reduction
From: Zhu Yi <yi.zhu@intel.com>
To: Jens Axboe <axboe@suse.de>
Cc: jketreno@linux.intel.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051228212934.GA2772@suse.de>
References: <20051228212934.GA2772@suse.de>
Content-Type: text/plain
Organization: Intel Corp.
Date: Thu, 29 Dec 2005 17:07:08 +0800
Message-Id: <1135847228.9670.69.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-28 at 22:29 +0100, Jens Axboe wrote:
> The reason is the host_cmd structure is large (500 bytes). All other
> functions currently using ipw_send_cmd() suffer from the same problem.
> This patch introduces ipw_send_cmd_simple() for commands with no data
> transfer, and ipw_send_cmd_pdu() for commands with a data payload.

Hi Jens,

Thanks for point this out and provide the patch. One comment:

> +static struct host_cmd *ipw_host_cmd_get(u8 command, u8 len)
>  {
> ...
> +       cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);

This will still alloc 500 bytes for each command. I think if we want to
dynamically alloc the struct, we can split the struct to head and
payload and alloc the payload according to the real size.

Thanks,
-yi

