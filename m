Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263752AbUGFKcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbUGFKcb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 06:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbUGFKcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 06:32:31 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:15632 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S263752AbUGFKc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 06:32:28 -0400
Date: Tue, 6 Jul 2004 12:32:09 +0200
To: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Synaptics not working with 2.6.7-mm6 (usb fixed)
Message-ID: <20040706103209.GA8662@gamma.logic.tuwien.ac.at>
References: <20040705131002.GA14768@gamma.logic.tuwien.ac.at> <20040705123243.7527e923.akpm@osdl.org> <20040705131002.GA14768@gamma.logic.tuwien.ac.at> <20040705134723.GA17146@gamma.logic.tuwien.ac.at> <200407050926.08739.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040705123243.7527e923.akpm@osdl.org> <200407050926.08739.dtor_core@ameritech.net>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, hi Dmitry!

Some more information on the Oops, a second Oops with bkusb and
usb-locking-fix reverted 

On Mon, 05 Jul 2004, Dmitry Torokhov wrote:
> > input: SynPS/2 Synaptics TouchPad on isa0060/serio1
> 
> Try making psmouse modular as well and load it _after_ all USB stuff is
> loaded - you may be having issues with USB Legacy emulation.

Ok, this has fixed it. At least the other way round: compiling in the
basic usb stuff and psmouse did the trick in -mm6, too.


On Mon, 05 Jul 2004, Andrew Morton wrote:
> > With 2.6.7-mm6 my laptop stops working completely. Ooops while booting.
> > 
> > Reverting
> > - usb-locking-fix.patch
> > - bk-usb.patch
> > makes it work.
> 
> OK.
> 
> > Yre you interested in the output of the kernel oops? I could recompile
> > the `bad' kernel and copy the Oops by hand from the screen.
> 
> Yes, please.

Attached is:
	- config-2.6.7-mm6
		the config file for both runs
The following oops files were created with FULL mm6:
	- dmesg.mm6.oops
		the dmesg output together with the oops
	- ksymoops.mm6.txt
		the output of ksymoops on the above file
There is another Oops with bk-usb and usb-locking-fix reverted:
	- ksymoops.mm6.2nd.txt

> - Revert the USB patches
> - boot, record the `dmesg -s 1000000' output
> - revert bk-input.patch, see if that fixess the touchpad.
> - if it does, capture the `dmesg -s 1000000' output again.

I leave this out for now as it works when compiling in input,usb,psmouse
etc.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
I teleported home one night
With Ron and Sid and Meg.
Ron stole Meggie's heart away
And I got Sidney's leg.
                 --- A poem about matter transference beams.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
