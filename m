Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbVF2RAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbVF2RAB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVF2Q7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:59:38 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:1937 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S262622AbVF2Q7H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:59:07 -0400
Message-ID: <42C2D354.6060607@free.fr>
Date: Wed, 29 Jun 2005 18:59:00 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: device_remove_file and disconnect
Content-Type: multipart/mixed;
 boundary="------------010501030804010500020002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010501030804010500020002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have a question about sysfs interface.

If you open a sysfs file created by a module, then remove it (rmmoding 
the module that create this sysfs file), then try to read the opened 
file, you often get strange result (segdefault or oppps).

I attach a small program to test it : open your sysfs file with it 
`wait_read /sysfs/file', rmmod the module, and press enter.

I was wondering if it is to user of sysfs to prevent that (with mutex, 
...) or it is a sysfs bug ?

If it is the first case, I fear that lot's of modules are broken.

Regards,

Matthieu

PS : CC me as I am not subscribed to lkml.


--------------010501030804010500020002
Content-Type: text/x-csrc;
 name="wait_read.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wait_read.c"

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main(int argc, char *argv[])
{
        char c;
        char buf[1024];
        int fd, i, n;

        if (argc != 2)
                return -1;

        fd = open(argv[1], O_RDONLY);
        if (fd < 0) {
                perror("wait_read - open fail");
                return -1;
        }

        c = getc(stdin);
        n = read(fd, buf, 1024);

        for (i = 0; i < n; i++)
                putc(buf[i], stdout);

        if (n < 0)
                perror("wait_read - read fail");
        else
                putc('\n', stdout);

        close(fd);
}

--------------010501030804010500020002--
