Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWFUBJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWFUBJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWFUBJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:09:50 -0400
Received: from mga07.intel.com ([143.182.124.22]:59746 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751912AbWFUBJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:09:49 -0400
X-IronPort-AV: i="4.06,158,1149490800"; 
   d="scan'208"; a="55096166:sNHT414565935"
Date: Tue, 20 Jun 2006 17:44:24 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Len Brown <len.brown@intel.com>,
       Kimball Murray <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 4/25] msi: Simplify msi enable and disable.
Message-ID: <20060620174424.B10402@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <11508425191063-git-send-email-ebiederm@xmission.com>; from ebiederm@xmission.com on Tue, Jun 20, 2006 at 04:28:17PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 04:28:17PM -0600, Eric W. Biederman wrote:
> 
> @@ -937,27 +936,8 @@ int pci_enable_msi(struct pci_dev* dev)
>  	if (!pos)
>  		return -EINVAL;
>  
> -	if (!msi_lookup_vector(dev, PCI_CAP_ID_MSI)) {
> -		/* Lookup Sucess */
> -		unsigned long flags;
> +	BUG_ON(!msi_lookup_vector(dev, PCI_CAP_ID_MSI));
>  
A driver that calls pci_enable_msi() while MSI is already enabled
will hit this BUG_ON. This is different from the behavior of
some other pci functions like pci_enable_device(), which
silently return success if the requested operation is a nop.
It's pretty easy to do the same here too (ditto for MSI-X).

Rajesh
