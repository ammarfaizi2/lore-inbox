Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264271AbUEDInp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbUEDInp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 04:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUEDInp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 04:43:45 -0400
Received: from adsl-83-231.38-151.net24.it ([151.38.231.83]:56333 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S264271AbUEDIn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 04:43:28 -0400
Date: Tue, 4 May 2004 10:43:26 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Ken Ashcraft <ken@coverity.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] sis900 fix (Was: [CHECKER] Resource leaks in driver shutdown functions)
Message-ID: <20040504084326.GA11133@gateway.milesteg.arr>
Mail-Followup-To: Ken Ashcraft <ken@coverity.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
References: <3580.171.64.70.92.1083609961.spork@webmail.coverity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3580.171.64.70.92.1083609961.spork@webmail.coverity.com>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the spotting, the sis900 dirver was really missing a call
to netif_device_detach in sis900_suspend.

Attached is a trivial patch that fixes the issue.

The sis900 driver is currently unmaintained (the MAINTAINERS address
bounces), but I'm willing to take the work, since I know somewhat the
code and I wrote the power management functions.

I no one stands up, I'll send a patch to MAINTAINERS later on.

Bye.

On Mon, May 03, 2004 at 11:46:01AM -0700, Ken Ashcraft wrote:
> The resource allocation/freeing functions in question below are:
> netif_start_queue/netif_stop_queue
> 
> If you are CC'd on this email, it is because I think you are the
> maintainer for some of the code below.  Search for your email address
> below to find it.
> 
> 1	|	/drivers/net/sis900.c
> ---------------------------------------------------------
...
> [BUG] webvenza@libero.it
> /home/kash/linux/2.6.3/linux-2.6.3/drivers/net/sis900.c:2191:sis900_suspend:ERROR:INTERFACE_A_B:
> Not calling netif_device_detach. See sis900_resume:2229
> [COUNTER=netif_device_attach-netif_device_detach] [fit=4] [fit_fn=2]
> [fn_ex=0] [fn_counter=1] [ex=18] [counter=2] [z = 1.11803398874989] [fn-z
> = -2]
> 	pci_set_drvdata(pci_dev, NULL);
> }
> 
> #ifdef CONFIG_PM
> 
> 
> Error --->
> static int sis900_suspend(struct pci_dev *pci_dev, u32 state)
> {
> 	struct net_device *net_dev = pci_get_drvdata(pci_dev);
> 	struct sis900_private *sis_priv = net_dev->priv;

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

