Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbVLaWrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbVLaWrG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 17:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVLaWrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 17:47:06 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:65203 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751218AbVLaWrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 17:47:05 -0500
Subject: RTC broken under 2.6.15-rc7-rt1 (was: Re: MPlayer broken under
	2.6.15-rc7-rt1?)
From: Steven Rostedt <rostedt@goodmis.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Bradley Reed <bradreed1@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
In-Reply-To: <Pine.LNX.4.61.0512312153480.27366@yvahk01.tjqt.qr>
References: <20051231202933.4f48acab@galactus.example.org>
	 <1136058696.6039.133.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0512312153480.27366@yvahk01.tjqt.qr>
Content-Type: multipart/mixed; boundary="=-vzxLH+4YDLkr6UjL7evq"
Date: Sat, 31 Dec 2005 17:46:55 -0500
Message-Id: <1136069215.6039.142.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vzxLH+4YDLkr6UjL7evq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-12-31 at 21:58 +0100, Jan Engelhardt wrote:
> >Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
> 
> I seriously demand that this be changed into "RTC broekn under..."! :)

Done ;)

[...]

> >
> >Index: linux-2.6.15-rc7-rt1/drivers/char/rtc.c
> 
> This patch fixes the rtc BUG for me.

Yeah, attached is a program that does what mplayer does.  I run it from
the command line like this:

# for i in `seq 10000`; do ./rtc_ioctl ; done

And with the patch it runs perfectly fine.  Without it, it segfaults
several times.

-- Steve


--=-vzxLH+4YDLkr6UjL7evq
Content-Disposition: attachment; filename=rtc_ioctl.c
Content-Type: text/x-csrc; name=rtc_ioctl.c; charset=us-ascii
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <linux/rtc.h>

#define RTC "/dev/rtc"

int main(int argc, char **argv)
{
	int fd;
	unsigned long data;

	if ((fd = open(RTC, O_RDONLY)) < 0) {
		perror(RTC);
		exit(0);
	}
	
	ioctl(fd, RTC_IRQP_SET, 1024);
	ioctl(fd, RTC_PIE_ON, 0);

	read(fd, &data, sizeof(data));
	printf("%08lx\n",data);

	close (fd);
	exit(0);
}

--=-vzxLH+4YDLkr6UjL7evq--

