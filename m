Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVF2BzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVF2BzL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVF2ByS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:54:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:34720 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262208AbVF2Bwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 21:52:45 -0400
Subject: Re: [PATCH 4/13]: PCI Err: e100 ethernet driver recovery
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
In-Reply-To: <20050628235848.GA6376@austin.ibm.com>
References: <20050628235848.GA6376@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 11:46:58 +1000
Message-Id: <1120009619.5133.228.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 18:58 -0500, Linas Vepstas wrote:
> /** e100_io_error_detected() is called when PCI error is detected */
> +static int e100_io_error_detected (struct pci_dev *pdev, enum
> pci_channel_state state)
> +{
> +       struct net_device *netdev = pci_get_drvdata(pdev);
> +       struct nic *nic = netdev_priv(netdev);
> +
> +       mod_timer(&nic->watchdog, jiffies + 30*HZ);
> +       e100_down(nic);
> +
> +       /* Request a slot reset. */
> +       return PCIERR_RESULT_NEED_RESET;
> +}

I'm not sure just "pushing" the watchdog timer to 30sec in the future is
the way to go here. What about netif_stop_queue() or so ?

Ben.

