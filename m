Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUEQNWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUEQNWb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 09:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUEQNWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 09:22:31 -0400
Received: from dingo.clsp.jhu.edu ([128.220.117.40]:384 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261232AbUEQNW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 09:22:29 -0400
Date: Sat, 15 May 2004 04:59:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Todd Poynor <tpoynor@mvista.com>
Cc: Greg KH <greg@kroah.com>, mochel@digitalimplant.org,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Hotplug events for system suspend/resume
Message-ID: <20040515025953.GA460@elf.ucw.cz>
References: <20040511010015.GA21831@dhcp193.mvista.com> <20040511230001.GA26569@kroah.com> <40A17251.2000500@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A17251.2000500@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I still do not see the need for this.  As a user, you caused the
> >suspend/resume event to happen, why get notified of it again?  :)
> 
> The idea is to notify the "power management application" of impending 
> suspend and just-completed resume, regardless of who or what asked for 
> the suspend.  Actions taken at suspend might include dropping network 
> connections and saving application state to stable storage.
> 
> The reasons for which this was requested of me as a kernel-to-userspace 
> notifier, that I am aware of, are:
> 
> (a) some embedded platforms currently trigger suspend within kernel 
> drivers (in response to a button press or some sort of device
>timeout).

I believe kernel should userspace "button was pressed", and let
userspace ask it for suspend.

> (b) the system designer wants to make sure certain actions are always 
> taken regardless of the interface used to suspend (not only in the case 
> of a certain application that incorporates these actions and triggers 
> the suspend via the standard interfaces at the appropriate time).  For 
> example, a user manually enters a command from a shell prompt.

User should not manually do "echo something > /proc/acpi/sleep". For
embedded platforms, it should be rather easy to ensure user does not
do that, right?

OTOH, it might make sense to define that /etc/rc.d/suspend/* has to be
run before suspend and /etc/rc.d/resume/* has to be run after suspend;
by whoever who does suspend.

suspend-vetoing is pretty bad idea if your battery is running down. I
believe shutdown does it right: kill -15 -1; sleep 1; kill -9
-1. I.e. let apps know one second before suspend, but do not let them
veto it.
								Pavel
-- 
When do you have heart between your knees?
