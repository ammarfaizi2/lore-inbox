Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbTBHA1t>; Fri, 7 Feb 2003 19:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266926AbTBHA1t>; Fri, 7 Feb 2003 19:27:49 -0500
Received: from mccammon.ucsd.edu ([132.239.16.211]:26269 "EHLO
	mccammon.ucsd.edu") by vger.kernel.org with ESMTP
	id <S266917AbTBHA1s>; Fri, 7 Feb 2003 19:27:48 -0500
Date: Fri, 7 Feb 2003 16:37:25 -0800 (PST)
From: Alexei Podtelezhnikov <apodtele@mccammon.ucsd.edu>
X-X-Sender: apodtele@chemcca61.ucsd.edu
To: john@grabjohn.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.59 : sound/oss/vidc.c
Message-ID: <Pine.LNX.4.44.0302071608410.18936-100000@chemcca61.ucsd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


John Bradford (john@grabjohn.com) wrote:

> 36 < hwrate < 3332
       ^^^^^^  should be 'newsize'

Yeap, and the following couple of lines:

                /* 36 < newsize 3332; rounding it off 
                 * to the nearest power of 2, no less than 256 
                 */
                for (new2size = 384; new2size < newsize; new2size <<= 1);
                new2size -= (new2size >> 1);

safely replace the whole following block:

                if (newsize < 208)
                        newsize = 208;
                if (newsize > 4096)
                        newsize = 4096;
                for (new2size = 128; new2size < newsize; new2size <<= 1);
                        if (new2size - newsize > newsize - (new2size >> 1))
                                new2size >>= 1;
                if (new2size > 4096) {
                        printk(KERN_ERR "VIDC: error: dma buffer (%d) %d > 4K\n",
                                newsize, new2size);
                        new2size = 4096;
                }

Would somebody test this?
A.

