Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270156AbRHGKHl>; Tue, 7 Aug 2001 06:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270172AbRHGKHb>; Tue, 7 Aug 2001 06:07:31 -0400
Received: from [203.126.57.231] ([203.126.57.231]:45324 "HELO
	mail.celestix.com") by vger.kernel.org with SMTP id <S270156AbRHGKHS>;
	Tue, 7 Aug 2001 06:07:18 -0400
Date: Tue, 7 Aug 2001 17:54:38 +0800
From: Thibaut Laurent <thibaut@celestix.com>
To: Jochen Striepe <jochen@tolot.escape.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.8pre5 does not build
Message-Id: <20010807175438.211052d5.thibaut@celestix.com>
In-Reply-To: <20010807114023.A23521@tolot.miese-zwerge.org>
In-Reply-To: <20010807114023.A23521@tolot.miese-zwerge.org>
Organization: Celestix Networks Pte Ltd
X-Mailer: Sylpheed version 0.4.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001 11:40:23 +0200
Jochen Striepe <jochen@tolot.escape.de> wrote:

 |         Hi,
 | 
 | I just downloaded Linux-2.4.8pre5, and got the following error message.
 | Earlier 2.4.8pre kernels build fine.
 | 

It seems to be the same problem as in kernel 2.4.7-ac8.
Please apply the patch that Carlo E. Prelz sent about one hour ago:

--- shmem.c~    Tue Aug  7 07:17:36 2001
+++ shmem.c     Tue Aug  7 08:56:41 2001
@@ -1419,9 +1419,11 @@
        }
        shm_mnt = res;

+#ifdef CONFIG_TMPFS
        /* The internal instance should not do size checking */
        if ((error = shmem_set_size(SHMEM_SB(res->mnt_sb), ULONG_MAX, ULONG_MAX)))
                printk (KERN_ERR "could not set limits on internal tmpfs\n");
+#endif

        return 0;
 }

Regards,

Thibaut

