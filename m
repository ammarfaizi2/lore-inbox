Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265124AbUFAQhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbUFAQhA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUFAQXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:23:54 -0400
Received: from [213.146.154.40] ([213.146.154.40]:24035 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265037AbUFAQVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:21:00 -0400
Date: Tue, 1 Jun 2004 17:20:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: intel-agp: skip non-AGP devices
Message-ID: <20040601162058.GA20983@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matt Domsch <Matt_Domsch@dell.com>, davej@redhat.com,
	linux-kernel@vger.kernel.org
References: <20040601160457.GA11437@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601160457.GA11437@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 11:04:57AM -0500, Matt Domsch wrote:
> Dave, 
> 
> On our PowerEdge 2600 system, which has an Intel E7501 Memroy
> Controller Hub, the intel-agp probe code is reporting, at KERN_ERR no less:
> 
> agpgart: Unsupported Intel chipset (device id 254c)
> 

...

> agp_intel_probe()  calls pci_find_capability(PCI_CAP_ID_AGP)
> but doesn't check the return value (should be zero in this case) prior
> to moving into the switch.
> 
> 
> The patch below checks for a valid cap_ptr prior to printing the
> message, now at KERN_WARNING level (it's not really an error, is it?)

The real problem is that agpgart doesn't properly fill in the pci_id
table but claims all devices and then does it's own probing internally.

This also breaks hotplug in a funny way.
