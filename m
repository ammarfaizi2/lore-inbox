Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965088AbWBGNzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbWBGNzL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbWBGNzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:55:10 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:34252 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S965088AbWBGNzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:55:09 -0500
Date: Tue, 7 Feb 2006 13:55:02 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] Add Dell laptop backlight brightness display
Message-ID: <20060207135502.GA2770@srcf.ucam.org>
References: <20060206191506.GA17395@srcf.ucam.org> <20060206191916.GB17460@srcf.ucam.org> <20060207003748.GA22510@srcf.ucam.org> <200602062237.55653.dtor_core@ameritech.net> <20060207123204.GA1423@srcf.ucam.org> <1139317605.6422.26.camel@localhost.localdomain> <20060207132334.GA2331@srcf.ucam.org> <1139319426.6422.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139319426.6422.42.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 01:37:06PM +0000, Richard Purdie wrote:
> On Tue, 2006-02-07 at 13:23 +0000, Matthew Garrett wrote:
> > Would you be open to adding generic support for displaying separate AC 
> > and DC brightnesses? Making it driver specific leaves the potential for
> > inconsistencies.
> 
> The problem is that AC or DC is not a generic property of backlights but
> specific to your problematic hardware case. You're going to have a to
> find a way to tell if its running on AC or not to report the right value
> in the manner the class requires.

Cases rather than case, sadly. Determining whether the hardware is on AC 
or not tends to be much more awkward than you'd think. On HPs, it seems 
to be done by making a specific call to the embedded controller. This is 
very model specific, whereas the brightness values aren't. It's also 
likely to go horribly wrong if the hardware is trying to access the 
embedded controller at the same time. Realistically, it's impossible 
without making the driver depend on ACPI and exporting acpi_ac_get_state 
from the ACPI layer, which would be a shame since the rest of the 
functionality isn't ACPI dependent at all.
 
> I can't see how you plan to add "generic support for displaying separate
> AC and DC brightnesses" without destroying the point of the class (which
> for the brightness parameter is to display the current backlight
> brightness).

I think providing a consistent interface for what information we can 
provide is worthwhile.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
