Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbTILIcy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 04:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbTILIcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 04:32:54 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:2189 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261243AbTILIcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 04:32:53 -0400
Subject: Re: [PATCH] s390 (1/7): s390 base.
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFB18285B0.412F9315-ONC1256D9F.002E62B6-C1256D9F.002EE1EC@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Fri, 12 Sep 2003 10:32:04 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 12/09/2003 10:32:37
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pete,

> For 2.4 I came up with this:
I will give it a try and if it works better I'll take it.

>From your patch:

> +/*
> + * Return the kernel stack for the current or interrupted thread,
> + * considering that the async stack is useless for purposes of sysrq.
> + * All this acrobatics would not be needed if struct pt_regs pointer
> + * was available when softirq is run, because that is where we printk.
> + * Alas, it's not feasible.
> + */

Which pt_regs are you refering to? You can always get a pointer of the
first pt_regs structure by using __KSTK_PTREGS(tsk). The first pt_regs
structure is the one that contains the saved psw/registers of the user
space process. If you want to get the pt_regs structure from the async
stack it gets ambivalent because there can be more than one pt_regs
structure on it. One for the first asynchronous interrupt and one from
a second asynchronous interrupt that hit us while the softirq is executed.

blue skies,
   Martin


