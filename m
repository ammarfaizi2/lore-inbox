Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVCGPQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVCGPQe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 10:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVCGPQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 10:16:34 -0500
Received: from extgw-uk.mips.com ([62.254.210.129]:12560 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261343AbVCGPQb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 10:16:31 -0500
Date: Mon, 7 Mar 2005 14:19:57 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: jarmo <oh1mrr@nic.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ax25 t1_timeout
Message-ID: <20050307141957.GB8466@linux-mips.org>
References: <200503061158.11446.oh1mrr@nic.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503061158.11446.oh1mrr@nic.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 11:58:11AM +0200, jarmo wrote:

> Withs kernel 2.6.11 ax25 t1_timeout is working badly...
> Expl. I have set t1_timeout to 10s (10000).Now testing..
> Taking radio of,set connection to somewhere,first try then
> 10s time second try...But then 20s and try next 30s and try...
> So t1_timeout is increasing?In 2.6.10 timeout is 10 and
> it does not increase...Possible bug?

No, pilot error ;-)

Linux supports three different backoff types which can be configured via
/proc or sysctl.  This is how to display the backoff type of interface
sp0, for example:

  [root@dl5rb] sysctl net.ax25.sp0.backoff_type
  net.ax25.sp0.backoff_type = 1
  [root@dl5rb]

1 in this example stands for linear backoff which is the default and what
you've been observing.  0 would be no backoff which generally in a shared
RF environment is probably unfriendly and can mathematically be shown to
cause network meltdowns.  Finally 2 would means exponential backoff,
which would use t1, 2*t1, 4*t1, 8*t1 for the waiting time, but never goes
worse than 8 * t1.

You can change the value with sysctl also but generally linear backoff is
quite reasonable.

73 de DL5RB op Ralf

--
Loc. JN47BS / CQ 14 / ITU 28 / DOK A21
