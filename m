Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWD2IxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWD2IxQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 04:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWD2IxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 04:53:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60811 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751175AbWD2IxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 04:53:15 -0400
Date: Sat, 29 Apr 2006 01:51:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, airlied@linux.ie, pjones@redhat.com
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow
 userspace (Xorg) to enable devices without doing foul direct access
Message-Id: <20060429015116.2c3d964b.akpm@osdl.org>
In-Reply-To: <1146300385.3125.3.camel@laptopd505.fenrus.org>
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@linux.intel.com> wrote:
>
> +static ssize_t
> +is_enabled_store(struct device *dev, struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +        struct pci_dev *pdev = to_pci_dev(dev);

whitespace broke

> +	if (!pdev)
> +		return 1;

Can this happen?

> +	/* this can crash the machine when done on the "wrong" device */
> +	if (!capable(CAP_SYS_ADMIN))
> +		return 1;

Don't the file's permissions suffice?

> +	if (*buf == '0')
> +		pci_disable_device(pdev);
> +
> +	if (*buf == '1')
> +		pci_enable_device(pdev);
> +
> +	return 1;

	return count;

> +}
> +
>  
>  struct device_attribute pci_dev_attrs[] = {
>  	__ATTR_RO(resource),
> @@ -101,6 +124,7 @@ struct device_attribute pci_dev_attrs[] 
>  	__ATTR_RO(irq),
>  	__ATTR_RO(local_cpus),
>  	__ATTR_RO(modalias),
> +	__ATTR(enable, 0600, is_enabled_show, is_enabled_store),
>  	__ATTR_NULL,
>  };
>  
