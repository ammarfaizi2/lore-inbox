Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264961AbUGZHUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbUGZHUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 03:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUGZHUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 03:20:42 -0400
Received: from main.gmane.org ([80.91.224.249]:15570 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264961AbUGZHUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 03:20:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: Future devfs plans (sorry for previous incomplete message)
Date: Mon, 26 Jul 2004 13:11:34 +0600
Message-ID: <ce2ar6$s5p$1@sea.gmane.org>
References: <200407261737.i6QHbff04878@freya.yggdrasil.com> <20040726062435.GA22559@thump.bur.st> <200407260332.43030.norberto+linux-kernel@bensa.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsa.physics.usu.ru
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
In-Reply-To: <200407260332.43030.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norberto Bensa wrote:

> Trent Lloyd wrote:
> 
>>Wouldn't a possible solution to do this to develop an extension to tmpfs to
>>catch files accessed that don't exist etc and use that in conjuction
>>with udev?
> 
> 
> Why would you want to do that? If the device node doesn't exist -> there's no 
> hardware -> there's no need to load a driver/module.

Wrong - think about /dev/loop0

> 
> udev/hotplug are doing the right thing (tm)

They are doing the right thing (tm) _only_ in conjunction with this 
bootscript snippet:

	KVERSION=`uname -r`
         for module in `egrep '^alias (char|block)-major' \
             /lib/modules/$KVERSION/modules.alias /etc/modprobe.conf | \
             grep -v 1394 | awk '{print $3;}'`
         do
             modprobe $module
         done

I have, however, posted this snippet to linux-hotplug-devel and they 
rejected it for no apparent reason. This snippet loads exactly the same 
modules as the kernel would autoload with static /dev.

The "grep -v 1394" is due to the kernel bug described in the following 
message: http://lkml.org/lkml/2004/5/30/143

Also the recent "enable all hotplug events" patch 
(http://lkml.org/lkml/2004/7/13/74 + http://lkml.org/lkml/2004/7/20/47) 
with a custom initramfs 
(http://bugs.linuxfromscratch.org/attachment.cgi?id=112&action=view) is 
a very good thing.

-- 
Alexander E. Patrakov

