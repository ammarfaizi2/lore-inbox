Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265261AbUFMUHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbUFMUHG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 16:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUFMUHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 16:07:06 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:18560 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265261AbUFMUHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 16:07:02 -0400
Date: Sun, 13 Jun 2004 22:07:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tisheng Chen <tishengchen@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Solution to the "1802: Unauthorized network card" problem in recent thinkpad systems
Message-ID: <20040613200743.GA1251@ucw.cz>
References: <20040613112051.GA1416@ucw.cz> <20040613191029.85026.qmail@web90108.mail.scd.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040613191029.85026.qmail@web90108.mail.scd.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 12:10:29PM -0700, Tisheng Chen wrote:

> Somebody did succeed with a X31. 
> As I know, it should works for T30,R40,X31,R40E at
> least.

Indeed, this version:

#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(void)
{
	int fd;
	unsigned char data;

	printf("Disabling WiFi whitelist check.\n");
	fd = open("/dev/nvram", O_RDWR);
	lseek(fd, 0x5c, SEEK_SET);
	read(fd, &data, 1);
	printf("CMOS address 0x5c: %02x->", data);
	data |= 0x80;
	printf("%02x\n", data);
	lseek(fd, 0x5c, SEEK_SET);
	write(fd, &data, 1);
	close(fd);
	printf("Done.\n");
}

worked just fine, and the notebook no longer complains about an
unsupported WiFi card! Now if I only can get the card to enable the
transmitter/receiver. It's a Compaq Atheros card inside an X31 notebook.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
