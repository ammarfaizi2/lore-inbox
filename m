Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbUK3AuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUK3AuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbUK3AuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:50:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:55992 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261909AbUK3Arh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:47:37 -0500
Date: Mon, 29 Nov 2004 16:47:32 -0800
From: Chris Wright <chrisw@osdl.org>
To: Fred Emmott <mail@fredemmott.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] make root_plug more useful via whitelist
Message-ID: <20041129164732.G14339@build.pdx.osdl.net>
References: <200411272347.15728.mail@fredemmott.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200411272347.15728.mail@fredemmott.co.uk>; from mail@fredemmott.co.uk on Sat, Nov 27, 2004 at 11:47:15PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Fred Emmott (mail@fredemmott.co.uk) wrote:
> patch: http://fredemmott.co.uk/files/rp.patch
> 
> This adds a whitelist of programs such as /bin/login and /sbin/agetty which 
> may be ran as root without the USB device prescent. It also includes my 
> earlier patch to check the USB device's serial number as well as 
> vendor/product.
> 
> This is not meant for inclusion; I'd appreciate comments on anything I've done 
> wrong, and suggestions on how to make it distribution neutral (at the moment 
> it probably only works correctly on slackware) - I'm thinking of adding a 
> security/root_plug_relax/ directory containing files such as "slackware.h" 
> "redhat.h" etc.

There's a couple of problems here.  First, the serial number thing
should be done differently.  The serial number should be spcecified by
a module parameter, and just store it as u8 and do direct compare (this
will eliminate the unecessary kmalloc, and the subsequent memory leak
you introduced).  Second, the relax stuff should not be done via config
parameters.  It, of course, undermines the point of the module, but if
you want to do it, make it done via userspace writing to some exposed fs
(e.g.. echo /usr/bin/foo > ..../relax).  Finally, do the lookup there,
and then keep your whitelist as inode based, not pathname based.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
