Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268711AbUIXMZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268711AbUIXMZD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 08:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268713AbUIXMZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 08:25:03 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:40087 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S268711AbUIXMY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 08:24:59 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Jan Dittmer <jdittmer@ppp0.net>
Subject: Re: Is there a user space pci rescan method?
Date: Fri, 24 Sep 2004 14:32:06 +0200
User-Agent: KMail/1.7
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <200409241412.45204@bilbo.math.uni-mannheim.de> <41541009.9080206@ppp0.net>
In-Reply-To: <41541009.9080206@ppp0.net>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409241432.06748@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 24. September 2004 14:16 schrieben Sie:
> Rolf Eike Beer wrote:
> > Normally you will just remove and bring back one or two cards in the
> > system (e.g. your NIC or sound card, depending on xmms or irc being on
> > top of your priority list *g*). So from my point of view it's a good idea
> > to keep the slot dirs on remove so you can just go back in your command
> > history and replace 0 with 1 to get the device back. I don't see why bus
> > structure or whatever may ever change so rescanning the whole bus is IMHO
> > a bit overkill.
>
> My point was, I load dummyphp with showunused=0 and only get dirs for the
> slots with devices in them. Now I decide to put a network card (or whatever
> I have to spare) in an empty slot, hope that the system doesn't reboot
> immediately, and voila I don't have any /sys/bus/pci/slots dir to enable
> the slot and have to reboot nevertheless. Or does the pci system a rescan
> if I reinsert the module?

In this case you have to "rmmod dummyphp; modprobe dummyphp showunused=1" to 
get all slots and try to enable the device. We have tested it once with a 
special PCI debugging board where we can electrically disable the PCI bus so 
we don't kill our hardware. The problem was that on reenabling a interrupt 
storm killed the machine, I don't remember the exact problem. IIRC it looked 
like the kernel found the device but the PCI bridge got confused by the new 
device (or something like this). I don't know if there is a way to survive 
this situation as the bridges in "normal" hardware are not hotplug aware. 
Greg?

If there is a way I will try to impleement it, but for now this is beyound my 
knowledge.

Eike
