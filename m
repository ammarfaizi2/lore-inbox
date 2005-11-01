Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbVKAEjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbVKAEjt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 23:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbVKAEjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 23:39:49 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:14000 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932568AbVKAEjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 23:39:48 -0500
From: David Brownell <david-b@pacbell.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [linux-usb-devel] Re: Commit "[PATCH] USB: Always do usb-handoff" breaks my powerbook
Date: Mon, 31 Oct 2005 20:39:46 -0800
User-Agent: KMail/1.7.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-usb-devel@lists.sourceforge.net,
       Paul Mackerras <paulus@samba.org>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
References: <17253.43605.659634.454466@cargo.ozlabs.ibm.com> <200510311909.32694.david-b@pacbell.net> <BC88D0A1-453F-4716-96E6-3C89B915C477@mac.com>
In-Reply-To: <BC88D0A1-453F-4716-96E6-3C89B915C477@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200510312039.46646.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why should x86-specific-BIOS-USB-handoff-specific-crap-PCI-quirks be  
> even _compiled_ on PowerPC systems that have nothing remotely like  
> the affected hardware (BIOS & PS/2 serio chip)?

For starters, none of the controller specs say that the handshaking
is x86-specific.  There's a certain amount of "x86 Linux gets the
most testing" going on here.  Plus a lot of "nobody really used that
usb-handoff code before, except to fix semi-broken x86 systems".

One requirement coming from x86/DOS legacy support though is that the
system probably expects to "work like DOS" at various boot stages.
Hence the way some systems take kbd/mouse input from USB and jam it
through PS2 serio hardware, so DOS will see it.  Which is why x86
hardware generally _does_ need to use these handhaking mechanisms,
to kick the BIOS off the hardware.  (And why the USB folk have been
very used to telling folk to disable BIOS support for USB.  That's
fine advice unless you've got a USB keyboard or mouse.)


> The difference is, OpenFirmware is nice and clean and stops messing  
> with hardware before handing off to the new kernel. 

That's a nice design policy (IMO) but sometimes folk also like to
draw the firmware/OS boundary in different ways.

In any case ... let's all just blame this on DOS, and move on to
something that's not as twentieth-century.  :)

- Dave

