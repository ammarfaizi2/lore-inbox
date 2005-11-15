Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbVKOSxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbVKOSxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVKOSxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:53:03 -0500
Received: from hera.kernel.org ([140.211.167.34]:40354 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964973AbVKOSxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:53:01 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: MOD_INC_USE_COUNT
Date: Tue, 15 Nov 2005 10:52:57 -0800
Organization: OSDL
Message-ID: <20051115105257.6a272cdf@localhost.localdomain>
References: <437347B5.6080201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1132080777 23994 10.8.0.74 (15 Nov 2005 18:52:57 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 15 Nov 2005 18:52:57 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.15 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005 21:14:29 +0800
Tony <tony.uestc@gmail.com> wrote:

> Hello All,
> Usually, when a net_device->open is called, it will MOD_INC_USE_COUNT on 
> success. It is removed since 2.5.x, then should I increase the use 
> count? how? thx.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Did you read Documentation/network/netdevices.txt?

Networking devices don't do ref counting because they should be removable
at any time! Because of hotplug and failover, it just doesn't work to keep
track of ref counting network devices. 

What happens is that each protocol is notified on module removal of a
network device. The protocol then cleans up all references to that
device. If the protocol is buggy, then you will see the kernel
wait and print a message that ref count is still not correct.


-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
