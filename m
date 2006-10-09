Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751900AbWJIWw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbWJIWw1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 18:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbWJIWw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 18:52:27 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:406 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751900AbWJIWw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 18:52:26 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] preserve correct battery state through suspend/resume cycles
Date: Tue, 10 Oct 2006 00:52:09 +0200
User-Agent: KMail/1.9.1
Cc: Stefan Seyfried <seife@suse.de>, Jiri Kosina <jikos@jikos.cz>,
       linux-acpi@intel.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>
References: <Pine.LNX.4.64.0609280446230.22576@twin.jikos.cz> <20060930114817.GA26217@suse.de> <20061008184230.GC4033@ucw.cz>
In-Reply-To: <20061008184230.GC4033@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610100052.10008.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 8 October 2006 20:42, Pavel Machek wrote:
> Hi!
> 
> > > boot -> suspend -> (un)plug battery -> resume
> > > 
> > > The problem arises in both cases - i.e. suspend with battery plugged in, 
> > > and resume with battery unplugged, or vice versa.
> > > 
> > > After resume, when the battery status has changed (plugged in -> unplegged 
> > > or unplugged -> plugged in) during the time when the system was sleeping, 
> > > the /proc/acpi/battery/*/* is wrong (showing the state before suspend, not 
> > > the current state).
> > 
> > Is this also needed if you use "platform" method? Also with suspend-to-RAM?
> > 
> > > The following patch adds ->resume method to the ACPI battery handler, which
> > > has the only aim - to check whether the battery state has changed during sleep, 
> > > and if so, update the ACPI internal data structures, so that information 
> > > published through /proc/acpi/battery/*/* is correct even after suspend/resume
> > > cycle, during which the battery was removed/inserted.
> > 
> > Although it generally is a good idea to add suspend and resume methods to
> > all ACPI drivers, it would be interesting to know if you still need this
> > when using the correct method (platform) instead of the incorrect default
> > method (shutdown).
> > 
> > echo "platform" > /sys/power/disk
> > echo "disk" > /sys/power/state
> 
> Maybe we should change the default in 2.6.20 or so?

Well, I think swsusp should work with "shutdown" just as well.  If it doesn't,
that means there are some bugs in the ACPI code which should be fixed.
By using "platform" as the default method we'll be hiding those bugs IMHO.

OTOH that may be desirable. ;-)

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
