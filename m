Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbUFEWeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUFEWeA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 18:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUFEWd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 18:33:59 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:62738 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262194AbUFEWdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 18:33:41 -0400
Date: Sun, 6 Jun 2004 00:36:13 +0200
To: Mikhail Kshevetskiy <kl@laska.dorms.spbu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: framebuffer trouble with AGP MGA G450 and PCI MGA 2064W videocards.
Message-ID: <20040605223613.GA3326@hh.idb.hist.no>
References: <20040605231251.1f584e87@laska>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040605231251.1f584e87@laska>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2004 at 11:12:51PM +0400, Mikhail Kshevetskiy wrote:
> i have two matrox videocard. The primary is dualhead AGP MGA G450 and the
> secondary is PCI MGA 2064W. I have a 2.6 kernel compiled with options
> 
> CONFIG_FB_MATROX=y
> CONFIG_FB_MATROX_MILLENIUM=y
> CONFIG_FB_MATROX_G450=y
> CONFIG_FB_MATROX_G100=y
> CONFIG_FB_MATROX_MULTIHEAD=y
> 
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_PCI_CONSOLE=y
> 
> In BIOS I select AGP card as primary, but framebuffer initialise PCI card
> first. So fb0 point to PCI card, fb1 and fb2 point to AGP card. As a
> result framebuffer console working on another monitor. How can I link fb0
> and fb1 with AGP card and fb2 with PCI card ?
> 
> Please CC me, as i am not subscribed to the list
> 
Several solutions:

1. Don't do it.
Is it really a problem? How about using fb1 when you want to use
the AGP card?


2. Use modules, and load the AGP module first.  It will then
grap fb0.  Then load the pci module, which becomes fb1



3. Use the flexibility that /dev offers. fb0 don't have to
be the first framebuffer, in other words:

cd /dev
mv fb0 temp
mv fb1 fb0
mv temp fb1

>From now on, the name "fb0" actually refer to the second framebuffer.
any program that wants "fb0" get the AGP card, even if it is
initialized last.

4. Or use udev to achieve the same as in (3).

Helge Hafting
