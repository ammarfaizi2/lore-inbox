Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264048AbUFCLyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbUFCLyt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 07:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbUFCLyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 07:54:49 -0400
Received: from [195.23.16.24] ([195.23.16.24]:2187 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S264048AbUFCLyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 07:54:46 -0400
Subject: Re: Dell TrueMobile 1150 PCMCIA/Orinoco/Yenta problem w/ 2.6.4/5
From: Paulo Marques <pmarques@grupopie.com>
Reply-To: pmarques@grupopie.com
To: Dax Kelson <dax@gurulabs.com>
Cc: Aaron Mulder <ammulder@alumni.princeton.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <1086245693.3772.42.camel@mentor.gurulabs.com>
References: <Pine.LNX.4.58.0406022305580.6314@saturn.opentools.org>
	 <1086245693.3772.42.camel@mentor.gurulabs.com>
Content-Type: text/plain
Organization: Grupo PIE
Message-Id: <1086263681.31212.24.camel@pmarqueslinux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 03 Jun 2004 12:54:41 +0100
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.25.0.61; VDF: 6.25.0.83; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-03 at 07:54, Dax Kelson wrote:
> On Wed, 2004-06-02 at 23:31 -0400, Aaron Mulder wrote:
> > 	I'm working with a Dell Inspiron 8200 laptop, and I've tried SuSE
> > 9.1 Pro (2.6.4-54.5) and Fedora Core 2 (2.6.5-x I think, but I'm on SuSE
> > now).  The laptop has 2 normal PCMCIA slots, and a Dell TrueMobile 1150
> > mini-PCI card, which is apparently implemented as a PCMCIA card in a 3rd
> > PCMCIA slot (handled by the orinoco_cs driver).

I had similar problems with a TI controller myself, until I upgraded to
kernel 2.6.6.

This entry in the 2.6.6 ChangeLog seems to have made the cure:

> <daniel.ritz@gmx.ch> 
> 	[PATCH] yenta: interrupt routing for TI briges
> 	
> 	Some TI cardbus bridges found in notebooks and PCI add-on cards are
> 	uninitialized.  This means the interrupt mode and the interrupt routing
> 	is wrong in most cases, ending up in non working PCI interrupts.
> 
> 	This makes the TI Yenta driver probe the PCI interrupt and adjust the
> 	interrupt setting if no interrupts are delivered.  It's done in a safe
> 	way, that doesn't hurt working setups.
> 	
> 	Function 1 on two slot devices is handled differently from function 0
> 	since both share the settings.

I hope this helps,

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

