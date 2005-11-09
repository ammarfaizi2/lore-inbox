Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030570AbVKIR13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030570AbVKIR13 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030578AbVKIR12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:27:28 -0500
Received: from tim.rpsys.net ([194.106.48.114]:63433 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1030570AbVKIR11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:27:27 -0500
Subject: Re: [patch] Re: 2.6.14-rc5-mm1 - ide-cs broken!
From: Richard Purdie <rpurdie@rpsys.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       damir.perisa@solnet.ch, akpm@osdl.org,
       Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <437226B2.10901@tmr.com>
References: <20051103220305.77620d8f.akpm@osdl.org>
	 <20051104071932.GA6362@kroah.com>
	 <1131117293.26925.46.camel@localhost.localdomain>
	 <20051104163755.GB13420@kroah.com>
	 <1131531428.8506.24.camel@localhost.localdomain>  <437226B2.10901@tmr.com>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 17:27:01 +0000
Message-Id: <1131557221.8506.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 11:41 -0500, Bill Davidsen wrote:
> Richard Purdie wrote:
> > This patch stops CompactFlash devices being marked as removable. They
> > are not removable (as defined by Linux) as the media and device are 
> > inseparable. When a card is removed, the whole device is removed from 
> > the system and never sits in a media-less state.
> 
> Having used CF devices for some years (since RH 8.0) I'm not sure what 
> problem you're addressing here. Could you describe what problem you're 
> having, and also note what current functionality this will change?

I'll try the explanation once more assuming you failed to understand the
previous messages in this thread and those linked to in the link I
provided to a thread about this.

Block devices have a "removable" flag. This flag is defined to indicate
devices where the media can change. A property of these devices is that
the device node and device stay around and media may or may not be
present at any one time. Examples of such devices are floppy and ide cd
drives.

When you remove a CF card, the controller is removed with the card and
nothing to do with the CF card or the device exists anymore. They are
therefore not removable devices in the linux definition of the term.

Currently the removable flag is set for CF cards. This is incorrect as a
CF device and interface either exists or doesn't. There is no media-less
state.

This incorrect setting causes loops with udev scripts requiring
userspace hacks to stop things looping. 

The patch therefore correctly sets the removable flag and removes some
unneeded code. 

This shouldn't break anything in userspace apart from anything that
incorrectly interprets the removable flag as being something its not.

Richard

