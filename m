Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVCHHB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVCHHB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 02:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVCHG7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:59:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:417 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261870AbVCHGzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:55:42 -0500
Date: Mon, 7 Mar 2005 22:44:25 -0800
From: Greg KH <greg@kroah.com>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050308064424.GF17022@kroah.com>
References: <42225A47.3060206@us.ltcfwd.linux.ibm.com> <20050228063954.GB23595@kroah.com> <4228CE41.2000102@us.ltcfwd.linux.ibm.com> <20050304220116.GA1201@kroah.com> <422CD9DB.10103@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422CD9DB.10103@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 05:46:51PM -0500, Wen Xiong wrote:
> +static ssize_t jsm_driver_version_show(struct device_driver *ddp, char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "jsm_version: %s\n", JSM_VERSION);

Again, drop the "prefix:" from every sysfs file, it should not be there
(the data type is inferred by the name of the file, you do not have to
repeat it again.)

> +static ssize_t jsm_tty_state_show(struct class_device *class_dev, char *buf)
> +{
> +	struct jsm_channel *ch;
> +
> +	if (class_dev) {
> +		ch = class_get_devdata(class_dev);
> +		if ( ch && (ch->ch_bd->state == BOARD_READY))
> +			return snprintf(buf, PAGE_SIZE, "%s\n", ch->ch_open_count ? "Open" : "Closed");
> +	}
> +
> +	return -EINVAL;
> +}
> +static CLASS_DEVICE_ATTR(state, S_IRUGO, jsm_tty_state_show, NULL);

Who needs to know if a port is open or not?

> +static ssize_t jsm_tty_baud_show(struct class_device *class_dev, char *buf)
> +{
> +	struct jsm_channel *ch;
> +
> +	if (class_dev) {
> +		ch = class_get_devdata(class_dev);
> +		if ( ch && (ch->ch_bd->state == BOARD_READY))
> +		return snprintf(buf, PAGE_SIZE, "%d\n", ch->ch_old_baud);
> +	}
> +
> +	return -EINVAL;
> +}
> +static CLASS_DEVICE_ATTR(baud, S_IRUGO, jsm_tty_baud_show, NULL);

No, please delete these, and the other sysfs files that duplicate the
same info that you can get by using the standard Linux termios calls.
There is no need for them here.

thanks,

greg k-h
