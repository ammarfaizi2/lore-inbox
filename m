Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263054AbTI2WLV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 18:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbTI2WLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 18:11:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:45001 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263054AbTI2WLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 18:11:18 -0400
Date: Mon, 29 Sep 2003 15:11:13 -0700
From: Greg KH <greg@kroah.com>
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, scottm@somanetworks.com,
       rgooch@atnf.csiro.au, mingo@redhat.com, pavel@suse.cz
Subject: Re: 2.6.0-test6: a few __init bugs
Message-ID: <20030929221113.GB2720@kroah.com>
References: <1064872693.5733.42.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064872693.5733.42.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 02:58:12PM -0700, Robert T. Johnson wrote:
> ** Possible bug:
> ** drivers/pci/quirks.c:asus_hides_smbus_hostbridge()                  (__init)
>    in table: drivers/pci/quirks.c:pci_fixups                           (not __init)
>      indirect call f->hook(): drivers/pci/quirks.c:pci_do_fixups()     (not __init)
>        called by: drivers/pci/quirks.c:pci_fixup_device()              (not __init)
>          called by: drivers/pci/probe.c:pci_scan_slot()                (not __init)
>            called by lots of hotplug enable() functions, e.g.
>            drivers/pci/hotplug/ibmphp_core.c:ibm_configure_device()    (not __init)
>              called by drivers/pci/hotplug/ibmphp_core.c:enable_slot() (not __init)
> 
> Note: It looks like this may have been originally designed to initialize the
>       pci bus at startup, but has been re-used in the hotplug code, which means it 
>       can be run after the __init segments have gone away.
> 
> Fix: Delete all the __init declarations on the quirks hooks.

No, this was discussed a lot a year or so ago.  We don't currently have
anything in the quirks table that can be hotplug added as far as I know.
So it's safe for us to throw those quirk entries away.

Yeah, it doesn't make automated test tools easy for this case, sorry.

Hope this helps.

greg k-h

