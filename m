Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUITC3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUITC3I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 22:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUITC3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 22:29:08 -0400
Received: from main.gmane.org ([80.91.229.2]:15085 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265489AbUITC3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 22:29:01 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: udev is too slow creating devices
Date: Mon, 20 Sep 2004 08:29:17 +0600
Message-ID: <cilf99$ams$1@sea.gmane.org>
References: <414C9003.9070707@softhome.net> <1095568704.6545.17.camel@gaston> <414D42F6.5010609@softhome.net> <20040919140034.2257b342.Ballarin.Marc@gmx.de> <414D96EF.6030302@softhome.net> <20040919171456.0c749cf8.Ballarin.Marc@gmx.de> <cikaf1$e60$1@sea.gmane.org> <20040919173035.GA2345@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsa.physics.usu.ru
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: en-us, en
In-Reply-To: <20040919173035.GA2345@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, Sep 19, 2004 at 10:00:52PM +0600, Alexander E. Patrakov wrote:
> 
>>OK. The fact is that, when mounting the root filesystem, the kernel can 
>>(?) definitely say "there is no such device, and it's useless to wait 
>>for it--so I panic". Is it possible to duplicate this logic in the case 
>>with udev and modprobe? If so, it should be built into a common place 
>>(either the kernel or into modprobe), but not into all apps.
> 
> 
> No, we need to just change the kernel to sit and spin for a while if the
> root partition is not found.  This is the main problem right now for
> booting off of a USB device (or any other "slow" to discover device.)
> It's a known kernel issue, and there are patches for 2.4 for this, but
> no one has taken the time to update them for 2.6.
> 
> 
>>Then the "char-major" aliases were always broken, do I understand 
>>correctly?
> 
> 
> Yes, for most drivers they are broken.  Like sound, usb, and others.
> 
> 
>>Once we realize that, isn't it the time to mark the 
>>"Automatic kernel module loading" in the kernel configuration as BROKEN 
>>or OBSOLETE?
> 
> 
> Fine with me, I've been wanting to do that for years.  Are you willing
> to handle the fallout of such a patch though?  :)

Many thanks for detailed explanation. And, since char-major aliases 
don't work with udev anyway, and net-pf aliases are easy to enumerate 
and preload by parsing /lib/modules/`uname -r`/modules.alias, I think 
that udev users are ready to handle the fallout of this patch.

>>>With hotplug/udev you *know* that the device node is available when your
>>>script in dev.d is called with the appropriate environment variables.
>>
>>Yes. Now we have a lot of short scriptlets under /etc/dev.d. But I don't 
>>yet see how these scriptlets interact with each other.
> 
> 
> What do you mean?  What kind of relationship do you need explained about
> them?

Implementation of various logical primitives. E.g., I use GPRS and want 
to start pppd during the boot process (i.e., an always-on link), but 
after the following things:

1) /dev/ttyS0 has been created
2) /dev/ppp has been created
3) modules for line disciplines and PPP compression have been preloaded 
(e.g. by grepping modules.alias for tty-ldisc and ppp-compress) and are 
ready for use by pppd
4) firewall rules have been applied

How to "AND" these things together in a /etc/dev.d scriptlet?

-- 
Alexander E. Patrakov

