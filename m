Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTLQQGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 11:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbTLQQGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 11:06:33 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:34553 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S264450AbTLQQGb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 11:06:31 -0500
Date: Wed, 17 Dec 2003 11:11:14 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev-009: Allow build with empty EXTRAS
Message-ID: <20031217111114.A3931@mail.kroptech.com>
References: <20031216220406.A23608@mail.kroptech.com> <20031217083100.GA2126@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031217083100.GA2126@kroah.com>; from greg@kroah.com on Wed, Dec 17, 2003 at 12:31:00AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 12:31:00AM -0800, Greg KH wrote:
> On Tue, Dec 16, 2003 at 10:04:06PM -0500, Adam Kropelin wrote:
> > Need to let the shell expand $EXTRAS so it can properly detect an empty
> > list. Without this patch, the build fails whenever $EXTRAS is empty.
> 
> $ export EXTRAS=
> $ make
> $ set | grep EXTRA
> EXTRAS=
> $ 
> 
> I can't duplicate this problem at all.  Someone else once reported it on
> the linux-hotplug-devel list, with much the same fix up patch, but later
> said they couldn't reproduce it either.
> 
> What version of make are you using?

It's actually the version of bash that's important. Prior to 2.05a, bash
was unable to handle for loops with empty words lists. From the
bash-2.05a changelog:

	p.  `for' loops now allow empty word lists after `in', like the 
	    latest POSIX drafts require.

So bash-2.05 dies on...

	for test in ; do echo $test ; done

...while bash-2.05a accepts it just fine.

Both versions can handle this case if the shell itself does the
expansion that results in the empty list. So that's where my workaround
came from.

--Adam

