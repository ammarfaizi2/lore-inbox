Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbVEMIUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVEMIUF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 04:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVEMIUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 04:20:05 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:32605 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262301AbVEMITd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 04:19:33 -0400
Message-ID: <42846310.1000807@tls.msk.ru>
Date: Fri, 13 May 2005 12:19:28 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
References: <20050506212227.GA24066@kroah.com> <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se> <20050509211323.GB5297@tsiryulnik> <20050512214229.GA30233@kroah.com>
In-Reply-To: <20050512214229.GA30233@kroah.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
[]
> Subject: PCI: add MODALIAS to hotplug event for pci devices
> --- gregkh-2.6.orig/drivers/pci/hotplug.c	2005-05-12 14:28:39.000000000 -0700
> +++ gregkh-2.6/drivers/pci/hotplug.c	2005-05-12 14:28:47.000000000 -0700
> @@ -52,6 +52,16 @@
>  	if ((buffer_size - length <= 0) || (i >= num_envp))
>  		return -ENOMEM;
>  
> +	envp[i++] = scratch;
> +	length += scnprintf (scratch, buffer_size - length,
> +			    "MODALIAS=pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02x\n",
[]
> Subject: PCI: add modalias sysfs file for pci devices
> --- gregkh-2.6.orig/drivers/pci/pci-sysfs.c	2005-05-12 14:28:25.000000000 -0700
> +++ gregkh-2.6/drivers/pci/pci-sysfs.c	2005-05-12 14:28:40.000000000 -0700
> +	return sprintf(buf, "pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02x\n",
> +		       pci_dev->vendor, pci_dev->device,
> +		       pci_dev->subsystem_vendor, pci_dev->subsystem_device,
> +		       (u8)(pci_dev->class >> 16), (u8)(pci_dev->class >> 8),

Just a small note/suggestion... Looks like it's worth to create a common
routine for the two cases.  Just to be sure the value in $MODALIAS and in
devices/xx/modalias are the same.  I think.

/mjt
