Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264753AbTFEQnu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 12:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264755AbTFEQnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 12:43:50 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:36760 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264753AbTFEQns
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 12:43:48 -0400
Date: Thu, 5 Jun 2003 09:58:31 -0700
From: Greg KH <greg@kroah.com>
To: Albert Cahalan <albert@users.sourceforge.net>, msw@redhat.com,
       tinglett@us.ibm.com, engebret@us.ibm.com, jdewand@redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, davem@redhat.com,
       torvalds@transmeta.com, bcollins@debian.org, wli@holomorphy.com,
       tom_gall@vnet.ibm.com, anton@samba.org
Subject: Re: /proc/bus/pci
Message-ID: <20030605165831.GA5235@kroah.com>
References: <1054783303.22104.5569.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054783303.22104.5569.camel@cube>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 11:21:43PM -0400, Albert Cahalan wrote:
> I notice that /proc/bus/pci doesn't offer a sane
> interface for multiple PCI domains and choice of BAR.
> What do people think of this?
> 
> bus/pci/00/00.0 -> ../hose0/bus0/dev0/fn0/config-space
> bus/pci/hose0/bus0/dev0/fn0/config-space
> bus/pci/hose0/bus0/dev0/fn0/bar0
> bus/pci/hose0/bus0/dev0/fn0/bar1
> bus/pci/hose0/bus0/dev0/fn0/bar2
> bus/pci/hose0/bus0/dev0/fn0/status
> 
> Then with some mmap flags, the nasty ioctl() stuff
> won't be needed anymore. It can die during 2.7.xx
> development. If MAP_MMIO isn't generally acceptable,
> then it could be via filename suffixes. (eeew, IMHO)
> 
> One remaining problem is permission. Any complaints
> about implementing chmod() for those? Since this
> does bypass capabilities, a mount option might be
> used to enable it.
> 
> As alternatives to /proc changes, a distinct filesystem
> could be developed or sysfs could be abused.

Matt Wilson and I have been talking about some changes like this
recently.  This was because some of the ppc64 ports are doing some other
weird things to try to handle the bigger IBM machines (they were abusing
the pci structures pretty badly, not pretty stuff.)

We agreed that we should call this a "domain", too, and he has a patch
that he says works for X.

Hopefully this prod will get him to send out his patch :)

thanks,

greg k-h
