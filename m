Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbTHZTEv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbTHZTEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:04:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:27602 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262872AbTHZTD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:03:58 -0400
Date: Tue, 26 Aug 2003 11:32:21 -0700
From: Greg KH <greg@kroah.com>
To: Jim Keniston <jkenisto@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev <netdev@oss.sgi.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Feldman, Scott" <scott.feldman@intel.com>,
       Larry Kessler <kessler@us.ibm.com>, Randy Dunlap <rddunlap@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/4] Net device error logging, revised
Message-ID: <20030826183221.GB3167@kroah.com>
References: <3F4A8027.6FE3F594@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4A8027.6FE3F594@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 02:31:19PM -0700, Jim Keniston wrote:
> +int __netdev_printk(const char *sevlevel, const struct net_device *netdev,
> +	int msglevel, const char *format, ...)
> +{
> +	if (!netdev || !format) {
> +		return -EINVAL;
> +	}
> +	if (msglevel == NETIF_MSG_ALL || (netdev->msg_enable & msglevel)) {
> +		char msg[512];

512 bytes on the stack?  Any way to prevent this from happening?  With
the push to make the stack even smaller in 2.7, people will not like
this.

thanks,

greg k-h

