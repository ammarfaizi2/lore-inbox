Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVA1Qse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVA1Qse (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 11:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVA1Qse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 11:48:34 -0500
Received: from cantor.suse.de ([195.135.220.2]:16061 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261479AbVA1Qr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 11:47:57 -0500
Date: Fri, 28 Jan 2005 17:47:56 +0100
From: Olaf Hering <olh@suse.de>
To: dtor_core@ameritech.net
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: atkbd_init lockup with 2.6.11-rc1
Message-ID: <20050128164756.GA2154@suse.de>
References: <20050128132202.GA27323@suse.de> <20050128135827.GA28784@suse.de> <d120d50005012806435a17fe98@mail.gmail.com> <20050128145511.GA29340@suse.de> <d120d500050128072268a5c2f0@mail.gmail.com> <20050128161746.GA1092@suse.de> <d120d500050128084345bb1abd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d120d500050128084345bb1abd@mail.gmail.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Jan 28, Dmitry Torokhov wrote:

> > i8042_write_data(56) swapper(1):c0,j4294674787 enter 96
> > i8042_write_data(58) swapper(1):c0,j4294674787 leave 96
> 
> So this trace is without printk but with udelay, right? This time
> keyboard does not hang but NAKs everything instead... What if you aso
> add udelay(20) after calls to i8042_write_data()?

Its with 2 printk in i8042_write_data(), just adding a printk after outb
in i8042_write_data fixes the hang.

> > md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
> > NET: Registered protocol family 2
> > .. here it hangs again.
> 
> Do you know where exactly? Is it some IO port access again?

Havent debugged that one, yet. Hopefully a different issue. According to
the logs from 2.6.5, the next message would be 

NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17

