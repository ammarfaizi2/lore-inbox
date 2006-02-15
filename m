Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030622AbWBODak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030622AbWBODak (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 22:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030623AbWBODaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 22:30:39 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:51673
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030622AbWBODaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 22:30:39 -0500
Date: Tue, 14 Feb 2006 19:30:24 -0800
From: Greg KH <gregkh@suse.de>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: Karsten Keil <kkeil@suse.de>, i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Tilman Schmidt <tilman@imap.cc>
Subject: Re: [PATCH 6/9] isdn4linux: Siemens Gigaset drivers - procfs interface
Message-ID: <20060215033024.GC5099@suse.de>
References: <gigaset307x.2006.02.11.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.2@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.3@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.4@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.5@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.6@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.02.11.001.6@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 03:52:28PM +0100, Hansjoerg Lipp wrote:
> +#include "gigaset.h"
> +#include <linux/ctype.h>
> +
> +static ssize_t show_cidmode(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct usb_interface *intf = to_usb_interface(dev);
> +	struct cardstate *cs = usb_get_intfdata(intf);
> +	return sprintf(buf, "%d\n", atomic_read(&cs->cidmode)); // FIXME use scnprintf for 13607 bit architectures (if PAGE_SIZE==4096)

sprintf is just fine here, you are only printing a single integer, and
you don't need to worry about the page size.

thanks,

greg k-h
