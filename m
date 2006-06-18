Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWFRSxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWFRSxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 14:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWFRSxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 14:53:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:62163 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932280AbWFRSxH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 14:53:07 -0400
Date: Sun, 18 Jun 2006 19:53:06 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: dlezcano@fr.ibm.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [RFC] [patch 2/6] [Network namespace] Network device sharing by view
Message-ID: <20060618185306.GC27946@ftp.linux.org.uk>
References: <20060609210202.215291000@localhost.localdomain> <20060609210625.144158000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609210625.144158000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 11:02:04PM +0200, dlezcano@fr.ibm.com wrote:

> +	read_lock(&dev_base_lock);
> +
> +	for (dev = dev_base; dev; dev = dev->next)
> +		if (!strncmp(dev->name, devname, IFNAMSIZ))
> +			break;
> +
> +	if (!dev) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	db = kmalloc(sizeof(*db), GFP_KERNEL);

deadlock.


Besides, holding references to net_device from userland is Not Good(tm).
