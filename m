Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290422AbSBGQpR>; Thu, 7 Feb 2002 11:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290276AbSBGQpN>; Thu, 7 Feb 2002 11:45:13 -0500
Received: from air-2.osdl.org ([65.201.151.6]:13235 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S289764AbSBGQoU>;
	Thu, 7 Feb 2002 11:44:20 -0500
Date: Thu, 7 Feb 2002 08:45:00 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Andrey Panin <pazke@orbita1.ru>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] read() from driverfs files can read more bytes then
 requested
In-Reply-To: <20020207091053.GA4332@pazke.ipt>
Message-ID: <Pine.LNX.4.33.0202070843090.25114-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Feb 2002, Andrey Panin wrote:

> Hi all,
> 
> small program below crashes on read() from driverfs file:
> 
> int main(void)
> {
> 	int fd, ret;
> 	char buf[16];
> 
> 	fd = open("/var/driver/root/pci0/status", 0);
> 	ret = read(fd, buf, sizeof(buf));
> 	close(fd);
> }
> 
> it's because driverfs_read_file() function blindly uses entry->show()
> return value without sanity check. As a result userspace process requested 
> 16 bytes, but got ~45 and smashed stack as a bonus. You can also get this 
> effect pressing F3 in Midnight Commander on driverfs files.
> 
> Attached patch adds check that returned value is less then requested 
> byte count. I know that actual callback function device_read_status()
> should also be fixed, but I found this bug after midnight and 
> decided to sleep a little :)

That sanity check was in there, once upon a time. However, in moving the 
weight from the driver callbacks to the driverfs read_file() and 
write_file(), it must have got dropped...

Thank you. It's been applied and will be pushed forward.

	-pat

