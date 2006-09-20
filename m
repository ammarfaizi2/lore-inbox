Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWITTFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWITTFB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWITTFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:05:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54199 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932249AbWITTFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:05:00 -0400
Date: Wed, 20 Sep 2006 12:02:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Subject: Re: [PATCH] mxser: make an experimental clone
Message-Id: <20060920120245.37e2db9b.akpm@osdl.org>
In-Reply-To: <916688631212913221@karneval.cz>
References: <916688631212913221@karneval.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006 16:06:55 +0200 (CEST)
Jiri Slaby <jirislaby@gmail.com> wrote:

> Andrew Morton wrote:
> > Ho hum, this is hard.  I guess breaking the driver is one way to find out
> > who is using it, but those who redistribute the kernel for a living might
> > not appreciate the technique.
> > 
> > Perhaps we could create an mxser-new.c and offer that in config, plan to
> > remove mxser.c N months hence?
> 
> Ok, here's a patch doing this. When you apply it, drop
> mxser-upgrade-to-191.patch, please, to get back unmodified version.
> 

It was, umm, naive to assume that was the only outstanding patch against
mxser.c.  I had four patches.  One wasn't actually in use and one I just
dropped, so we now have
serial-fix-up-offenders-peering-at-baud-bits-directly.patch and
const-struct-tty_operations.patch.

> 
> mxser: clone a new driver
> 
> Clone a new driver for moxa smartio devices. It contains update to version
> 1.9.1 from Moxa site and static to dynamic structures (including some
> renaming) conversion for further work -- converting to pci probing.

That wasn't a good way to do this.  It would have been (much) better to
have one patch which copies mxser.c to mxser_new.c and *nothing else*. 
Then, new patches which update mxser_new.c.

So I have converted your patch into one which simply copies mxser.[ch] to
mxser_new.[ch] and which makes no other changes.  The versions which were
copied were those _after_ the two pending patches were applied.  Please
send updates against those new files, thanks.


