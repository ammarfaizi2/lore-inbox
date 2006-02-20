Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161089AbWBTR7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbWBTR7K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161092AbWBTR7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:59:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161089AbWBTR7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:59:09 -0500
Date: Mon, 20 Feb 2006 18:58:42 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: greg@kroah.com, torvalds@osdl.org, akpm@osdl.org, linux-pm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH 3/5] [pm] Respect the actual device power states in sysfs interface
Message-ID: <20060220175842.GH19156@elf.ucw.cz>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net> <20060218155543.GE5658@openzaurus.ucw.cz> <Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net> <20060220000907.GE15608@elf.ucw.cz> <Pine.LNX.4.50.0602191611130.8676-100000@monsoon.he.net> <20060220002053.GF15608@elf.ucw.cz> <Pine.LNX.4.50.0602191628270.8676-100000@monsoon.he.net> <20060220004142.GI15608@elf.ucw.cz> <Pine.LNX.4.50.0602200938320.12708-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0602200938320.12708-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Compatibility is already restored.
> > >
> > > No, the interface is currently broken. The driver core does not
> > > dictate
> >
> > There were two different interfaces, one accepted 0 and 2, everything
> > else was invalid, and second accepted 0, 1, 2, 3.
> >
> > If you enter D2 on echo 2, you are breaking compatibility with 2.6.15
> > or something like that.
> 
> I don't see how this is true. If a process writes "2" to a PCI device's
> state file, what else are sane things to do?

In some kernel version (2.6.15, iirc), device entered D3 if you wrote
"2" to state file, and there are programs out there that depend on
it. And there are some older programs that write "3" and expect D3. So
this interface really needs to die.

> You dropped the fundamental point, and I don't understand why you disagree
> with it - the driver core should not be dictating policy to the downstream
> drivers. It is currently doing this by filtering the power state that is
> passed in via the "state" file.

That's best we can do to stay compatible. Please introduce new file,
and make states string-based.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
