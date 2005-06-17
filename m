Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVFQLM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVFQLM5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 07:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVFQLM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 07:12:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15554 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261947AbVFQLMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 07:12:55 -0400
Date: Fri, 17 Jun 2005 13:08:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050617110851.GA26500@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com> <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com> <20050616173247.GA32552@elte.hu> <42B1BDF7.1000700@cybsft.com> <42B1E316.2040406@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B1E316.2040406@cybsft.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> Just had an opportunity to check this. Everything does indeed seem to 
> be working OK with this disabled. No lock up messages, no perceived 
> problems.

btw., you have this enabled in your config:

   CONFIG_DEBUG_RT_LOCKING_MODE=y

this causes old-style spinlocking to be activated by default. I.e. you 
dont get most of the benefits of PREEMPT_RT. You can reactivate it via:

	echo 1 > /proc/sys/kernel/preempt_locks

but obviously this runtime flag involves some runtime overhead in the 
locking code. This .config option is mainly meant to enable the 
measurement of the locking overhead of PREEMPT_RT, and to debug boot 
problems that might be related to PREEMPT_RT locking.  So you'd almost 
always want to run with DEBUG_RT_LOCKING_MODE turned off.

	Ingo
