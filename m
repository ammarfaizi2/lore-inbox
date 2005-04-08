Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVDHWZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVDHWZn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 18:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVDHWX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 18:23:56 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:54448 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261168AbVDHWVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 18:21:51 -0400
Message-ID: <425703F3.4050802@us.ibm.com>
Date: Fri, 08 Apr 2005 15:21:39 -0700
From: Vernon Mauery <vernux@us.ibm.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: set keyboard repeat rate: EVIOCGREP and EVIOCSREP
References: <4255B43F.80606@us.ibm.com>
In-Reply-To: <4255B43F.80606@us.ibm.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vernon Mauery wrote:
> I was wondering if anyone knows how to change the repeatrate on a USB keyboard with a 2.4 kernel.  The system is a legacy free system (no ps2 port), so kbdrate does nothing.  With evdev loaded, the keyboard and mouse (both USB devices) get registered with the event system and show up as /dev/input/event[01].  I know the event subsystem does software key repeating and was wondering how to change that.
> 
> I poked around and found the EVIOCGREP and EVIOCSREP ioctls, but when I tried using them, the ioctl returned invalid parameter.  Upon further investigation, I found that the ioctl definitions (located in the linux/input.h header file) are not used in kernel land.  That would explain why it failed, but that just means I ran into a dead end.  Were those definitions legacy code from 2.2 or is it something that never got implemented, only defined?  I also noticed that the defines are gone in 2.6.  So how _does_ one go about changing the repeat rate on a keyboard input device in 2.4?
> 

Just in case anyone cares, I spent some more time poking around in the event code and it looks like the way to do this seems to be exposed by the evdev module.  If you write to /dev/input/eventX an input_event that contains an event of type EV_REP with either REP_DELAY or REP_PERIOD as the code and a value in milliseconds, I think it is supposed to set up the software auto repeat for you.  But with the atkbd driver, you have to turn off hardware auto repeat for this to take effect.  

--Vernon
