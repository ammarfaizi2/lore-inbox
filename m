Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbULPVU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbULPVU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 16:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbULPVU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 16:20:57 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:52387 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S262032AbULPVUs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 16:20:48 -0500
From: Andrew Walrond <andrew@walrond.org>
To: Greg KH <greg@kroah.com>
Subject: Re: Linux 2.6.10-rc2 start_udev very slow
Date: Thu, 16 Dec 2004 21:20:33 +0000
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <200412162057.25244.andrew@walrond.org> <20041216211137.GA9475@kroah.com>
In-Reply-To: <20041216211137.GA9475@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412162120.33995.andrew@walrond.org>
X-Spam-Score: 1.1 (+)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 Dec 2004 21:11, Greg KH wrote:
>
> Then I don't really know what to recommend.  As the udev startup logic
> is very tightly tied to how the distro is set up, I recommend using
> whatever they do, and ignore what I say :)

They is me; My distro is Rubyx :)

>
> > So I guess I need to migrate this functionality to my init system before
> > I can call udevstart directly.
>
> I'd suggest just leaving it alone.

Where's the fun in that?

>
> > Is that list of  'extra nodes not exported by sysfs likely to change?'
>
> What does that list contain?

make_extra_nodes () {
        # there are a few things that sysfs does not export for us.
        # these things go here (and remember to remove them in
        # remove_extra_nodes()
        #
        # Thanks to Gentoo for the initial list of these.
        ln -snf /proc/self/fd $udev_root/fd
        ln -snf /proc/self/fd/0 $udev_root/stdin
        ln -snf /proc/self/fd/1 $udev_root/stdout
        ln -snf /proc/self/fd/2 $udev_root/stderr
        ln -snf /proc/kcore $udev_root/core

        mkdir $udev_root/pts
        mkdir $udev_root/shm
}

Andrew Walrond
