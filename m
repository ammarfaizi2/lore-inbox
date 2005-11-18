Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161221AbVKRVXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161221AbVKRVXa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbVKRVX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:23:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49121 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750967AbVKRVX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:23:29 -0500
Subject: Re: [linux-pm] [RFC] userland swsusp
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <1132342590.25914.86.camel@localhost.localdomain>
References: <20051115212942.GA9828@elf.ucw.cz>
	 <20051115222549.GF17023@redhat.com>
	 <1132342590.25914.86.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 22:23:17 +0100
Message-Id: <1132348998.2830.80.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-18 at 19:36 +0000, Alan Cox wrote:
> On Maw, 2005-11-15 at 17:25 -0500, Dave Jones wrote:
> > Just for info: If this goes in, Red Hat/Fedora kernels will fork
> > swsusp development, as this method just will not work there.
> > (We have a restricted /dev/mem that prevents writes to arbitary
> >  memory regions, as part of a patchset to prevent rootkits)
> 
> Perhaps it is trying to tell you that you should be using SELinux rules
> not kernel hacks for this purpose ?

actually no. SELinux can't work, we've looked at that bigtime. Basically
/dev/mem has 3 types in one, and to apply security you need different
roles for each in selinux. so the only option to apply selinux
*anything* is to first split /dev/mem up.

types:
1) accessing non-ram memory (eg PCI mmio space) by X and the likes
   (ideally should use sysfs but hey, changing X for this will take 
   forever)
2) accessing bios memory in the lower 1Gb for various emulation like
   purposes (including vbetool and X mode setting)
3) accessing things the kernel sees as RAM

they are very distinct security wise.


