Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269182AbUINHRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269182AbUINHRc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 03:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269183AbUINHRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 03:17:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:12744 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269182AbUINHR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 03:17:29 -0400
Date: Tue, 14 Sep 2004 09:15:56 +0200
From: Jens Axboe <axboe@suse.de>
To: "C.Y.M." <syphir@syphir.sytes.net>
Cc: linux-kernel@vger.kernel.org, "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
Message-ID: <20040914071555.GJ2336@suse.de>
References: <20040914060628.GC2336@suse.de> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAA6P8AlyGHikORXOqFZ6fdPAEAAAAA@syphir.sytes.net> <20040914070649.GI2336@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914070649.GI2336@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14 2004, Jens Axboe wrote:
> They do support it, they just don't flag the support in the capability
> flags. And of course some don't support it at all, you can try this on
> your drives if you want to know for sure.

Forgot to attach the code, here it is...

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <sys/ioctl.h>
#include <linux/hdreg.h>

int main(int argc, char *argv[])
{
	char args[7];
	int fd;

	if (argc < 2) {
		printf("%s: <dev>\n", argv[0]);
		return 1;
	}

	fd = open(argv[1], O_RDONLY | O_NONBLOCK);
	if (fd == -1) {
		perror("open");
		return 2;
	}

	memset(args, 0, 7);
	args[0] = 0xE7;

	printf("issuing FLUSH_CACHE: ");
	if (ioctl(fd, HDIO_DRIVE_TASK, args) == -1)
		printf("failed 0x%x/0x%x!\n", args[0], args[1]);
	else
		printf("worked\n");

	memset(args, 0, 7);
	args[0] = 0xEA;

	printf("issuing FLUSH_CACHE_EXT: ");
	if (ioctl(fd, HDIO_DRIVE_TASK, args) == -1)
		printf("failed 0x%x/0x%x!\n", args[0], args[1]);
	else
		printf("worked\n");

	close(fd);
	return 0;
}

-- 
Jens Axboe

