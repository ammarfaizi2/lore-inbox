Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751882AbWJIOZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbWJIOZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbWJIOZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:25:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6404 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1751882AbWJIOZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:25:56 -0400
Date: Sun, 8 Oct 2006 18:42:31 +0000
From: Pavel Machek <pavel@suse.cz>
To: Stefan Seyfried <seife@suse.de>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-acpi@intel.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] preserve correct battery state through suspend/resume cycles
Message-ID: <20061008184230.GC4033@ucw.cz>
References: <Pine.LNX.4.64.0609280446230.22576@twin.jikos.cz> <20060930114817.GA26217@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060930114817.GA26217@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > boot -> suspend -> (un)plug battery -> resume
> > 
> > The problem arises in both cases - i.e. suspend with battery plugged in, 
> > and resume with battery unplugged, or vice versa.
> > 
> > After resume, when the battery status has changed (plugged in -> unplegged 
> > or unplugged -> plugged in) during the time when the system was sleeping, 
> > the /proc/acpi/battery/*/* is wrong (showing the state before suspend, not 
> > the current state).
> 
> Is this also needed if you use "platform" method? Also with suspend-to-RAM?
> 
> > The following patch adds ->resume method to the ACPI battery handler, which
> > has the only aim - to check whether the battery state has changed during sleep, 
> > and if so, update the ACPI internal data structures, so that information 
> > published through /proc/acpi/battery/*/* is correct even after suspend/resume
> > cycle, during which the battery was removed/inserted.
> 
> Although it generally is a good idea to add suspend and resume methods to
> all ACPI drivers, it would be interesting to know if you still need this
> when using the correct method (platform) instead of the incorrect default
> method (shutdown).
> 
> echo "platform" > /sys/power/disk
> echo "disk" > /sys/power/state

Maybe we should change the default in 2.6.20 or so?

-- 
Thanks for all the (sleeping) penguins.
