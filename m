Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVCVAWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVCVAWp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVCVAVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:21:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:36224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262196AbVCVAT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:19:26 -0500
Date: Mon, 21 Mar 2005 16:19:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Greg KH <greg@kroah.com>
Subject: Re: current linus bk, error mounting root
Message-Id: <20050321161925.76c37a7f.akpm@osdl.org>
In-Reply-To: <9e473391050321155735fc506d@mail.gmail.com>
References: <9e47339105030909031486744f@mail.gmail.com>
	<20050321154131.30616ed0.akpm@osdl.org>
	<9e473391050321155735fc506d@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Adds lots of cc's.  I trust that's OK).

Jon Smirl <jonsmirl@gmail.com> wrote:
>
> No, I think Jens wants all of the distributions to fix it. I have
> filed a bug with Fedora on it.
> 
> Something changed in the timing for loading drivers during boot. You
> used to be able to do:
> modprobe ata_piix
> mount /dev/sda1
> 
> Now you have to do this:
> modprobe ata_piix
> sleep 1
> mount /dev/sda1
> 
> I suspect the problem is that udev doesn't get a chance to run anymore. 
> The sleep 1 allows it to run and it creates /dev/sda1.
> Build ata_piix in and the problem goes away too.
> 
> Jens is right that this is a user space issue, but how many people are
> going to find this out the hard way when their root drives stop
> mounting. Since no one is complaining I have to assume that most
> kernel developers have their root device drivers built into the
> kernel. I was loading mine as a module since for a long time Redhat
> was not shipping kernels with SATA built in.

I don't agree that this is a userspace issue.  It's just not sane for a
driver to be in an unusable state for an arbitrary length of time after
modprobe returns.

