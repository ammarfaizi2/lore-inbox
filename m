Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751834AbWIHHVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbWIHHVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 03:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbWIHHVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 03:21:52 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:19637 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751439AbWIHHVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 03:21:51 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <450119D1.7070504@s5r6.in-berlin.de>
Date: Fri, 08 Sep 2006 09:20:49 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Miles Lane <miles.lane@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>, linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6.18-rc5-git1 + "ieee1394: nodemgr" patches -- BUG: unable
 to handle kernel NULL pointer dereference at virtual address 00000000
References: <a44ae5cd0609071821h515753f5wdd3ceecc39434e91@mail.gmail.com>
In-Reply-To: <a44ae5cd0609071821h515753f5wdd3ceecc39434e91@mail.gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
...
> Things went pretty well, until I ran
> "pccardctl eject" and then popped out the Firewire card.
...
> BUG: unable to handle kernel NULL pointer dereference at virtual
> address 00000000
...
> EIP is at dv1394_remove_host+0x17/0xad [dv1394]
...
> Call Trace:
> [<f91788c2>] __unregister_host+0x17/0x79 [ieee1394]
> [<f9178945>] highlevel_remove_host+0x21/0x42 [ieee1394]
> [<f9177e65>] hpsb_remove_host+0x37/0x56 [ieee1394]
> [<f912c9f2>] ohci1394_pci_remove+0x41/0x1cd [ohci1394]
> [<c10c5d24>] pci_device_remove+0x16/0x28
> [<c111dcbd>] __device_release_driver+0x5a/0x72
> [<c111de8f>] device_release_driver+0x1b/0x29
> [<c111d705>] bus_remove_device+0x78/0x8a
> [<c111c8a7>] device_del+0xe9/0x11a
> [<c111c8e0>] device_unregister+0x8/0x10
> [<c10c3ee5>] pci_remove_bus_device+0x39/0xcf
> [<c10c3f95>] pci_remove_behind_bridge+0x1a/0x2d
> [<f910d5ae>] socket_shutdown+0x89/0xdd [pcmcia_core]
> [<f910d675>] pcmcia_eject_card+0x56/0x65 [pcmcia_core]
...

Looks like the last word on
http://bugzilla.kernel.org/show_bug.cgi?id=2228 isn't spoken. Maybe the
bug can be fixed in dv1394 itself, or maybe we need to rework the
ieee1394 core's *_remove_host sequence.

Checking the 1394 driver stack's conduct during card hot-ejection is in
my long-term to-do list. Hopefully someone else can look at it sooner.
But I suggest you open a new bugzilla bug so we don't lose track.

I suppose the temporary workaround is to unload dv1394 before card ejection.

Thanks for this and the previous reports,
-- 
Stefan Richter
-=====-=-==- =--= -=---
http://arcgraph.de/sr/
