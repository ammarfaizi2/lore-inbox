Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVGDLJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVGDLJE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 07:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVGDLJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 07:09:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9389 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261616AbVGDLEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 07:04:49 -0400
Date: Mon, 4 Jul 2005 13:06:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Lenz Grimmer <lenz@grimmer.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050704110604.GL1444@suse.de>
References: <9a8748490507031832546f383a@mail.gmail.com> <42C8D06C.2020608@grimmer.com> <20050704061713.GA1444@suse.de> <42C8C978.4030409@linuxwireless.org> <20050704063741.GC1444@suse.de> <1120461401.3174.10.camel@laptopd505.fenrus.org> <20050704072231.GG1444@suse.de> <1120462037.3174.25.camel@laptopd505.fenrus.org> <20050704073031.GI1444@suse.de> <42C91073.80900@grimmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C91073.80900@grimmer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04 2005, Lenz Grimmer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> Jens Axboe wrote:
> 
> > It isn't too pretty to rely on such unreliable timing anyways. I'm 
> > not too crazy about spinning the disk down either, it's useless wear 
> > compared to just parking the head.
> 
> Fully agreed, and that's the approach the IBM Windows driver seems to
> take - you just hear the disk park its head when the sensor kicks in
> (you can hear it) - the disk does not spin down when this happens.
> 
> Could this be some reserved ATA command that only works with certain#
> drives?

Perhaps the IDLE or IDLEIMMEDIATE commands imply a head parking, that
would make sense. As you say, you can hear a drive parking its head.
Here's a test case, it doesn't sound like it's parking the hard here.

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/hdreg.h>

int main(int argc, char *argv[])
{
	char cmd[4] = { 0xe1, 0, 0, 0 };
	int fd;

	if (argc < 2) {
		printf("%s <dev>\n", argv[0]);
		return 1;
	}

	fd = open(argv[1], O_RDONLY);
	if (fd == -1) {
		perror("open");
		return 1;
	}

	if (ioctl(fd, HDIO_DRIVE_CMD, cmd))
		perror("ioctl");

	close(fd);
	return 0;
}

-- 
Jens Axboe

