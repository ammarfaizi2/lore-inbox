Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422628AbVKZPEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422628AbVKZPEK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 10:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422633AbVKZPEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 10:04:10 -0500
Received: from mx02.stofanet.dk ([212.10.10.12]:55452 "EHLO mx02.stofanet.dk")
	by vger.kernel.org with ESMTP id S1422628AbVKZPEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 10:04:09 -0500
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] warn-on-once.patch
Date: Sat, 26 Nov 2005 16:03:37 +0100
User-Agent: KMail/1.8.3
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com> <20051122013522.18537.97944.sendpatchset@cog.beaverton.ibm.com> <20051126145216.GB12999@elte.hu>
In-Reply-To: <20051126145216.GB12999@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511261603.38661.xschmi00@stud.feec.vutbr.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 26. of November 2005 15:52 Ingo Molnar wrote:
> - introduce WARN_ON_ONCE(cond)
> [...]
> +#define WARN_ON_ONCE(condition)		\
> +do {					\
> +	static int warn_once = 1;	\
> +					\
> +	if (condition) {		\
> +		warn_once = 0;		\
> +		WARN_ON(1);		\
> +	}				\
> +} while (0);
> +
>  #endif

That can't be right. The variable warn_once is only written to. Should the 
condition be: if (condition && warn_once)  ?
Or even better with inverted logic (so that the variable is initialized to 0):

static int warned_once;
if (condition && !warned_once) {
	warned_once = 1;
	WARN_ON(1);
}


Michal
