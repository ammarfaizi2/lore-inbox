Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265872AbUHPIIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265872AbUHPIIK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 04:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267480AbUHPIIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 04:08:10 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:27839 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S265872AbUHPIIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 04:08:05 -0400
Date: Mon, 16 Aug 2004 10:07:45 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040816080745.GA18406@k3.hellgate.ch>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Florian Schmidt <mista.tapas@gmx.net>
References: <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu> <1092612264.867.9.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092612264.867.9.camel@krustophenia.net>
X-Operating-System: Linux 2.6.8-rc3-mm1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004 19:24:24 -0400, Lee Revell wrote:
>  0.000ms (+0.000ms): rhine_check_duplex (rhine_timer)
>  0.000ms (+0.000ms): mdio_read (rhine_check_duplex)
>  0.067ms (+0.067ms): mdio_read (rhine_timer)
>  0.139ms (+0.071ms): check_preempt_timing (sub_preempt_count)
> 
> This looks like the exact same problem Florian had, in his case it was 
> the sis900 driver.  Your recommendation was:
> 
>         #define mdio_delay() do { } while (0)
> 
> Should I try this?

If you want to try it, you are looking for IOSYNC (not medio_delay)
in this driver. However, doing this can break write ordering and thus
any driver you are treating that way.

> Also, isn't there a better solution than for network drivers to actively 
> poll for changes in link status?  Can't they just register a callback that 

For the Rhine, there is, but making it work requires some extra black
magic we didn't know until a few months ago. It's fixed in -mm now and
will probably be in 2.6.9. That doesn't mean the media_check is gone,
though. It just means it only happens on actual events.

Roger
