Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbTGOHdj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 03:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266642AbTGOHdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 03:33:39 -0400
Received: from smtp3.pacifier.net ([64.255.237.173]:53692 "EHLO
	smtp3.pacifier.net") by vger.kernel.org with ESMTP id S266114AbTGOHdi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 03:33:38 -0400
Date: Tue, 15 Jul 2003 00:48:26 -0700
From: "B. D. Elliott" <bde@nwlink.com>
To: linux-kernel@vger.kernel.org
Subject: "Where's the Beep?" (PCMCIA/vt_ioctl-s)
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Message-Id: <20030715074826.EF8F46DC14@smtp3.pacifier.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my old DELL LM laptop the -2.5 series no longer issues any beeps when
a card is inserted.  The problem is in the kernel, as the test program
below (extracted from cardmgr) beeps on -2.4, but not on -2.5.

===========================================================
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>

#define BEEP_TIME 150
#define BEEP_OK   1000
#define BEEP_WARN 2000
#define BEEP_ERR  4000

#include <sys/kd.h>

static void beep(unsigned int, unsigned int);

int
main(int argc, char **argv)
{
	beep(500, 1000);
	beep(500, 2000);
	beep(500, 4000);
	return 0;
}

static
void beep(unsigned int ms, unsigned int freq)
{
    int fd, arg;

    fd = open("/dev/tty0", O_RDWR);
    if (fd < 0)
	return;
    arg = (ms << 16) | freq;
    ioctl(fd, KDMKTONE, arg);
    close(fd);
    usleep(ms*1000);
}
===========================================================

-- 
B. D. Elliott   bde@nwlink.com
