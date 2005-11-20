Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVKTUiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVKTUiR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 15:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVKTUiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 15:38:17 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:21406 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1750802AbVKTUiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 15:38:16 -0500
Date: Sun, 20 Nov 2005 21:16:12 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Fabio Erculiani <lxnay@lxnaydesign.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA] Enable debugging in userspace?
Message-ID: <20051120201611.GA7981@stiffy.osknowledge.org>
References: <200511202054.42479.lxnay@lxnaydesign.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511202054.42479.lxnay@lxnaydesign.net>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc1-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Fabio Erculiani <lxnay@lxnaydesign.net> [2005-11-20 20:54:42 +0100]:

> Today, one idea is floating around me and bugging my brain (read: headache).
> If I could be a newbie, and if I have a problem with the latest and greatest 
> linux distro, I start googling and looking for a solution. The problem is 
> that someone write that I have to enable debugging mode in kernel 
> configuration, recompile everything and reboot. That's quite impossible for a 
> newbie, isn't it?
> So, why don't add an option to enable/disable debugging mode in sysfs?
> 
> Like:
> 
> /* DEBUG MODE ON */
> echo "1" > /sys/kernel/debugging/debug_mode
> /* DEBUG MODE OFF */
> echo "0" > /sys/kernel/debugging/debug_mode
> 
> I know that debugging code might (remove "might") increase the kernel size, 
> but men, we have >256MB of RAM and >1GB of hard drive space.
> 

Fabio,

basically I would rate such a 'solution' a pro. But first a few cons
came up my mind:

1.) If you globally enable 'debug_mode' the user (and even more the
    newbie) is blown away by the enormous messages that would show up
    and thus these would be rendered useless in some way.
2.) The debug messages would appear 'just in time'. No matter, if they
    do because of a fault or just for informational purposes. How do you
    want to achieve to stack the messages i the right order for someone
    who does NOT deal with a system's internal to interpret these
    messages correctly? I mean, we're not talking about such stuff as 

	    usbcore: registered new driver usbmouse

    We're talking about stuff like

	    hub->hdev[XXX]: hub->status->hub = XXX,

    OK, anything my be tagged with the module the info comes from but
    this would mean a) enormous amount of work to do tagging the
    messages and b) implementing the messages that'll be thrown, when
    the debug_mode is enabled.
3.) It would be a rather optional thing as probs have been located using
    back- and calltrace + friends. Important errors or failures are
    reported in the logs nevertheless.
4.) Worse problems (besides stuff as 'My ACX100 Wireless adaptor does
    not work out of the box' are usually fixed by the distros people who
    know how to handle kernel bugs.

Regards,
	Marc
