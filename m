Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUHBRIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUHBRIo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 13:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUHBRIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 13:08:44 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:18414 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S266663AbUHBRIe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 13:08:34 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.8-rc2-mm2 with usb and input problems
Date: Mon, 2 Aug 2004 10:03:42 -0700
User-Agent: KMail/1.6.2
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>
References: <20040802162845.GA24725@gamma.logic.tuwien.ac.at>
In-Reply-To: <20040802162845.GA24725@gamma.logic.tuwien.ac.at>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408021003.42090.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 August 2004 09:28, Norbert Preining wrote:

> - USB deadlocking
>   USB is still deadlocky, quite often process hang in D+ state.

So what does alt-sysrq-t show you about those processes?
How do you reproduce these hangs?  I'm guesssing that
And does 2.6.8-rc (without the MM patch) acts the same.

 
> - psmouse/synaptics
>   If I have usb as module, I cannot get synaptics to be recognized.

Odd.  BIOS settings maybe?

>    (or is a modular USB not necessary for S2R now that
>   we have CONFIG_USB_SUSPEND?)

The S2R issue is caused by delivering bogus PCI
device power states to PCI drivers.  See if the patch
in http://bugme.osdl.org/show_bug.cgi?id=2886
helps at all.  (It might be better to map STANDBY
to D0 state, so long as nobody's actually checking
PCI config space there to see if D1 or D2 works.)

If you don't actually have code trying to suspend
USB devices, don't enable it.  Until some other
issues in the PM core get resolved (notably its
eagerness to self-deadlock) that's purely for use
by developers.

- Dave
