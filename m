Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266821AbUI0QyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266821AbUI0QyO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 12:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbUI0QyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 12:54:07 -0400
Received: from fmr04.intel.com ([143.183.121.6]:25576 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S266643AbUI0Qx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 12:53:58 -0400
Date: Mon, 27 Sep 2004 09:53:48 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface support
Message-ID: <20040927095348.A29594@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com> <200409201812.45933.dtor_core@ameritech.net> <20040924162823.B27778@unix-os.sc.intel.com> <200409270112.29422.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200409270112.29422.dtor_core@ameritech.net>; from dtor_core@ameritech.net on Mon, Sep 27, 2004 at 01:12:28AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 01:12:28AM -0500, Dmitry Torokhov wrote:
> On Friday 24 September 2004 06:28 pm, Keshavamurthy Anil S wrote:
> > +typedef void acpi_device_sysfs_files(struct kobject *,
> > +                               const struct attribute *);
> > +
> > +static void setup_sys_fs_device_files(struct acpi_device *dev,
> > +               acpi_device_sysfs_files *func);
> > +
> > +#define create_sysfs_device_files(dev) \
> > +       setup_sys_fs_device_files(dev, (acpi_device_sysfs_files *)&sysfs_create_file)
> > +#define remove_sysfs_device_files(dev) \
> > +       setup_sys_fs_device_files(dev, (acpi_device_sysfs_files *)&sysfs_remove_file)
> 
> 
> Hi Anil,
> 
> It looks very nice except for the part above. I am really confused what the
> purpose of this code is... It looks like it just complicates things?
Hi Dmitry,
	I just wanted to have a single function i.e setup_sys_fs_device_files() for both
creating and removing sysfs files. So I have #defined create_sysfs_device_files() and 
remove_sysfs_device_files() and one of the arguments to the setup_sys_fs_device_files()
is a function pointer, i.e for one it takes sysfs_create_file and for other it takes
sysfs_remove_file.

Having single function for creating and removing sysfs files make it easy 
from the maintaince perspective, as oppose to remember to code for remove 
as well when one adds the new file.


thanks,
Anil
