Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTFKU3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264436AbTFKU2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:28:46 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:60809 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264289AbTFKUX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:23:29 -0400
Date: Wed, 11 Jun 2003 22:36:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Messing up driver model API
Message-ID: <20030611203652.GA599@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

So you just had to mess it up... Having suspend(device *, state,
level) might be bad, but having suspend(device *, state, level) in one
piece of code and {suspend,save}(device *, state) is *way* worse. (And
I did not see any proposal on l-k. I hope I just missed it).

So are you going to revert it or convert whole driver model to use
{suspend,save}(device *, state)?
									Pavel

[driver model] Add save() and restore() methods for system device drivers. 

It turns out that at least some system device drivers need to allocate 
memory and/or sleep for one reason or another when either saving or 
restoring state. 

Instead of adding a 'level' paramter to the suspend() and resume() methods,
which I despise and think is a horrible programming interface, two new 
methods have been added to struct sysdev_driver:

        int     (*save)(struct sys_device *, u32 state);
        int     (*restore)(struct sys_device *);

that are called explicitly before and after suspend() and resume() 
respectively, with interrupts enabled. This gives the drivers the
flexibility to allocate memory and sleep, if necessary. 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
