Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266400AbUAIBUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 20:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266414AbUAIBUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 20:20:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:38024 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266400AbUAIBUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 20:20:04 -0500
Date: Thu, 8 Jan 2004 16:52:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Robert Love <rml@ximian.com>
cc: Andries Brouwer <aebr@win.tue.nl>, Greg KH <greg@kroah.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
In-Reply-To: <1073608126.1228.16.camel@localhost>
Message-ID: <Pine.LNX.4.58.0401081649350.26682@evo.osdl.org>
References: <200401012333.04930.arvidjaar@mail.ru>  <20040103055847.GC5306@kroah.com>
  <Pine.LNX.4.58.0401071036560.12602@home.osdl.org>  <20040108031357.A1396@pclin040.win.tue.nl>
  <Pine.LNX.4.58.0401071815320.12602@home.osdl.org>  <20040108034906.A1409@pclin040.win.tue.nl>
  <Pine.LNX.4.58.0401071854500.2131@home.osdl.org>  <20040108043506.A1555@pclin040.win.tue.nl>
  <Pine.LNX.4.58.0401071941390.2131@home.osdl.org> <1073608126.1228.16.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Jan 2004, Robert Love wrote:
> 
> I like the idea of a hotplug event on media change (basically, a hotplug
> event for partitions).  And, in fact, I am loath not to do it.

The thing is, you won't actually get a "media changed" event with almost 
any normal hardware. 

What you will get is "somebody tried to open the media, and we realized 
that it has changed since the last open".

> The current direction with the kernel and udev is letting us move _away_
> from polling.

.. but this isn't actually the case for media change. You'd still not get 
the media change when the change _occurs_. You'd only get it much later.

> But I hear you loud and clear about dumb devices that cannot detect
> media change.  They pose a problem.

No, even the smart devices pose a problem - but at least for those the 
test whether the media has changed is pretty simple. 

The really _dumb_ devices just assume the media has changed every time the 
device is opened.

			Linus
