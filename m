Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVGDNqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVGDNqR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 09:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVGDNqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 09:46:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6839 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261697AbVGDNXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 09:23:50 -0400
Date: Mon, 4 Jul 2005 15:25:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Lenz Grimmer <lenz@grimmer.com>
Cc: hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up
Message-ID: <20050704132516.GO1444@suse.de>
References: <20050704061713.GA1444@suse.de> <42C8C978.4030409@linuxwireless.org> <20050704063741.GC1444@suse.de> <1120461401.3174.10.camel@laptopd505.fenrus.org> <20050704072231.GG1444@suse.de> <1120462037.3174.25.camel@laptopd505.fenrus.org> <20050704073031.GI1444@suse.de> <42C91073.80900@grimmer.com> <20050704110604.GL1444@suse.de> <42C93733.1090708@grimmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C93733.1090708@grimmer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04 2005, Lenz Grimmer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Jens!
> 
> Thanks for the sample code. I've trimmed the recipient list a bit...
> 
> Jens Axboe wrote:
> 
> > Perhaps the IDLE or IDLEIMMEDIATE commands imply a head parking, that
> > would make sense. As you say, you can hear a drive parking its head.
> > Here's a test case, it doesn't sound like it's parking the hard here.
> 
> Not here either, but let me check, if I understand this correctly:
> 
> > #include <stdio.h>
> > #include <unistd.h>
> > #include <fcntl.h>
> > #include <sys/ioctl.h>
> > #include <linux/hdreg.h>
> > 
> > int main(int argc, char *argv[])
> > {
> > 	char cmd[4] = { 0xe1, 0, 0, 0 };
> 
> The "0xe1" in here is what is defined as "WIN_IDLEIMMEDIATE" in hdreg.h,
> correct?

Correct.

> > 	int fd;
> > 
> > 	if (argc < 2) {
> > 		printf("%s <dev>\n", argv[0]);
> > 		return 1;
> > 	}
> > 
> > 	fd = open(argv[1], O_RDONLY);
> 
> Hmm, don't I need to actually have *write* access for sending an ioctl?

No, but you need CAP_SYS_RAWIO capability. So run it as root.

> > 	if (fd == -1) {
> > 		perror("open");
> > 		return 1;
> > 	}
> > 
> > 	if (ioctl(fd, HDIO_DRIVE_CMD, cmd))
> > 		perror("ioctl");
> > 
> > 	close(fd);
> > 	return 0;
> > }
> 
> I will give it another try, after clarifying the above questions - maybe
> there is a command that will perform the desired task. If not, I guess
> we're back at snooping what the Windows driver does here...

I'm not aware of a generally specificed command, it's likely that the
ibm drive has a vendor specific one. Or that one of the idle commands
can be configured to park the drive. Or... I'm not sure you'll find
anything interesting in the windows driver, I would imagine that the
user app is the one issuing the ide command (like the linux equiv would
as well).

-- 
Jens Axboe

