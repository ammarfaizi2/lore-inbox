Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWJJMhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWJJMhG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWJJMhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:37:06 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:17564 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964902AbWJJMhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:37:02 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH] preserve correct battery state through suspend/resume cycles
Date: Tue, 10 Oct 2006 14:37:17 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, Jiri Kosina <jikos@jikos.cz>,
       linux-acpi@intel.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>
References: <Pine.LNX.4.64.0609280446230.22576@twin.jikos.cz> <200610100052.10008.rjw@sisk.pl> <20061010121045.GQ19765@suse.de>
In-Reply-To: <20061010121045.GQ19765@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610101437.18219.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 10 October 2006 14:10, Stefan Seyfried wrote:
> On Tue, Oct 10, 2006 at 12:52:09AM +0200, Rafael J. Wysocki wrote:
> > On Sunday, 8 October 2006 20:42, Pavel Machek wrote:
>  
> > > > echo "platform" > /sys/power/disk
> > > > echo "disk" > /sys/power/state
> > > 
> > > Maybe we should change the default in 2.6.20 or so?
> > 
> > Well, I think swsusp should work with "shutdown" just as well.  If it doesn't,
> > that means there are some bugs in the ACPI code which should be fixed.
> > By using "platform" as the default method we'll be hiding those bugs IMHO.
> 
> I'm not really intimately familiar with the ACPI spec, but IIRC those AML
> methods executed by pm_ops->prepare and pm_ops->finish are mandatory for
> suspending ACPI enabled machines. So using "platform" as a default seems
> reasonable (assuming that on non-ACPI machines, pm_ops->{prepare,finish} will
> be a noop anyway)

Well, what swsusp does is not really a suspend operation.  It is, roughly, a
"save the contents of memory and power off" thing.  During the "resume" we do
something like "restore the contents of memory and use it as the initial
data", but the state of devices (ie. hardware) is not expected to be saved.

Moreover, I'm starting to think that it's actually wrong to assume that the
hardware state will be saved and the drivers that make such an assumption
need fixing.


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
