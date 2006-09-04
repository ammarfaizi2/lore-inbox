Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWIDVQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWIDVQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 17:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWIDVQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 17:16:47 -0400
Received: from fremont.jonmasters.org ([64.71.152.22]:42762 "EHLO
	fremont.jonmasters.org") by vger.kernel.org with ESMTP
	id S1751482AbWIDVQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 17:16:45 -0400
From: Jon Masters <jonathan@jonmasters.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Victor Hugo <victor@vhugo.net>, linux-kernel@vger.kernel.org,
       Victor Castro <victorhugo83@yahoo.com>,
       Jon Masters <jcm@jonmasters.org>
In-Reply-To: <20060904140208.03880214.akpm@osdl.org>
References: <CB81ECDC-0B48-4BE4-B9C0-C1CDBEC0F739@vhugo.net>
	 <20060904140208.03880214.akpm@osdl.org>
Content-Type: text/plain
Organization: World Organi[sz]ation Of Broken Dreams
Date: Mon, 04 Sep 2006 22:16:38 +0100
Message-Id: <1157404599.9259.242.camel@perihelion>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 212.18.227.82
X-SA-Exim-Mail-From: jonathan@jonmasters.org
Subject: Re: [PATCH][RFC] request_firmware examples and MODULE_FIRMWARE
X-SA-Exim-Version: 4.2 (built Thu, 14 Apr 2005 16:52:54 +0000)
X-SA-Exim-Scanned: Yes (on fremont.jonmasters.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-04 at 14:02 -0700, Andrew Morton wrote:

> > Also, I'd like to comment on Jon Masters push to include the  
> > MODULE_FIRMWARE api addition.  I strongly believe that policy should  
> > not be included in driver code, in this case it's in the form of a  
> > filename.
> 
> You should have cc'ed him!  Some people are not subscribed, and few read
> it all.

Thanks. My lkml subscription bounced last week after I decided to
overhaul my home email (moving country in a couple of weeks...).

I disagree that MODULE_FIRMWARE encodes policy in the driver. It encodes
a reference - nothing more. We need to know what firmware we're going to
be asked for if we have any hope of being able to package up drivers for
use in distro initrds and the like. I think we can agree on that much.

Some alternatives:

* The firmware API get hacked yet again to use static strings we can
parse (ugly) or otherwise somehow provide this information.

* We add hacks in userspace "if it's this driver and someone used
MODULE_VERSION correctly, and we can determine the right firmware...".

> > The firmware loader currently needs a filename passed to it so it can  
> > then pass the $FIRMWARE environment variable to the hotplug script.   
> > This is ok if you provide a generic filename like "firmware.bin" and  
> > then let the hotplug script worry about version numbers, i.e.  
> > "firmware-x.y.z.bin"

> > MODULE_FIRMWARE should be used to provide the generic filenames and  
> > which order the files should be loaded (request_firmware can be  
> > called various times), but I think its bad to have to change the  
> > driver everytime a new firmware version is released.
> 
> Yes, that does sound bad, but what would I know ;)

I'm ok with the idea of having a generic name, but it does add more
processing in userspace. Frankly, I don't care what is adopted but
something needs to be done - sooner or later, it's going to be more
drivers than Qlogic (and a few others) we need this working for :-)

I'm optimistic that we'll find the right one line patch eventually!

Jon.


