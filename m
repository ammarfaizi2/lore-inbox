Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267946AbUGaN2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267946AbUGaN2b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 09:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267945AbUGaN2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 09:28:31 -0400
Received: from web14928.mail.yahoo.com ([216.136.225.87]:33872 "HELO
	web14928.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267946AbUGaN23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 09:28:29 -0400
Message-ID: <20040731132828.39719.qmail@web14928.mail.yahoo.com>
Date: Sat, 31 Jul 2004 06:28:28 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20040731100318.GA1799@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Fri, Jul 30, 2004 at 02:53:25PM -0700, Jon Smirl wrote:
> > Here's another grungy thing I needed to do to PCI. Multi-headed
> video
> 
> You can do that, but where is the problem with your probe function
> being
> called twice - once for each of the devices? You should be able to
> sort
> out which one is which rather easily.

I wrote this a while ago, but I believe the problem was that by
accepting two probes I get two hotplug ADD events that I can't tell
apart. This scheme avoids triggering hotplug. The other problem was
that the ADD events get started in parallel and I couldn't figure out
how to serialize them. The parallel hotplug programs got into a race to
see who could initialize the card first.

Now that I know more about hotplug I could modify the hotplug
parameters to indicate primary vs secondary and ignore the secondary
one. But this will still cause two apps to be started in parallel. 

Another solution would be to modify the kernel API somehow to let me
suppress hotplug ADD/REMOVE on the secondary device.

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
