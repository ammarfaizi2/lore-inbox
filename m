Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWFRS5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWFRS5X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 14:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWFRS5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 14:57:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45546 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932286AbWFRS5W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 14:57:22 -0400
Date: Sun, 18 Jun 2006 19:57:21 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: dlezcano@fr.ibm.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [RFC] [patch 3/6] [Network namespace] Network devices isolation
Message-ID: <20060618185721.GD27946@ftp.linux.org.uk>
References: <20060609210202.215291000@localhost.localdomain> <20060609210627.064168000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609210627.064168000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 11:02:05PM +0200, dlezcano@fr.ibm.com wrote:
>  struct net_device *dev_get_by_name(const char *name)
>  {
> +	struct net_ns_dev_list *dev_list = &(net_ns()->dev_list);
>  	struct net_device *dev;
>  
> -	read_lock(&dev_base_lock);
> +	read_lock(&dev_list->lock);
>  	dev = __dev_get_by_name(name);
>  	if (dev)
>  		dev_hold(dev);
> -	read_unlock(&dev_base_lock);
> +	read_unlock(&dev_list->lock);
>  	return dev;

And what would stop renames done via different lists from creating a
conflict?  Incidentally, WTF protects the device name while we are
doing that lookup?

While we are at it, what are you going to do with sysfs?
ls /sys/class/net and watch the fun...
