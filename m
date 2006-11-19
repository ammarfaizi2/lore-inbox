Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933316AbWKSVP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933316AbWKSVP1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 16:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933318AbWKSVP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 16:15:27 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37271 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933316AbWKSVP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 16:15:26 -0500
Date: Sun, 19 Nov 2006 22:14:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-rt4, changed yum repository
Message-ID: <20061119211434.GA7538@elte.hu>
References: <20061118163032.GA14625@elte.hu> <200611191539.42023.fzu@wemgehoertderstaat.de> <20061119134301.GA2792@elte.hu> <200611192156.39981.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611192156.39981.fzu@wemgehoertderstaat.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0001]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:

>  Call Trace:
>   [<c02d320f>] do_page_fault+0x2b9/0x552
>   [<c0102f22>] work_resched+0x6/0x20

> The  [<c0102f22>] work_resched+0x6/0x20 corresponds to
> 	mov    $0xfffff000,%ebp

> 0x000001c1 <work_resched+1>:    call   0x1c2 <work_resched+2>
> 0x000001c6 <work_resched+6>:    mov    $0xfffff000,%ebp

no, it's the call's return address that is work_resched+6.

to get a more usable snapshot of what this task is doing you'd need 
something like SysRq-P output. (that works on PREEMPT_RT only if you 
enable /proc/sys/kernel/debug_direct_keyboard - but careful, it might 
break if you generate too many interrupts - i usually only to do the 
SysRq-P and hope that it doesnt break then.)

	Ingo
