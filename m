Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUDNLE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 07:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264036AbUDNLE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 07:04:58 -0400
Received: from mail1.kontent.de ([81.88.34.36]:44765 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261181AbUDNLE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 07:04:57 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Duncan Sands <baldrick@free.fr>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 8/9] USB usbfs: missing lock in proc_getdriver
Date: Wed, 14 Apr 2004 13:04:48 +0200
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141247.24227.baldrick@free.fr>
In-Reply-To: <200404141247.24227.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404141304.48641.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +	down_read(&usb_bus_type.subsys.rwsem);
> +	if (interface && interface->dev.driver) {
> +		strncpy(gd.driver, interface->dev.driver->name, sizeof(gd.driver));
> +		ret = copy_to_user(arg, &gd, sizeof(gd)) ? -EFAULT : 0;
> +	}
> +	up_read(&usb_bus_type.subsys.rwsem);
> +	return ret;

IMHO you should drop the lock before you copy to userspace.

	Regards
		Oliver

