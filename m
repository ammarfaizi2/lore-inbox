Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTFHWTb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 18:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTFHWTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 18:19:31 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:29967 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S263971AbTFHWTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 18:19:30 -0400
Date: Mon, 9 Jun 2003 00:32:49 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "David S. Miller" <davem@redhat.com>
cc: wa@almesberger.net, <chas@cmf.nrl.navy.mil>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
In-Reply-To: <20030607.235706.41641672.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0306082228460.5042-100000@serv>
References: <20030606212026.I3232@almesberger.net> <20030606.235811.39162108.davem@redhat.com>
 <Pine.LNX.4.44.0306071922350.12110-100000@serv> <20030607.235706.41641672.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 7 Jun 2003, David S. Miller wrote:

>    The basic problem is still that module_exit is a synchronous interface, 
>    from where you can't call any asynchronous functions, unless you prevent 
>    new callbacks via try_module_get() or you have to wait for all pending 
>    events.
> 
> We don't use module refcounts at all anymore for netdev objects.
> That's the whole key.

If I read the source correctly, unregister_netdevice() simply does rip the 
device out and sees what happens? It's a bit primitive, but should of 
course work too.
I'm just not sure if that model works that well in other parts too, I 
think file systems don't really like it, if the device under them 
disappears. Any kind of automatic module unloading also becomes a bit 
difficult without a module use count. I also hope no net driver starts 
exporting it's own data via sysfs (I currently don't see anything that 
would protect this).
BTW does anything protect the get_stats() call in netstat_attr_show()?

bye, Roman

