Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVGGOlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVGGOlj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 10:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVGGOjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 10:39:11 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:57503
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261653AbVGGOhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 10:37:51 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Jens Axboe'" <axboe@suse.de>, <hdaps-devel@lists.sourceforge.net>
Cc: "'Jens Axboe'" <axboe@suse.de>, "'Lenz Grimmer'" <lenz@grimmer.com>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Alejandro Bonilla'" <abonilla@linuxwireless.org>,
       "'Jesper Juhl'" <jesper.juhl@gmail.com>,
       "'Dave Hansen'" <dave@sr71.net>,
       "'LKML List'" <linux-kernel@vger.kernel.org>
Subject: RE: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Date: Thu, 7 Jul 2005 08:37:12 -0600
Message-ID: <001901c58301$5d4b5070$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200507071028.06765.spstarr@sh0n.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

	Thanks for this util. :-) It will make things easier for us and do part of
the Job we are looking for. I will post this  script in the hdaps.sf.net for
people if it's ok with you.

Thanks again,

.Alejandro

> > #include <stdio.h>
> > #include <unistd.h>
> > #include <fcntl.h>
> > #include <string.h>
> > #include <sys/ioctl.h>
> > #include <linux/hdreg.h>
> >
> > int main(int argc, char *argv[])
> > {
> > 	unsigned char buf[8];
> > 	int fd;
> >
> > 	if (argc < 2) {
> > 		printf("%s <dev>\n", argv[0]);
> > 		return 1;
> > 	}
> >
> > 	fd = open(argv[1], O_RDONLY);
> > 	if (fd == -1) {
> > 		perror("open");
> > 		return 1;
> > 	}
> >
> > 	memset(buf, 0, sizeof(buf));
> > 	buf[0] = 0xe1;
> > 	buf[1] = 0x44;
> > 	buf[3] = 0x4c;
> > 	buf[4] = 0x4e;
> > 	buf[5] = 0x55;
> >
> > 	if (ioctl(fd, HDIO_DRIVE_TASK, buf)) {
> > 		perror("ioctl");
> > 		return 1;
> > 	}
> >
> > 	if (buf[3] == 0xc4)
> > 		printf("head parked\n");
> > 	else
> > 		printf("head not parked %x\n", buf[3]);
> >
> > 	close(fd);
> > 	return 0;
> > }

