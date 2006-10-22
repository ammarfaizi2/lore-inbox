Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWJVXlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWJVXlk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 19:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWJVXlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 19:41:40 -0400
Received: from 81-174-19-108.f5.ngi.it ([81.174.19.108]:63423 "EHLO
	develer.com") by vger.kernel.org with ESMTP id S1750855AbWJVXlj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 19:41:39 -0400
Message-ID: <453C01AE.7060103@develer.com>
Date: Mon, 23 Oct 2006 01:41:34 +0200
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l. - http://www.develer.com/
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Cristian Grigoriu <cristian.grigoriu@provus.ro>
CC: b.innocenti@develer.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: NAT failure with TCP, too
References: <4538B314.2020309@provus.ro>
In-Reply-To: <4538B314.2020309@provus.ro>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Cristian Grigoriu wrote:
> Hi,
> 
> I can confirm the same bug you reported here 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0509.2/0279.html
> This time it happens with TCP connections originating from the same TCP 
> port (1234) from multiple machines. The SNAT simply doesn't take place 
> and the normal routing occurs.
> 
> Kernel is Debian stock 2.6.18-1.
> 
> Please let me know if you have find a workaround.

It turned out that the real thing that was triggering the bug
for me was unloading and reloading the ip_nat module without
also reloading ip_conntrack.

The connection tracking tuple would remain in the kernel, visible
in /proc/net/ip_conntrack, but no longer linked to the SNAT rule.
I'd consider this a bug, but very few users will ever be affected.

The workaround for me was to remove my hand-cracted iptables
rules from ppp's ip-up.local and move them to the distro-supplied
iptables firewall instead.  The only downside is that I must now
hardcode the destination ip of the SNAT rule because it's too early
to read the interface address of ppp0.

-- 
   // Bernardo Innocenti - Develer S.r.l., R&D dept.
 \X/  http://www.develer.com/

