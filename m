Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266469AbRGYClw>; Tue, 24 Jul 2001 22:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266479AbRGYClm>; Tue, 24 Jul 2001 22:41:42 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:53134 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S266469AbRGYClY>; Tue, 24 Jul 2001 22:41:24 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Evan Parker <nave@stanford.edu>
Date: Wed, 25 Jul 2001 10:51:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15198.6168.575948.489641@notabene.cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>, <mc@cs.stanford.edu>
Subject: Re: [CHECKER] repetitive/contradictory comparison bugs for 2.4.7
In-Reply-To: message from Evan Parker on Tuesday July 24
In-Reply-To: <Pine.GSO.4.31.0107241704430.11742-100000@myth10.Stanford.EDU>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tuesday July 24, nave@stanford.edu wrote:
> [BUG] confusing: why check twice? race condition?
> /home/eparker/tmp/linux/2.4.7/drivers/md/md.c:1633:do_md_run: ERROR:INTERNAL_NULL3:1627:1633: Repetitive check: "pers[pnum]" is NULL so the conditional "pers[pnum] == 0" will always evaluate to true! [distance=4]
> 		 */
> 		printk(BAD_CHUNKSIZE);
> 		return -EINVAL;
> 	}
> 
> Start --->
> 	if (!pers[pnum])
> 	{
> #ifdef CONFIG_KMOD
> 		char module_name[80];
> 		sprintf (module_name, "md-personality-%d", pnum);
> 		request_module (module_name);
> Error --->
> 		if (!pers[pnum])
> #endif
> 			return -EINVAL;
> 	}


This one is not a bug.  "request_module" will hopefully load a module
and run it's init routine, which should set pers[pnum] to some proper
value.
Ofcourse, it might not, so we have to check.

Note that "pers" here is a global variable, and so it should be
expected that an external function - i.e. request_module - might
change it.

Thanks anyway.

NeilBrown
