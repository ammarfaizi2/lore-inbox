Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946175AbWBEIoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946175AbWBEIoG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 03:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946177AbWBEIoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 03:44:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946175AbWBEIoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 03:44:04 -0500
Date: Sun, 5 Feb 2006 00:43:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [RFC 4/4] firewire: add mem1394
Message-Id: <20060205004327.78926498.akpm@osdl.org>
In-Reply-To: <1138920185.3621.24.camel@localhost>
References: <1138919238.3621.12.camel@localhost>
	<1138920185.3621.24.camel@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> wrote:
>
> +config IEEE1394_MEMDEV
> +	tristate "IEEE1394 memory device support"
> +	depends on IEEE1394 && EXPERIMENTAL
> +	help
> +	  Say Y here if you want support for the ieee1394 memory device.
> +	  This is useful for debugging systems attached via firewire
> +	  since it usually allows you to read from and write to their memory,
> +	  depending on the controller and machine setup.

1394 is evil.  Does this mean that if a machine is completely
dead-and-crashed, we can still suck all its memory out over 1394 with no
cooperation from the dead machine's kernel?  If not, what limitations are
there?



Triviata:

> +static int mem1394_read(struct file *file, char __user * buffer,
> +			size_t count, loff_t *offset)
> +{
> +	struct mem1394_file_info *fi = (struct mem1394_file_info*)file->private_data;

Unneeded cast.

> +	packet = hpsb_make_readpacket(fi->memdev->ne->host, fi->memdev->ne->nodeid, *offset, submitcount);

xterm too big!

> +static int mem1394_release(struct inode *inode, struct file *file)
> +{
> +	struct mem1394_file_info *fi = (struct mem1394_file_info*)file->private_data;

Unneeded cast.

> +	

Adds trailing whitespace ;)

> +static struct mem1394_dev * alloc_mem1394_dev(struct device *dev)
> +{
> +	struct mem1394_dev *result;
> +	struct node_entry *ne = container_of(dev, struct node_entry, device);
> +	int ret;
> +	struct class_device * mem1394_class_member;

Inconsistent space-after-asterisk policy (no-space is preferred).

> +	mem1394_class_member = class_device_create(mem1394_sysfs_class, NULL, result->cdev.dev,
> +						dev, "fwmem-%d", atomic_read(&mem1394_dev_ctr));

My eyes!

> +	if (IS_ERR(mem1394_class_member)) {
> +		printk(KERN_WARNING "mem1394: class_device_create failed\n");
> +	} else {
> +		class_set_devdata(mem1394_class_member, result);
> +	}

Unneeded braces.

> +	if (IS_ERR(mem1394_sysfs_class)) {
> +		return PTR_ERR(mem1394_sysfs_class);
> +	}

Ditto.

