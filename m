Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbTISEiy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 00:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbTISEiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 00:38:54 -0400
Received: from palrel13.hp.com ([156.153.255.238]:16877 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261271AbTISEiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 00:38:52 -0400
Date: Thu, 18 Sep 2003 21:38:47 -0700
From: Grant Grundler <iod00d@hp.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030919043847.GA2996@cup.hp.com>
References: <16234.33565.64383.838490@wombat.disy.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16234.33565.64383.838490@wombat.disy.cse.unsw.edu.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 02:16:29PM +1000, Peter Chubb wrote:
> The obvious approach of realigning the SKB by 2 bytes seems not to
> work.

Could you be more detailed about the "obvious approach"?
ie show the diff of what you changed.

Several other NIC driver "alias" (as davidm describes it) the buffer
by reserving two bytes at the beginning of the recieve buffer
where header and payload data are DMAd on inbound traffic.

I look to my favorite driver, tulip, for an example and promptly
get confused. interrupt.c:tulip_rx() calls skb_reserve(xx,2)
to force alignment when replenishing RX buffers while a note in
tulip_core.c:tulip_init_ring() clearly says not to. I haven't
looked further to figure out the difference.

hth,
grant
