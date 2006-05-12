Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWELNw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWELNw6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWELNw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:52:58 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:52598 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932079AbWELNw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:52:58 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-pm@lists.osdl.org
Subject: Re: [linux-pm] Re: [PATCH/rfc] schedule /sys/device/.../power for removal
Date: Fri, 12 May 2006 06:52:53 -0700
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
References: <20060512100544.GA29010@elf.ucw.cz> <20060512031151.76a9d226.akpm@osdl.org>
In-Reply-To: <20060512031151.76a9d226.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605120652.55658.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 May 2006 3:11 am, Andrew Morton wrote:
> 
> What will be impacted by this?

Driver suspend/resume testing ... impact is strongly negative.

Without this interface, there is NO way to test individual drivers for
correct handling of suspend/resume calls; the only way to test drivers
is to suspend/resume the whole system, along with all other drivers in
the system.  Which means that ALL the drivers must work sanely before
tests for any one of them can succeed ... a losing model when you're
testing PM on new platforms.

Which IMO makes removing this a Bad Thing.  It needs to have some
kind of replacement in place before the "magic numbers" go away.

(The magic numbers are bad, and should go away -- yes.  Nobody has
really shown that userspace needs this mechanism for any purpose
other than driver testing.  Userspace device-specific power management
tools would need knowledge that's not yet exposed though sysfs.)

I think both Patrick Mochel and Alan Stern have sent patches at
various times to let individual drivers provide a list of named
states they support,  In some cases (like PCI) those lists could
be delegated to bus-specific code.

