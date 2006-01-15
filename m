Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWAOPpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWAOPpi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 10:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWAOPph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 10:45:37 -0500
Received: from mx1.rowland.org ([192.131.102.7]:3087 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S932081AbWAOPpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 10:45:35 -0500
Date: Sun, 15 Jan 2006 10:45:33 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Walt H <walt_h@lorettotel.net>
cc: David Brownell <david-b@pacbell.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       <dmitry.torokhov@qmail.com>, <vojtech@suse.cz>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
In-Reply-To: <43C950B4.6020801@lorettotel.net>
Message-ID: <Pine.LNX.4.44L0.0601151039230.4197-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2006, Walt H wrote:

> OK.  No lines reporting handoff problems in any of the boots.  The only 
> boot in which I still have a keyboard is when I comment out the OHCI 
> handoff.  I saved dmesg's of all boots, and ran diffs against them.  The 
> uncommented handoffs and the EHCI commented handoff are essentially the 
> same (where the OHCI handoff code still executes in both).  The relevant 
> (diff'd) sections are:
> 
> @@ -153,3 +153,2 @@
> -i8042.c: Can't read CTR while initializing i8042.
> -pnp: Device 00:09 does not supported disabling.
> -pnp: Device 00:08 does not supported disabling.
> +serio: i8042 AUX port at 0x60,0x64 irq 12
> +serio: i8042 KBD port at 0x60,0x64 irq 1
> @@ -219,0 +219 @@
> +input: AT Translated Set 2 keyboard as /class/input/input0
> @@ -234,0 +235 @@
> +input: PS/2 Generic Mouse as /class/input/input1
> @@ -268 +269 @@
> -input: Logitech USB Mouse as /class/input/input0
> +input: Logitech USB Mouse as /class/input/input2
> 
> Hope that helps,

That's good; you've narrowed it down to the OHCI handoff.

Now try editing the quirk_usb_handoff_ohci() routine.  There's the section 
enclosed in "#ifndef __hppa__" and the two writel() calls after it.  Add 
printk statements to see which writes are taking place, try commenting out 
some of the writes -- in general, see what makes a difference.

Unfortunately I can't give you any detailed suggestions because I don't 
know how the hardware is supposed to work.

Alan Stern

