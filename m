Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751872AbWISQ6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbWISQ6W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWISQ6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:58:22 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:7364 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S1751001AbWISQ6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:58:21 -0400
Date: Tue, 19 Sep 2006 18:57:34 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.18-rc7-mm1
Message-ID: <20060919165734.GA30378@aepfle.de>
References: <20060919012848.4482666d.akpm@osdl.org> <45100272.505@mbligh.org> <20060919093122.d8923263.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060919093122.d8923263.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, Andrew Morton wrote:


> What version of udev is it running?

021 likely, a simple udevstart that looks for 'dev' entries.
Where do they hide now in -mm?

> > [: [0-9]*: bad number
> > 
> >
> 
> That all looks rather bad.

'bad number' is harmless, affects only the persistant /dev/disk/ symlinks,
happens since the SCSI target patches in 2.6.9.

> > ReiserFS: sda2: Using r5 hash to sort names
> > looking for init ...
> > found /sbin/init
> > /init: cannot open .//dev//console: no such file
> 
> Bizarrely-formed pathname.  Does it always do that?

Yes, I wonder why /dev/console got lost in the first place.

/lib/mkinitrd/kinit.sh
...
rm -rf /bin /lib*
#
exec /run_init "$@" < "./$udev_root/console" > "./$udev_root/console" 2>&1
...

> Has udev actually attempted to do anything by this stage?

udevstart spawns alot /sbin/udev processes to propagate /dev
