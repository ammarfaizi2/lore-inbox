Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269829AbRIAAKg>; Fri, 31 Aug 2001 20:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269868AbRIAAK0>; Fri, 31 Aug 2001 20:10:26 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:17165 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S269829AbRIAAKV>;
	Fri, 31 Aug 2001 20:10:21 -0400
Date: Fri, 31 Aug 2001 17:08:22 -0700
From: Greg KH <greg@kroah.com>
To: jeff millar <jeff@wa1hco.mv.com>
Cc: Carlos E Gorges <carlos@techlinux.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Hardware detection tool 0.2
Message-ID: <20010831170822.D23689@kroah.com>
In-Reply-To: <01083019402502.01265@skydive.techlinux> <20010830161809.A19258@kroah.com> <002801c13270$86592680$0201a8c0@home> <20010831162303.A23689@kroah.com> <006501c13277$2e3c8620$0201a8c0@home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <006501c13277$2e3c8620$0201a8c0@home>; from jeff@wa1hco.mv.com on Fri, Aug 31, 2001 at 07:46:38PM -0400
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2001 at 07:46:38PM -0400, jeff millar wrote:
> What bus and slot number does the driver use to register itself before the
> plugging the card?

I don't understand what you are asking here.
In pci_module_init you pass a pointer to your struct pci_driver object
that describes to the pci subsystem what kind of pci devices that your
driver works for.  It does this with the id_table pointer which is a
struct pci_device_id.

MODULE_DEVICE_TABLE takes that struct pci_device_id table and exports it
to an area in the module object table that allows it to be extracted by
depmod.  depmod takes that info and creates
/lib/modules/<kernel_version/modules.pcimap from it.  So any userspace
code can then look at the modules.pcimap file and determine what kind of
pci devices each module is claiming it supports.

Using that table, combined with tools like lspci, a userspace program
can build a table of kernel modules that a given hardware platform
needs.  And if it wants to, from the kernel module list, it can generate
a .config file, which is what I think Carlos is trying to do.  And what
I thought this thread was talking about.

This whole process did not involve any hotplug stuff at all.

But if you want to use it for hotplug you can :)
See my OLS 2001 paper and presentation at http://www.kroah.com/linux/
and http://linux-hotplug.sf.net/ which contains lots of good
documentation if you want to know more on how the linux-hotplug
subsystem currently works.

Did that help?

thanks,

greg k-h
