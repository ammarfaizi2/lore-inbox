Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbUAHIBd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 03:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbUAHIBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 03:01:33 -0500
Received: from AGrenoble-101-1-4-93.w217-128.abo.wanadoo.fr ([217.128.202.93]:27559
	"EHLO awak.dyndns.org") by vger.kernel.org with ESMTP
	id S263537AbUAHIBa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 03:01:30 -0500
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Greg KH <greg@kroah.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0401071941390.2131@home.osdl.org>
References: <200401012333.04930.arvidjaar@mail.ru>
	 <20040103055847.GC5306@kroah.com>
	 <Pine.LNX.4.58.0401071036560.12602@home.osdl.org>
	 <20040108031357.A1396@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0401071815320.12602@home.osdl.org>
	 <20040108034906.A1409@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0401071854500.2131@home.osdl.org>
	 <20040108043506.A1555@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0401071941390.2131@home.osdl.org>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1073548840.6189.144.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 08 Jan 2004 09:00:41 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 08/01/2004 à 04:43, Linus Torvalds a écrit :
> On Thu, 8 Jan 2004, Andries Brouwer wrote:
> > 
> > I am even happy in a somewhat more general situation that you are.
> > If the kernel autopartitions (and make recognition of new partitions
> > hotplug events so that udev can create the device nodes), all is well.
> 
> Yes. We _could_ do that, by just making a "we noticed the disk change" be
> a hotplug event. However, I'm loath to do that, because some devices
> literally don't even have an easily read disk change signal, so what they
> do is
> 
>  - assume the disk _always_ changed on open
>  - do a quick IO to verify it
> 
> and I'd be nervous about that kind of thing resulting in hotplug being 
> called constantly if somebody rude just has an endless loop of 
> "open()/close()".

Theses devices are kind of broken anyway, aren't they ? I see no safe
way of handling disk changes on them, except having a "I changed disk in
this drive" button on the desktop and rely on the user's good behavior.
Currently the kernel will may have a wrong idea of what's in the drive
if it doesn't poll, and that may wreak havoc.

	Xav

