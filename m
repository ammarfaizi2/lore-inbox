Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbVAVDcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbVAVDcX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 22:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVAVDcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 22:32:23 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44598
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262657AbVAVDcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 22:32:19 -0500
Date: Sat, 22 Jan 2005 04:32:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Edjard Souza Mota <edjard@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: User space out of memory approach
Message-ID: <20050122033219.GG11112@dualathlon.random>
References: <3f250c71050110134337c08ef0@mail.gmail.com> <20050110192012.GA18531@logos.cnet> <4d6522b9050110144017d0c075@mail.gmail.com> <20050110200514.GA18796@logos.cnet> <1105403747.17853.48.camel@tglx.tec.linutronix.de> <20050111083837.GE26799@dualathlon.random> <3f250c71050121132713a145e3@mail.gmail.com> <3f250c7105012113455e986ca8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f250c7105012113455e986ca8@mail.gmail.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 05:45:13PM -0400, Mauricio Lin wrote:
> Hi Andrew,
> 
> I have another question. You included an oom_adj entry in /proc for
> each process. This was the approach you used in order to allow someone
> or something to interfere the ranking algorithm from userland, right?
> So if i have an another ranking algorithm in user space, I can use it
> to complement the kernel decision as necessary. Was it your idea?

Yes, you should use your userspace algorithm to tune the oom killer via
the oom_adj and you can check the effect of your changes with oom_score.
I posted a one liner ugly script to do that a few days ago on l-k.

The oom_adj has this effect on the badness() code:

	/* 
	 * Adjust the score by oomkilladj.
	 */
	if (p->oomkilladj) {
		if (p->oomkilladj > 0)
			points <<= p->oomkilladj;
		else
			points >>= -(p->oomkilladj);
	}

The biggest the points become, the more likely the task will be choosen
by the oom killer.
