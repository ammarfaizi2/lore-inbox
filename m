Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbUCJRa1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 12:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUCJRa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 12:30:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54671 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262743AbUCJRaN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 12:30:13 -0500
Message-ID: <404F5097.4040406@pobox.com>
Date: Wed, 10 Mar 2004 12:29:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Christoph Hellwig <hch@infradead.org>, prism54-devel@prism54.org,
       "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Intersil Prism54 wireless driver
References: <20040304023524.GA19453@bougret.hpl.hp.com> <20040310165548.A24693@infradead.org> <20040310172114.GA8867@bougret.hpl.hp.com>
In-Reply-To: <20040310172114.GA8867@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> On Wed, Mar 10, 2004 at 04:55:48PM +0000, Christoph Hellwig wrote:
>>+MODULE_PARM(init_mode, "i");
>>+MODULE_PARM_DESC(init_mode,
>>+		 "Set card mode:\n0: Auto\n1: Ad-Hoc\n2: Managed Client (Default)\n3: Master / Access Point\n4: Repeater (Not supported yet)\n5: Secondary (Not supported yet)\n6: Monitor");
>>
>>	Please use module_param
> 
> 
> 	I would even say that this is useless because the driver
> support WE, and WE scripts set the mode before the card is up.

module_param() is a type-safe interface roughly identical to 
MODULE_PARM().  Therefore, if MODULE_PARM() works, module_param() works 
also.


>>diff -Naur -X /home/mcgrof/lib/dontdiff linux-2.6.3/drivers/net/wireless/prism54/isl_wds.c linux-2.6.3-prism54/drivers/net/wireless/prism54/isl_wds.c
>>--- linux-2.6.3/drivers/net/wireless/prism54/isl_wds.c	Thu Jan  1 00:00:00 1970
>>+++ linux-2.6.3-prism54/drivers/net/wireless/prism54/isl_wds.c	Thu Mar  4 02:00:01 2004
>>
>>	WDS doesn't belong into a driver but in higher-level code.
> 
> 
> 	The big 802.11 reorg can only happen when HostAP is in the
> kernel.

ISTR it needed some cleaning up before it could go in.

Further, in Linux, there is _never_ a requirement that "this driver be 
included before we can clean up."  You can start the re-org any time you 
wish.  Out-of-tree maintainers can follow the re-org, sometimes more easily.

	Jeff



P.S. I still need to look at your netlink thing.  Seems like a decent 
direction.

