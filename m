Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265264AbUFMUax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUFMUax (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 16:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbUFMUax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 16:30:53 -0400
Received: from web90108.mail.scd.yahoo.com ([66.218.94.79]:42347 "HELO
	web90108.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S265264AbUFMUav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 16:30:51 -0400
Message-ID: <20040613203050.4334.qmail@web90108.mail.scd.yahoo.com>
Date: Sun, 13 Jun 2004 13:30:50 -0700 (PDT)
From: Tisheng Chen <tishengchen@yahoo.com>
Subject: Re: Solution to the "1802: Unauthorized network card" problem in recent thinkpad systems
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040613200743.GA1251@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you can't find a driver for linux, try ndiswrapper
driver or linuxant's driverloader. However, the later
one is not free.

websites:
http://ndiswrapper.sf.net
http://www.linuxant.com/driverloader/

--- Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Sun, Jun 13, 2004 at 12:10:29PM -0700, Tisheng
> Chen wrote:
> 
> > Somebody did succeed with a X31. 
> > As I know, it should works for T30,R40,X31,R40E at
> > least.
> 
> Indeed, this version:
> 
> #include <stdio.h>
> #include <sys/types.h>
> #include <unistd.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> 
> int main(void)
> {
> 	int fd;
> 	unsigned char data;
> 
> 	printf("Disabling WiFi whitelist check.\n");
> 	fd = open("/dev/nvram", O_RDWR);
> 	lseek(fd, 0x5c, SEEK_SET);
> 	read(fd, &data, 1);
> 	printf("CMOS address 0x5c: %02x->", data);
> 	data |= 0x80;
> 	printf("%02x\n", data);
> 	lseek(fd, 0x5c, SEEK_SET);
> 	write(fd, &data, 1);
> 	close(fd);
> 	printf("Done.\n");
> }
> 
> worked just fine, and the notebook no longer
> complains about an
> unsupported WiFi card! Now if I only can get the
> card to enable the
> transmitter/receiver. It's a Compaq Atheros card
> inside an X31 notebook.
> 
> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR
> 



	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
