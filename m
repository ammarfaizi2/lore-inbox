Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWIHQzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWIHQzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 12:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWIHQzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 12:55:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5282 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750709AbWIHQzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 12:55:45 -0400
Subject: Re: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
From: Arjan van de Ven <arjan@infradead.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Dave Jones <davej@redhat.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060908161817.GA12642@lists.us.dell.com>
References: <20060908031422.GA4549@lists.us.dell.com>
	 <20060908155639.GJ28592@redhat.com>
	 <20060908161817.GA12642@lists.us.dell.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 08 Sep 2006 18:55:16 +0200
Message-Id: <1157734517.30730.103.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-08 at 11:18 -0500, Matt Domsch wrote:
> On Fri, Sep 08, 2006 at 11:56:39AM -0400, Dave Jones wrote:
> > On Thu, Sep 07, 2006 at 10:14:22PM -0500, Matt Domsch wrote:
> >  > Problem:
> >  > New Dell PowerEdge servers have 2 embedded ethernet ports, which are
> >  > labeled NIC1 and NIC2 on the chassis, in the BIOS setup screens, and
> >  > in the printed documentation.  Assuming no other add-in ethernet ports
> >  > in the system, Linux 2.4 kernels name these eth0 and eth1
> >  > respectively.  Many people have come to expect this naming.  Linux 2.6
> >  > kernels name these eth1 and eth0 respectively (backwards from
> >  > expectations).  I also have reports that various Sun and HP servers
> >  > have similar behavior.
> >  
> > This came up years back when 2.6 was something new, and the answer
> > then was 'bind the interface to the MAC address'.
> 
> Both Red Hat-based distros and openSuSE-based distros do something
> like this with configuration files automatically.  Red Hat's
> anaconda/kudzu puts the HWADDR lines in the generated
> /etc/sysconfig/network-scripts/ifcfg-* files.  openSuSE's udev rules
> puts lines in /etc/udev/rules.d/30-net_persistent_names.rules the
> first time it discovers a new interface.  Both methods are intended to
> maintain a persistent name for each NIC, after being set up the first
> time.  Neither deals well with replacing one NIC with another - you
> must edit the config files.
> 
> This works pretty well post-install.  It doesn't work well at install
> time, all the installers use the kernel's original names, and then
> those names become the persistent names in the config files.
> 
> 
> > Whilst your patch will fix the case that's currently broken (2.4->2.6),
> > doesn't it offer equal possibility to break existing setups when people move
> > from <=2.6.18 -> 2.6.19 ?
> 
> If they're using config files / udev rules as suggested, it shouldn't
> break them.
> 
> If they're not, then yes, this could.  Debian's
> /etc/network/interfaces file allows use of hwaddr fields, though by
> default it doesn't appear anything sets it up.
> 
> I'm open to suggestions on how *not* to break setups that don't use
> the MAC addresses.

to be honest I really don't like the PCI ordering change thing for this.
It's just too fragile altogether to cause a fixed ordering as you want.

Maybe the kernel's initial ordering should do a numeric sort by mac
address or something.. (or userspace should)


