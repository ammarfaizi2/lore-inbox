Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261703AbTCaQwY>; Mon, 31 Mar 2003 11:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261705AbTCaQwY>; Mon, 31 Mar 2003 11:52:24 -0500
Received: from air-2.osdl.org ([65.172.181.6]:65446 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261703AbTCaQwX>;
	Mon, 31 Mar 2003 11:52:23 -0500
Date: Mon, 31 Mar 2003 08:59:09 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: roy@karlsbakk.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: turning off kernel dhcp klient on _one_ nic?
Message-Id: <20030331085909.01782332.rddunlap@osdl.org>
In-Reply-To: <20030328081318.304196ca.rddunlap@osdl.org>
References: <200303281030.35551.roy@karlsbakk.net>
	<20030328081318.304196ca.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Mar 2003 08:13:18 -0800 Randy.Dunlap <rddunlap@osdl.org> wrote:

| On Fri, 28 Mar 2003 10:30:35 +0100 Roy Sigurd Karlsbakk <roy@karlsbakk.net> wrote:
| 
| | is it possible to turn off the kernel dhcp client / kernel autoconfiguration 
| | on _one_ nic? We're using dual gigabit cards from intel (e1000), so splitting 
| | up modular/static drivers obviously won't do the job. I've search through the 
| | kernel doc, but I can't find anything...
| 
| I've seen that, er, scenario, too.
| I should have fixed it last night, but I had other things to do.
| 
| Can['t] you just mess around with (depending on distro, not kernel)
| something like /etc/sysconfig/network-scripts/ifcfg-ethN (just rename
| one of them so that it won't be used)?
| 
| This should totally disable half of the dual NIC.  Do you want to only
| disable dhcp on half of it, but keep it usable otherwise?
| You can edit ./ifcfg-ethN and change the line
| BOOTPROTO=dhcp
| to
| BOOTPROTO=
| 
| Something like that should work, but I haven't done it yet.

I did this and it works.  I had /etc/sysconfig/network-scripts/ifcfg-eth[01]
but I only want one of them alive, so I renamed ifcfg-eth1 to
not-ifcfg-ethbackup  (since the ifcfg* files are searched for as /ifcfg*/).
Then I renamed ifcfg-eth0 to ifcfg-ethmain and (by using advice from
the thread on "NICs trading places ?"), I used 'nameif' to name the
eth0 interface to 'ethmain' by making an /etc/mactab file containing:

ethmain     mac.address.for.live.interface

and I modified /etc/rc.d/init.d/network to run 'nameif' to change
the interface names as listed in the /etc/mactab file.

--
~Randy
