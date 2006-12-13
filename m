Return-Path: <linux-kernel-owner+w=401wt.eu-S932629AbWLMJTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbWLMJTv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 04:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWLMJTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 04:19:51 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:60078 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932629AbWLMJTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 04:19:50 -0500
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 04:19:49 EST
Subject: Re: [patch 2/3] acpi: Add a docked sysfs file to the dock driver.
From: Kay Sievers <kay.sievers@vrfy.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Jesse Barnes <jbarnes@virtuousgeek.org>, Holger Macht <hmacht@suse.de>,
       len.brown@intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, Brandon Philips <brandon@ifup.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20061212232638.GB4104@datenfreihafen.org>
References: <20061204224037.713257809@localhost.localdomain>
	 <20061211120508.2f2704ac.kristen.c.accardi@intel.com>
	 <20061212221504.GA4104@datenfreihafen.org>
	 <200612121431.11919.jbarnes@virtuousgeek.org>
	 <20061212150033.e3c7612f.kristen.c.accardi@intel.com>
	 <20061212232638.GB4104@datenfreihafen.org>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 10:14:15 +0100
Message-Id: <1166001255.5631.33.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4ddcc9dd12ba6cf3155e4d81b383efda
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 00:26 +0100, Stefan Schmidt wrote:
> On Tue, 2006-12-12 at 15:00, Kristen Carlson Accardi wrote:
> > 
> > I did have different dock/undock events a few months ago - but
> > after some discussion we scrapped them because Kay wants to avoid driver
> > specific events.  The "change" event is the only thing that makes sense,
> > given the set of uevents available right now, and userspace should be 
> > able to handle checking a file to get driver specific details (i.e. dock 
> > and undock status).  If you have a specific reason why this won't work,
> > let me know.
> 
> It's fine with me. I just find two different events more handy.
> Checking the file after the event in userspace should not be aproblem.

The thing is that we try to avoid driver-core "features" that are
specific to a single subsystem or driver.

You can easily add additional environment variables today, while sending
a "change"-event with kobject_uevent_env(), like
ACPI_DOCK={lock,unlock,insert,remove,...}. Just pass any driver-specific
string you like along with the event, and it will be available just like
the "action" string.

This should fit all requirements, without the need to introduce all
sorts of new generic action-strings, that can almost never be changed
later for compatibility reasons. That way, if "drivers" later find out,
that they need to send different actions/flags, they can just add as
many new strings as they like on top of the event. :)

Thanks,
Kay

