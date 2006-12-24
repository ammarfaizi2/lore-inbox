Return-Path: <linux-kernel-owner+w=401wt.eu-S1753982AbWLXBNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbWLXBNa (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 20:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753994AbWLXBNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 20:13:30 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60297 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982AbWLXBN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 20:13:29 -0500
Date: Sat, 23 Dec 2006 17:12:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
       maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: Re: ext3-related crash in 2.6.20-rc1
Message-Id: <20061223171228.120ac8a6.akpm@osdl.org>
In-Reply-To: <20061223234305.GA1809@elf.ucw.cz>
References: <20061223234305.GA1809@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Dec 2006 00:43:05 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> I got this nasty oops while playing with debugger. Not sure if that is
> related; it also might be something with bluetooth; I already know it
> corrupts memory during suspend, perhaps it corrupts memory in some
> error path?
> 
>  
> 
> 								Pavel
> 
> 
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> PM: Removing info for bluetooth:acl00803715A329
> e1000: eth0: e1000_watchdog: NIC Link is Down
> e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
> e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
> e1000: eth0: e1000_watchdog: NIC Link is Down
> e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
> e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
> ------------[ cut here ]------------
> kernel BUG at fs/buffer.c:1235!

get thee to fs/buffer.c:1235.  You'll see that someone somewhere forgot to
reenable local interrupts.

Were you using gdb at the time?  A fix for something like that was merged
into mainline yesterday.

The slab errors which you're reporting in later emails will almost surely
be unrelated to this.

