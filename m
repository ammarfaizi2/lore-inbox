Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTEOFVB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 01:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTEOFVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 01:21:01 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:61869 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S262108AbTEOFVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 01:21:00 -0400
Date: Thu, 15 May 2003 01:33:50 -0400
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Subject: O_DIRECT write to file by block-aligned, block-multiple buf fails?
Message-ID: <20030515013350.B1540@newbox.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought based on searching the archives that 2.4 O_DIRECT
requires fs block size alignment of the buffer, and that the
buffer is an exact multiple of block size.  This should mean
I can write aligned pages with direct IO, right?

        int
        main (void)
        {
                char *buf;
                int fd;

                buf = memalign(getpagesize(), getpagesize());
                fd = open("/tmp/testfile", O_TRUNC|O_WRONLY|O_DIRECT);
                if (write(fd, buf, getpagesize()) == -1)
                        perror("write");
        }

        $ ./test
        write: Invalid argument

        $ grep /tmp /proc/mounts
        /dev/hda5 /mnt/tmp ext3 rw 0 0

        $ sudo dumpe2fs /dev/hda5 | grep Block\ size
        dumpe2fs 1.27 (8-Mar-2002)
        Block size:               4096

        $ uname -rm
        2.4.21-pre4-ac1 i686

what silly thing am I not understanding here?
