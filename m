Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVCIVts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVCIVts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVCIVqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:46:25 -0500
Received: from fmr22.intel.com ([143.183.121.14]:23727 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261552AbVCIVgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 16:36:11 -0500
Date: Wed, 9 Mar 2005 13:36:05 -0800
Message-Id: <200503092136.j29La5E26081@unix-os.sc.intel.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Tim Bird <tim.bird@am.sony.com>
From: Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] add timing information to printk messages
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here's a little patch which is useful for showing timing information for
> kernel bootup activities.
> 
> This patch adds a new Kconfig option under "Kernel Hacking" and a new
> option for the kernel command line.  It also provides a script for
> showing delta information.

I'm seeing some odd output with CONFIG_PRINTK_TIME=y during boot.  When
it is set to "no", I see this from "dmesg":

Total of 4 processors activated (7168.96 BogoMIPS).
CPU0 attaching sched-domain:
 domain 0: span f
  groups: 1 2 4 8
CPU1 attaching sched-domain:
 domain 0: span f
  groups: 2 4 8 1
CPU2 attaching sched-domain:
 domain 0: span f
  groups: 4 8 1 2
CPU3 attaching sched-domain:
 domain 0: span f
  groups: 8 1 2 4

Setting CONFIG_PRINTK_TIME=y I see (the "<NUL>" pieces are actually
each a single ASCII '\0' character):

[    0.240887] Total of 4 processors activated (7168.96 BogoMIPS).
[    0.240926] CPU0 attaching sched-domain:
[    0.240930] <NUL>PU0 attaching sched-domain:
[    0.240933]  domain 0: span f
[    0.240967] <NUL> f
[    0.240969]   groups: 1 2 4 8
[    0.241024] CPU1 attaching sched-domain:
[    0.241027] <NUL>PU1 attaching sched-domain:
[    0.241030]  domain 0: span f
[    0.241063] <NUL> f
[    0.241065]   groups: 2 4 8 1
[    0.241146] CPU2 attaching sched-domain:
[    0.241149] <NUL>PU2 attaching sched-domain:
[    0.241151]  domain 0: span f
[    0.241186] <NUL> f
[    0.241188]   groups: 4 8 1 2
[    0.241267] CPU3 attaching sched-domain:
[    0.241270] <NUL>PU3 attaching sched-domain:
[    0.241273]  domain 0: span f
[    0.241307] <NUL> f
[    0.241309]   groups: 8 1 2 4

At first I thought that the lines that begin with whitespace were causing
the confusion, but there are other lines during boot that are ok.

[This is on an ia64 system ... but these messages come from generic kern/sched.c]

-Tony
