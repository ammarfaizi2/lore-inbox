Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264450AbUEDPgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbUEDPgZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 11:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264441AbUEDPgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 11:36:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:59288 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264453AbUEDPgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 11:36:22 -0400
Date: Tue, 4 May 2004 08:28:49 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Daniele Venzano <webvenza@libero.it>
Cc: ken@coverity.com, linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] sis900 fix (Was: [CHECKER] Resource leaks in driver
 shutdown functions)
Message-Id: <20040504082849.56f16613.rddunlap@osdl.org>
In-Reply-To: <20040504084326.GA11133@gateway.milesteg.arr>
References: <3580.171.64.70.92.1083609961.spork@webmail.coverity.com>
	<20040504084326.GA11133@gateway.milesteg.arr>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 May 2004 10:43:26 +0200 Daniele Venzano wrote:

| Thank you for the spotting, the sis900 dirver was really missing a call
| to netif_device_detach in sis900_suspend.
| 
| Attached is a trivial patch that fixes the issue.

Just how trivial is the patch?

-ENOATTACHMENT

| The sis900 driver is currently unmaintained (the MAINTAINERS address
| bounces), but I'm willing to take the work, since I know somewhat the
| code and I wrote the power management functions.
| 
| I no one stands up, I'll send a patch to MAINTAINERS later on.
| 
| Bye.
| 
| On Mon, May 03, 2004 at 11:46:01AM -0700, Ken Ashcraft wrote:
| > The resource allocation/freeing functions in question below are:
| > netif_start_queue/netif_stop_queue
| > 
| > If you are CC'd on this email, it is because I think you are the
| > maintainer for some of the code below.  Search for your email address
| > below to find it.
| > 
| > 1	|	/drivers/net/sis900.c
| > ---------------------------------------------------------
| ...
| > [BUG] webvenza@libero.it
| > /home/kash/linux/2.6.3/linux-2.6.3/drivers/net/sis900.c:2191:sis900_suspend:ERROR:INTERFACE_A_B:
| > Not calling netif_device_detach. See sis900_resume:2229
| > [COUNTER=netif_device_attach-netif_device_detach] [fit=4] [fit_fn=2]
| > [fn_ex=0] [fn_counter=1] [ex=18] [counter=2] [z = 1.11803398874989] [fn-z
| > = -2]
| > 	pci_set_drvdata(pci_dev, NULL);
| > }
| > 
| > #ifdef CONFIG_PM
| > 
| > 
| > Error --->
| > static int sis900_suspend(struct pci_dev *pci_dev, u32 state)
| > {
| > 	struct net_device *net_dev = pci_get_drvdata(pci_dev);
| > 	struct sis900_private *sis_priv = net_dev->priv;
| 
| -- 
| -----------------------------
| Daniele Venzano
| Web: http://teg.homeunix.org


--
~Randy
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature) -- akpm
