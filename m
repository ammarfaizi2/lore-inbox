Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbTL1CTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 21:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbTL1CTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 21:19:15 -0500
Received: from imf20aec.mail.bellsouth.net ([205.152.59.68]:17911 "EHLO
	imf20aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S264919AbTL1CTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 21:19:14 -0500
Subject: Re: [ANNOUNCE] udev 011 release
From: Rob Love <rml@ximian.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031228020449.GA26527@werewolf.able.es>
References: <20031225005614.GA18568@kroah.com>
	 <20031228020449.GA26527@werewolf.able.es>
Content-Type: text/plain
Message-Id: <1072577823.4042.3.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sat, 27 Dec 2003 21:19:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-27 at 21:04, J.A. Magallon wrote:

> This means that it will try to run, for example, gpm before the device for
> the mouse is created (as I said, if you booted with an empty /dev you want
> to populate with device nodes).

Yah, I guess it ought to go lower, so long as sysfs is sufficiently
mounted before it runs.

The reason I put it at 20 was that it really does not matter.  udev is
not a functional replacement for a static /dev while we do not have
initramfs.  Once we have udev working during early boot, we won't need
the initscripts.

> And a couple questions.
> a) Should not ordering be reversed here:
> 
>   start)
>     if [ ! -d $udev_dir ]; then
>         mkdir $udev_dir
>     fi
>     if [ ! -d $sysfs_dir ]; then
>         exit 1
>     fi
>   If we have not /sys, there's no sense on creating /udev, so I would check first
>   for /sys.

Makes sense.

> b) What is the sense of removing devices when udev is stopped ? As I understand
>   it, udev is not 'running', it is just a command to create device nodes, called 
>   by hotplug.

Because if you have your udev on a persistent storage media (e.g., ext3,
like most of us) then it is nice to clear it out across reboots.

	Rob Love


