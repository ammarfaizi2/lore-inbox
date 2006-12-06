Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937830AbWLGAWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937830AbWLGAWS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 19:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937832AbWLGAWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 19:22:18 -0500
Received: from attila.bofh.it ([213.92.8.2]:53480 "EHLO attila.bofh.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937830AbWLGAWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 19:22:18 -0500
Date: Thu, 7 Dec 2006 00:56:21 +0100
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.19-rc6] fix hotplug for legacy platform drivers
Message-ID: <20061206235621.GB25272@bongo.bofh.it>
References: <20061122135948.GA7888@bongo.bofh.it> <200612041828.01381.david-b@pacbell.net> <20061205100152.GB5805@bongo.bofh.it> <200612051603.09649.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612051603.09649.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 06, David Brownell <david-b@pacbell.net> wrote:

> > Please explain in more details how hotplugging would be broken, possibly
> > with examples.
> First, for reference, I refer to hotplugging using the trivial ASH scripts
> from [1], updated by removing no-longer-needed special cases for platform_bus
> (that original logic didn't work sometimes) and pcmcia.  See the (short)
I.e. a quick hack which has never been used by any distribution.
And anyway some kernel component is supposed to provide the aliases
pointing from the $MODALIAS values to the drivers, so modprobe $MODALIAS
would still work.

> Those scripts have supported hotplug and coldplug on several embedded boards
> for some time now.
Can you mention some?

> Second, note that you're asking me to construct a straw man for you and
> then break it down, since nobody arguing with the $SUBJECT patch has ever
> provided a complete counter-proposal (much less respond to the points
> I've made about legacy driver bugginess -- which is suggestive).
I am asking what is the point for a module to provide its own name in
$MODALIAS. You say that not doing this would break your custom hotplug
subsystem, but you still have not explained how this would happen since
$MODALIAS is available only *after* the module has been loaded by
something else.

> And "udev" was from day one supposed to solve  a different problem
> than "loading modules".  There was to be a clear and strong separation
> of roles between hotplug (load modules, don't rely on sysfs, use other
> components for the rest of device setup) and udev (make /dev nodes,
> ok to rely on sysfs).  That is, "udev" wouldn't do any loading.
Who cares? It does now, and for many good reasons.

-- 
ciao,
Marco
