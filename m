Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbTHZXv3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 19:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbTHZXv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 19:51:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35216 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262980AbTHZXvT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 19:51:19 -0400
Message-ID: <3F4BF265.5050101@pobox.com>
Date: Tue, 26 Aug 2003 19:51:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jim Keniston <jkenisto@us.ibm.com>
CC: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       netdev <netdev@oss.sgi.com>, "Feldman, Scott" <scott.feldman@intel.com>,
       Larry Kessler <kessler@us.ibm.com>, Randy Dunlap <rddunlap@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/4] Net device error logging, revised
References: <3F4A8027.6FE3F594@us.ibm.com> <20030826183221.GB3167@kroah.com> <3F4BEE68.A6C862C2@us.ibm.com>
In-Reply-To: <3F4BEE68.A6C862C2@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Keniston wrote:
> #define netdev_printk(sevlevel, netdev, msglevel, format, arg...)	\
> do {									\
> if (NETIF_MSG_##msglevel == NETIF_MSG_ALL || ((netdev)->msg_enable & NETIF_MSG_##msglevel)) {	\
> 	char pfx[40];							\
> 	printk(sevlevel "%s: " format , make_netdev_msg_prefix(pfx, netdev) , ## arg);	\
> }} while (0)
> 
> This would make your code bigger, but not that much bigger for the common case where
> the msglevel is omitted (and the 'if(...)' is optimized out).


"NETIF_MSG_" is silly and should be eliminated.
A separate "NETIF_MSG_ALL" test is not needed, because msg_enable is a 
bitmask.  A msg_enable of 0xffffffff will naturally create a NETIF_MSG_ALL.

Also, whatever mechanism is created, it needs to preserve the feature of 
the existing system:

	if (a quick bitmask test)
		do something

And preferably "do something" is not inlined, because printk'ing -- 
although it may appear in a fast path during debugging -- cannot be 
considered a fast path itself.

	Jeff



