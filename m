Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVGDGj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVGDGj1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 02:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVGDGj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 02:39:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39100 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261518AbVGDGgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 02:36:20 -0400
Date: Mon, 4 Jul 2005 08:37:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Lenz Grimmer <lenz@grimmer.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050704063741.GC1444@suse.de>
References: <9a8748490507031832546f383a@mail.gmail.com> <42C8D06C.2020608@grimmer.com> <20050704061713.GA1444@suse.de> <42C8C978.4030409@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C8C978.4030409@linuxwireless.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04 2005, Alejandro Bonilla wrote:
> Jens Axboe wrote:
> 
> >On Mon, Jul 04 2005, Lenz Grimmer wrote:
> > 
> >
> >>>I'll be working on adding sysfs stuff to it tomorrow so it's generally
> >>>useful (at least for monitoring things - not yet for parking disk
> >>>heads).
> >>>     
> >>>
> >>Maybe there is some kind of all-purpose ATA command that instructs the
> >>disk drive to park the heads? Jens, could you give us a hint on how a
> >>userspace application would do that?
> >>   
> >>
> >
> >Dunno if there's something that explicitly only parks the head, the best
> >option is probably to issue a STANDBY_NOW command. You can test this
> >with hdparm -y.
> > 
> >
> This is exactly what I said. Use hdparm to make the HD park 
> inmediatelly. I did send the email to the HDPARM developer, but he never 
> replied. I asked him what would be the best way to make the HD park with 
> no exception and then let it come back 5 or 10 seconds later.

IIRC, you don't have to do anything to wake up the drive after a
STANDBYNOW command, if you want to be on the safe side you just issue an
IDLEIMMEDIATE. So your code will look something like:

int drive_standby(int fd)
{
        char foo[4] = { 0xe0, 0, 0, 0 };

        return ioctl(fd, HDIO_DRIVE_CMD, &foo);
}

int drive_wakeup(int fd)
{
        char foo[4] = { 0xe1, 0, 0, 0 };

        return ioctl(fd, HDIO_DRIVE_CMD, &foo);
}

-- 
Jens Axboe

