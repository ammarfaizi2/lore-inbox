Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUHPE43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUHPE43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 00:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267432AbUHPE43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 00:56:29 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49079 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267431AbUHPE41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 00:56:27 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P1
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816043302.GA14979@elte.hu>
References: <1092622121.867.109.camel@krustophenia.net>
	 <20040816023655.GA8746@elte.hu> <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092630122.810.25.camel@krustophenia.net>
	 <20040816043302.GA14979@elte.hu>
Content-Type: text/plain
Message-Id: <1092632236.801.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 00:57:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 00:33, Ingo Molnar wrote:
> there's no mdio_delay() in via-rhine.c AFAICS. Could you add a pair of
> touch-latency calls to around this code in mdio_read():
> 
> +       touch_preempt_timing();
>         /* Wait for a previous command to complete. */
>         while ((readb(ioaddr + MIICmd) & 0x60) && --boguscnt > 0)
> +       touch_preempt_timing();
> 
> i suspect it's this one that introduces the biggest delay. Also:
> 
> +	touch_preempt_timing();
>         while ((readb(ioaddr + MIICmd) & 0x40) && --boguscnt > 0)
>                 ;
> +	touch_preempt_timing();
> 
> assuming that the latencies still show up even if delimited like this. 
> (note that this only changes the way the latency is tracked - the
> latency itself is still there so this isnt a fix.)
> 

Sure, but, what would this accomplish, if the latency is still there? 
Are we just trying to track down exactly where in the network driver
this is triggered?

Lee

