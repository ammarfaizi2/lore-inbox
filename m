Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266126AbUHQMat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266126AbUHQMat (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 08:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268192AbUHQMat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 08:30:49 -0400
Received: from mail501.nifty.com ([202.248.37.209]:16607 "EHLO
	mail501.nifty.com") by vger.kernel.org with ESMTP id S266126AbUHQMa0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 08:30:26 -0400
To: davem@redhat.com, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Reply-To: dev_null@anet.ne.jp
Subject: Re: TG3 doesn't work in kernel 2.4.27
From: Tetsuo Handa <a5497108@anet.ne.jp>
References: <20040817110002.32088.38168.Mailman@linux.us.dell.com>
In-Reply-To: <20040817110002.32088.38168.Mailman@linux.us.dell.com>
Message-Id: <200408172129.AJH50391.692B5188@anet.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Tue, 17 Aug 2004 21:30:06 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, David.

On Mon, 16 Aug 2004 14:38:24 -0700
"David S. Miller" wrote:
> On Mon, 16 Aug 2004 20:51:03 +0900
> Tetsuo Handa <a5497108@anet.ne.jp> wrote:
> 
> >  From 2.4.26 till 2.4.27-rc3 were all OK.
> > This trouble happens with 2.4.27-rc4 and later.
> 
> It's Sun's buggy 5704 Fiber auto-negotiation changes.
> 
> Here is a hacky possible fix, can you try it?
> 
> ===== drivers/net/tg3.c 1.190 vs edited =====

I compiled as a UP kernel but it wasn't the cause.
Also, I patched the above fix on 2.4.27-rc4 and
compiled as a UP kernel, but didn't work.

Now I would like to mail to Marcelo Tosatti, too.

Current Status:
 * The driver is tg3.o
 * The problem began with 2.4.27-rc4.
 * DHCP fails.
 * Static IP assignment shows no error, but network is still unreachable.
   ('ifconfig' and 'route add default gw' by hand)
 * DHCP packets are unreachable to DHCP server.
   (I don't know which options are used for tcpdump.
    I hear that 2.4.26 worked but 2.4.27 didn't. PXE's DHCP works. )
 * 'arp' at DHCP server shows a line with <incomplete> status.
 * Compiling as a UP kernel didn't solve the problem.
   (The box is Xeon 3.2 GHz / 1 CPU with hyper-threading)
 * Compiling as a UP kernel with the above fix didn't solve.
 * The error message "HW autoneg failed" appears.
   (But (I think) this message doesn't exist in tg3.c for 2.4.26,
    so I don't know autoneg were successful or not in 2.4.26,
    if helpful I will insert printk() and try.
    The link ups (if 2.4.26) 1000Mbps full duplex, off for TX and off for RX.)

Regards...
---
Tetsuo Handa
