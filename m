Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUK1AXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUK1AXF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 19:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbUK1AXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 19:23:05 -0500
Received: from www.uekae.tubitak.gov.tr ([212.174.195.226]:16382 "EHLO
	uekae.uekae.gov.tr") by vger.kernel.org with ESMTP id S261378AbUK1AW7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 19:22:59 -0500
Subject: Problem with ioctl command TCGETS
From: Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: TUBITAK - Ulusal Elektronik ve Kriptoloji Arastirma Enstitusu
Mime-Version: 1.0
Date: Sun, 28 Nov 2004 02:22:51 +0200
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.2-5; VAE: 6.28.0.18; VDF: 6.28.0.93; host: uekae)
Message-Id: <20041128002044.CE13839877@uekae.uekae.gov.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Please CC me your responses ---


Hi,

While tracking KPPP and modem interaction, I experienced a problem with
TCGETS ioctl command, which is defined as constant number 0x5401 in
"include/asm/ioctls.h".  If you decode TCGETS, you will obtain:

	type: 'T'
 	direction: _IOC_NONE
	number: 1
	size: 0

but applications (like KPPP) cause indirectly that the modem descriptor
is ioctl'd by passing a string, as the example in
http://www.ussg.iu.edu/hypermail/linux/kernel/9904.0/0371.html shows: 

	fd = open("/dev/ttyS1", O_RDWR|O_NONBLOCK)
	fcntl(fd, F_GETFD)
	fcntl(fd, F_SETFD, FD_CLOEXEC)
	fcntl(fd, F_GETFL)
	ioctl(fd, TCGETS, {B9600 opost isig icanon echo ...}) = 0
	
CMIIW, TCGETS ioctl command should not interest with its argp, but
drivers/char/tty_ioctl.c does.

	case TCGETS:
		if (kernel_termios_to_user_termios((struct termios __user *)arg,
real_tty->termios))
			return -EFAULT;
		return 0;

I have a few questions:

1. Is it nice to break _IO macros?
2. If it has a historical reason, shall I forget to trust to the
informations that I decoded using _IO* macros?
3. Is there a list of such amazing commands?



Thanks in advance,
Ozan Eren BILGEN


