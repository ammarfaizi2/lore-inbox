Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVG0GZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVG0GZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 02:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVG0GZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 02:25:29 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:63459 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261981AbVG0GZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 02:25:27 -0400
Date: Wed, 27 Jul 2005 08:25:22 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mike Mohr <akihana@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reclaim space from unused ramdisk?
In-Reply-To: <4746469c05072615167ca234ce@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0507270823490.10780@yvahk01.tjqt.qr>
References: <4746469c05072615167ca234ce@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I wonder if it would be possible to somehow reclaim space that has
>been previously reserved for a ramdisk without rebooting.

free_ramdisk.c:

#include <sys/ioctl.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

int main(int argc, const char **argv) {
    int eax = 0;
    while(*argv != NULL) {
        int fd = open(*argv, O_RDWR);
        if(fd < 0) {
            fprintf(stderr, "Warning: Cannot open %s: %s\n",
             *argv, strerror(errno));
            if(eax == 0) { eax = errno; }
            continue;
        }
        ioctl(fd, BLKFLSBUF, 0);
        close(fd);
        ++argv;
    }
    return eax == 0;
}

//eof


>How difficult would this be to write?


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
