Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268832AbUIXPQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268832AbUIXPQv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 11:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268819AbUIXPNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 11:13:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:54913 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268851AbUIXPH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 11:07:27 -0400
Date: Fri, 24 Sep 2004 07:55:42 -0700
From: Greg KH <greg@kroah.com>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Jan Dittmer <jdittmer@ppp0.net>, linux-kernel@vger.kernel.org,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: Is there a user space pci rescan method?
Message-ID: <20040924145542.GA17147@kroah.com>
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <200409241412.45204@bilbo.math.uni-mannheim.de> <41541009.9080206@ppp0.net> <200409241432.06748@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409241432.06748@bilbo.math.uni-mannheim.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 02:32:06PM +0200, Rolf Eike Beer wrote:
> Am Freitag, 24. September 2004 14:16 schrieben Sie:
> > Rolf Eike Beer wrote:
> > > Normally you will just remove and bring back one or two cards in the
> > > system (e.g. your NIC or sound card, depending on xmms or irc being on
> > > top of your priority list *g*). So from my point of view it's a good idea
> > > to keep the slot dirs on remove so you can just go back in your command
> > > history and replace 0 with 1 to get the device back. I don't see why bus
> > > structure or whatever may ever change so rescanning the whole bus is IMHO
> > > a bit overkill.
> >
> > My point was, I load dummyphp with showunused=0 and only get dirs for the
> > slots with devices in them. Now I decide to put a network card (or whatever
> > I have to spare) in an empty slot, hope that the system doesn't reboot
> > immediately, and voila I don't have any /sys/bus/pci/slots dir to enable
> > the slot and have to reboot nevertheless. Or does the pci system a rescan
> > if I reinsert the module?
> 
> In this case you have to "rmmod dummyphp; modprobe dummyphp showunused=1" to 
> get all slots and try to enable the device. We have tested it once with a 
> special PCI debugging board where we can electrically disable the PCI bus so 
> we don't kill our hardware. The problem was that on reenabling a interrupt 
> storm killed the machine, I don't remember the exact problem. IIRC it looked 
> like the kernel found the device but the PCI bridge got confused by the new 
> device (or something like this). I don't know if there is a way to survive 
> this situation as the bridges in "normal" hardware are not hotplug aware. 
> Greg?

Hm, don't know, but that's the whole reason people want this, so it
should work :)

The main reason I don't like showing _all_ possible pci devices like
dummyphp does is that it doesn't handle adding a new device (like you
just said), and the fact that you forgot to handle pci domains.  If you
add support for PCI domains, then the list of files in that directory
will pretty much be unusable.

Please just add the "rescan" support to fakephp, and everyone will be
happy...

thanks,

greg k-h
