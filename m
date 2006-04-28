Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbWD1HmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbWD1HmX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 03:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWD1HmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 03:42:23 -0400
Received: from nproxy.gmail.com ([64.233.182.189]:31443 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030303AbWD1HmW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 03:42:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sk9uG/8SAbiXNSrvt2bqw6lwITgiX2eR9BvuOsSBPh5VdhkfEDBeaGuoX4lTqicbHG3UNAoYGoUus97vcXFVUKoPkCay90zCk9iYzDMuUpzHOVEyxJzMHP1ce7t7J8n7zLwfdWcmCCvlNa838AFKDqD7/sRVNv3dawlVlUerLdw=
Message-ID: <7da560840604280042q33450573p9b21751c9046500c@mail.gmail.com>
Date: Fri, 28 Apr 2006 00:42:21 -0700
From: "Muthu Kumar" <muthu.lkml@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: functions named similar (pci_acpi_init)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060428032354.GA20578@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7da560840604271637n65106962k180234c116614d94@mail.gmail.com>
	 <20060428000026.GA29421@kroah.com>
	 <7da560840604271727q185af577sb666ac82a33d78d6@mail.gmail.com>
	 <20060428032354.GA20578@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ACPI PCI: Rename the functions to avoid multiple instances.

There were two instances of pci_acpi_init(), one in
drivers/pci/pci-acpi.c and another in arch/i386/pci/acpi.c.
Rename the one in pci-acpi.c and make it consistent with
other names in the same file.

Signed-off-by: Muthukumar R <muthur@gmail.com>

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 6917c6c..d84e25c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -257,7 +257,7 @@ static int acpi_pci_set_power_state(stru


 /* ACPI bus type */
-static int pci_acpi_find_device(struct device *dev, acpi_handle *handle)
+static int acpi_pci_find_device(struct device *dev, acpi_handle *handle)
 {
        struct pci_dev * pci_dev;
        acpi_integer    addr;
@@ -271,7 +271,7 @@ static int pci_acpi_find_device(struct d
        return 0;
 }

-static int pci_acpi_find_root_bridge(struct device *dev, acpi_handle *handle)
+static int acpi_pci_find_root_bridge(struct device *dev, acpi_handle *handle)
 {
        int num;
        unsigned int seg, bus;
@@ -289,21 +289,21 @@ static int pci_acpi_find_root_bridge(str
        return 0;
 }

-static struct acpi_bus_type pci_acpi_bus = {
+static struct acpi_bus_type acpi_pci_bus = {
        .bus = &pci_bus_type,
-       .find_device = pci_acpi_find_device,
-       .find_bridge = pci_acpi_find_root_bridge,
+       .find_device = acpi_pci_find_device,
+       .find_bridge = acpi_pci_find_root_bridge,
 };

-static int __init pci_acpi_init(void)
+static int __init acpi_pci_init(void)
 {
        int ret;

-       ret = register_acpi_bus_type(&pci_acpi_bus);
+       ret = register_acpi_bus_type(&acpi_pci_bus);
        if (ret)
                return 0;
        platform_pci_choose_state = acpi_pci_choose_state;
        platform_pci_set_power_state = acpi_pci_set_power_state;
        return 0;
 }
-arch_initcall(pci_acpi_init);
+arch_initcall(acpi_pci_init);
















On 4/27/06, Greg KH <greg@kroah.com> wrote:
> On Thu, Apr 27, 2006 at 05:27:49PM -0700, Muthu Kumar wrote:
> > thanks.. How about the following to make the names consistent with others in
> > that file:
>
> Looks good to me.  Can you resend it with a proper changelog comments
> and a Signed-off-by: so I can apply it?
>
> thanks,
>
> greg k-h
>
