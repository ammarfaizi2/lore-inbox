Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbTDNSru (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbTDNSql (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:46:41 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:42445 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263803AbTDNSq2 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 14:46:28 -0400
Date: Mon, 14 Apr 2003 12:00:32 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC] /sbin/hotplug multiplexor
Message-ID: <20030414190032.GA4459@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

With the advent of a lot of people wanting to use /sbin/hotplug to add
their own different types of functions, I want to propose the following
replacement for the current /sbin/hotplug:

-----
#!/bin/sh
DIR="/etc/hotplug.d"

for I in "${DIR}/"* ; do
	$I $1 &
done

exit 1
-----

Then all scripts/programs/whatever that wants to get called when
/sbin/hotplug goes off can add themselves to the /etc/hotplug.d
directory.

This should help solve the recent devlabel issue with the current
hotplug scripts, and allow things like udev to also watch all hotplug
actions.

Any objections or comments?  If not, I'll make the changes in the
linux-hotplug project and release a new version based on this.

Thanks to Martin Schwenke for giving me this idea (even if he doesn't
realize it :)

Note, this is only for the "big" hotplug versions that live on
everyone's disk.  I'm still advocating something small like a
combination of udev and dietHotplug for the initramfs image.

thanks,

greg k-h
