Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268702AbUIXMFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbUIXMFo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 08:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268703AbUIXMFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 08:05:44 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:47504 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S268702AbUIXMFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 08:05:41 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Jan Dittmer <jdittmer@ppp0.net>
Subject: Re: Is there a user space pci rescan method?
Date: Fri, 24 Sep 2004 14:12:44 +0200
User-Agent: KMail/1.7
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <200409241241.19654@bilbo.math.uni-mannheim.de> <4154083B.6040109@ppp0.net>
In-Reply-To: <4154083B.6040109@ppp0.net>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409241412.45204@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 24. September 2004 13:42 schrieben Sie:
> Rolf Eike Beer wrote:
> > Ok, here we go. This is my current diff that I use for my tests at home.
> > It adds dummyphp and cleans up fakephp a lot (read: kills it). Changes
> > from last version:
> >
> > -removed some dead comments
> > -removed some unused instructions
> > -reordered allocation in add_slot to do less memory allocations if there
> > is no device in slot
> > -changed param "usedonly" to "showunused" so it behaves like fakephp at
> > the first look: if you load dummyphp without parameters there are only
> > slots with devices in it.
> > -removed "DUMMY-" prefix to entries in /sys/bus/pci/slots/
> >
> > Please send comments so I can send it for inclusion soon.
>
> Well, first of all I think you should just submit a patch to add dummyphp
> and not removing fakephp in the same step. Also you somehow mis-copied the

I said it's my test diff and that I'll redo it for submission ;)

> patch to your mail app - most (not all) tabs are converted to one space (or
> is it just thunderbird displaying the mail?). Can you resend it? Then I'll

Yes, looks like KMail has eaten it. Hey KDE guys, is this intentional or was 
this my fault?

You can get it from http://opensource.sf-tec.de/kernel/fake_vs_dummy.diff

> give it a try. Greg wrote in another mail that the 'proper' way of
> 'powering up' device slots should be to rescan the entire bus. I don't
> know, your approach certainly seems easier, but you are bound to either
> display all pci slots which may come to live or just the ones in the system
> already, which means you cannot rescan slots which weren't equipped on boot
> up. So perhaps adding a rescan method to fakephp is indeed cleaner.

This is for simulating hotplug events. I don't know how there could be a slot 
where you put in a device that has not been there on system bootup. Ok, you 
can trigger such a case by disabling a slot, rmmod dummyphp, modprobe 
dummyphp again. Greg didn't like dummyphp to display all logical slots even 
if there is no device in them - which I can understand, under normal 
circumstances you will never have a use for this extra slots. If you want 
them just do "modprobe dummyphp showunused=1" and you'll get them all.

Normally you will just remove and bring back one or two cards in the system 
(e.g. your NIC or sound card, depending on xmms or irc being on top of your 
priority list *g*). So from my point of view it's a good idea to keep the 
slot dirs on remove so you can just go back in your command history and 
replace 0 with 1 to get the device back. I don't see why bus structure or 
whatever may ever change so rescanning the whole bus is IMHO a bit overkill.

Adding a rescan file is also extra work, the power file is there 
automagically ;)

Eike
