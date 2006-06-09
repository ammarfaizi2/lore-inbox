Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWFIDei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWFIDei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 23:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWFIDei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 23:34:38 -0400
Received: from users.ccur.com ([66.10.65.2]:29888 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S1751373AbWFIDei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 23:34:38 -0400
Date: Thu, 8 Jun 2006 23:33:50 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Paul Dickson <paul@permanentmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, rahul@genebrew.com,
       ram.gupta5@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: booting without initrd
Message-ID: <20060609033350.GA1148@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <728201270606070913g2a6b23bbj9439168a1d8dbca8@mail.gmail.com> <b29067a0606081040q17c66f5bpa966da851635e942@mail.gmail.com> <1149813659.3124.31.camel@laptopd505.fenrus.org> <20060608184325.5c470dcf.paul@permanentmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060608184325.5c470dcf.paul@permanentmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2006 at 06:43:25PM -0700, Paul Dickson wrote:
> On Fri, 09 Jun 2006 02:40:59 +0200, Arjan van de Ven wrote:
> > On Thu, 2006-06-08 at 13:40 -0400, Rahul Karnik wrote:
> > > On 6/7/06, Ram Gupta <ram.gupta5@gmail.com> wrote:
> > > > I am trying to boot with 2.6.16  kernel at my desktop running fedora
> > > > core 4 . It does not boot without initrd generating the message "VFS:
> > > > can not open device "804" or unknown-block(8,4)
> > > > Please append a correct "root=" boot option
> > > > Kernel panic - not syncing : VFS:Unable to mount root fs on unknown-block(8,4)
> > > 
> > > AFAIK Fedora sets up the kernel command line with "root=LABEL=/" in
> > > grub.conf and therefore needs the initrd in order to work correctly.
> > > If you do not want an initrd, then change this to
> > > "root=/dev/<your_disk>" in grub.conf. 
> > 
> > it's more than that; also udev is used from the initrd to populate a
> > ramfs /dev, if you go without the initrd you need to populate the
> > *real* /dev manually first

When I do the following to FC5, I am able to boot kernel.org kernels w/o
an initrd:

        # mount --bind / /mnt
	# cd /mnt/dev
	# mknod null c 1 3
	# mknod console c 5 1
	# for i in $(seq 0 9); do mknod tty$i c 4 $i; done
	# cd /
	# umount /mnt

IMHO, FC5's failure to set up a minimal disk-based /dev like this
is a bug on its part.

Regards,
Joe
