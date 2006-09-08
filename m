Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWIHQSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWIHQSR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 12:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWIHQSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 12:18:17 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:13897 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1750884AbWIHQSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 12:18:15 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=WteRgT9wFm3ok3JmfmRdpdSNtRlHvehts8xE4pMrsQijpc8yLakHWqsOcSWyKtGwwAtKFeD3XjirYzpwtY1CYaOXmykv2adyw/9aItVUZ4G6emakEHYWbpvCwzLBKgA/;
X-IronPort-AV: i="4.08,232,1154926800"; 
   d="scan'208"; a="77054000:sNHT687861513"
Date: Fri, 8 Sep 2006 11:18:17 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Dave Jones <davej@redhat.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
Message-ID: <20060908161817.GA12642@lists.us.dell.com>
References: <20060908031422.GA4549@lists.us.dell.com> <20060908155639.GJ28592@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908155639.GJ28592@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 11:56:39AM -0400, Dave Jones wrote:
> On Thu, Sep 07, 2006 at 10:14:22PM -0500, Matt Domsch wrote:
>  > Problem:
>  > New Dell PowerEdge servers have 2 embedded ethernet ports, which are
>  > labeled NIC1 and NIC2 on the chassis, in the BIOS setup screens, and
>  > in the printed documentation.  Assuming no other add-in ethernet ports
>  > in the system, Linux 2.4 kernels name these eth0 and eth1
>  > respectively.  Many people have come to expect this naming.  Linux 2.6
>  > kernels name these eth1 and eth0 respectively (backwards from
>  > expectations).  I also have reports that various Sun and HP servers
>  > have similar behavior.
>  
> This came up years back when 2.6 was something new, and the answer
> then was 'bind the interface to the MAC address'.

Both Red Hat-based distros and openSuSE-based distros do something
like this with configuration files automatically.  Red Hat's
anaconda/kudzu puts the HWADDR lines in the generated
/etc/sysconfig/network-scripts/ifcfg-* files.  openSuSE's udev rules
puts lines in /etc/udev/rules.d/30-net_persistent_names.rules the
first time it discovers a new interface.  Both methods are intended to
maintain a persistent name for each NIC, after being set up the first
time.  Neither deals well with replacing one NIC with another - you
must edit the config files.

This works pretty well post-install.  It doesn't work well at install
time, all the installers use the kernel's original names, and then
those names become the persistent names in the config files.


> Whilst your patch will fix the case that's currently broken (2.4->2.6),
> doesn't it offer equal possibility to break existing setups when people move
> from <=2.6.18 -> 2.6.19 ?

If they're using config files / udev rules as suggested, it shouldn't
break them.

If they're not, then yes, this could.  Debian's
/etc/network/interfaces file allows use of hwaddr fields, though by
default it doesn't appear anything sets it up.

I'm open to suggestions on how *not* to break setups that don't use
the MAC addresses.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
