Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbTEWXFi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 19:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264169AbTEWXFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 19:05:38 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:45573 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S264098AbTEWXFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 19:05:37 -0400
Date: Sat, 24 May 2003 01:25:20 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: "David S. Miller" <davem@redhat.com>
cc: akpm@digeo.com, Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@hpl.hp.com>, <shemminger@osdl.org>
Subject: Re: [2.5.69] rtnl-deadlock with usermodehelper and keventd
In-Reply-To: <20030523.024308.94566989.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0305240115130.11940-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003, David S. Miller wrote:

>    But nope, unfortunately it's still hanging! I've just tested with 
>    2.5.69-bk15. Running into the same deadlock due to sleeping with rtnl 
>    hold. This time however it seems it's triggered from sysfs side!
> 
> Stephen, you need to do the device class stuff outside of the RTNL
> lock please.
> 
> At least I didn't add this bug :-)
> 
> This should fix it.

Well, back online now pretty late ;-)

Yes, as was already reported I can also confirm from testing the deadlock 
is gone now. Thanks for resolving this issue!

Just a minor question before the thread gets closed: Don't we have the 
same problem in the register path? register_netdevice is running unter 
rtnl and calls netdev_register_sysfs. I've never seen a deadlock there, 
but I'd expect this to sleep for hotplug usermode completion as well.
Maybe this is just what you meant by your comment above ;-)

Martin

