Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUAHDoE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 22:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUAHDoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 22:44:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:55249 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263062AbUAHDoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 22:44:02 -0500
Date: Wed, 7 Jan 2004 19:43:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Greg KH <greg@kroah.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
In-Reply-To: <20040108043506.A1555@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.58.0401071941390.2131@home.osdl.org>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com>
 <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040108031357.A1396@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401071815320.12602@home.osdl.org> <20040108034906.A1409@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401071854500.2131@home.osdl.org> <20040108043506.A1555@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Jan 2004, Andries Brouwer wrote:
> 
> I am even happy in a somewhat more general situation that you are.
> If the kernel autopartitions (and make recognition of new partitions
> hotplug events so that udev can create the device nodes), all is well.

Yes. We _could_ do that, by just making a "we noticed the disk change" be
a hotplug event. However, I'm loath to do that, because some devices
literally don't even have an easily read disk change signal, so what they
do is

 - assume the disk _always_ changed on open
 - do a quick IO to verify it

and I'd be nervous about that kind of thing resulting in hotplug being 
called constantly if somebody rude just has an endless loop of 
"open()/close()".

		Linus
