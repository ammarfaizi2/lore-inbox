Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUHCIMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUHCIMp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 04:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUHCIMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 04:12:45 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:18670 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S265230AbUHCIMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 04:12:34 -0400
Date: Tue, 3 Aug 2004 10:11:34 +0200
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] 2.6.8-rc2-mm2 with usb and input problems
Message-ID: <20040803081134.GA13745@gamma.logic.tuwien.ac.at>
References: <20040802162845.GA24725@gamma.logic.tuwien.ac.at> <200408021003.42090.david-b@pacbell.net> <20040802171325.GA26949@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040802171325.GA26949@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, hi lists!

(Taking Andrew and Dmitry off private email, this concerns only usb I
guess)

On Mon, 02 Aug 2004, preining wrote:
> > > - USB deadlocking
> > >   USB is still deadlocky, quite often process hang in D+ state.
> > 
> > So what does alt-sysrq-t show you about those processes?

Ok, I turned off hotplug, started it by hand and found what is making
the troubles:

First, it is cups, when trying the backend usb/canon/epson accessing the
usb subsystem. So I turned this of.

Then I tried lsusb, which hang, here is what sysrq-t says:
lsusb         D C0158CDC     0  3942   3849                     (NOTLB)
d648cef4 00200086 c1621800 c0158cdc 00000000 08088000 d39ce300 00000001 
       6e50f578 00000028 d427a7f4 df4cf824 00200296 d648c000 d427a650 c02d3f5f 
       df4cf82c 00000001 d427a650 c0118cf9 df4cf82c df4cf82c d687fd40 e08e0798 
Call Trace:
 [<c0158cdc>] link_path_walk+0xa1f/0xd4e
 [<c02d3f5f>] __down+0x8b/0x116
 [<c0118cf9>] default_wake_function+0x0/0xc
 [<e08e0798>] usbdev_open+0x54/0xfa [usbcore]
 [<c02d4144>] __down_failed+0x8/0xc
 [<e08e26ba>] .text.lock.devio+0x5/0xff [usbcore]
 [<c014ba8b>] filp_open+0x4c/0x4e
 [<c014c62d>] vfs_read+0xa9/0xf5
 [<c014c846>] sys_read+0x38/0x59
 [<c0105e4f>] syscall_call+0x7/0xb

Does this help you. lsusb is in D+ state.

SOmething similar happened when I tried to remove usbhid, or anything
else related to usb.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
HOGGESTON (n.)
The action of overshaking a pair of dice in a cup in the mistaken
belief that this will affect the eventual outcome in your favour and
not irritate everyone else.
			--- Douglas Adams, The Meaning of Liff
