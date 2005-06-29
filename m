Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVF2QAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVF2QAK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVF2QAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:00:10 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:3475 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261532AbVF2P77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:59:59 -0400
Date: Wed, 29 Jun 2005 10:59:54 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: Re: [PATCH 4/13]: PCI Err: e100 ethernet driver recovery
Message-ID: <20050629155954.GH28499@austin.ibm.com>
References: <20050628235848.GA6376@austin.ibm.com> <1120009619.5133.228.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120009619.5133.228.camel@gaston>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 11:46:58AM +1000, Benjamin Herrenschmidt was heard to remark:
> On Tue, 2005-06-28 at 18:58 -0500, Linas Vepstas wrote:
> > /** e100_io_error_detected() is called when PCI error is detected */
> > +static int e100_io_error_detected (struct pci_dev *pdev, enum
> > pci_channel_state state)
> > +{
> > +       struct net_device *netdev = pci_get_drvdata(pdev);
> > +       struct nic *nic = netdev_priv(netdev);
> > +
> > +       mod_timer(&nic->watchdog, jiffies + 30*HZ);
> > +       e100_down(nic);
> > +
> > +       /* Request a slot reset. */
> > +       return PCIERR_RESULT_NEED_RESET;
> > +}
> 
> I'm not sure just "pushing" the watchdog timer to 30sec in the future is
> the way to go here. What about netif_stop_queue() or so ?

Yep, OK. Pushig the timer would in fact break if the device was marked
perm disabled.

--linas
