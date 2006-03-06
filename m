Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWCFAQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWCFAQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 19:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWCFAQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 19:16:58 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:64215 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750723AbWCFAQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 19:16:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jWQW5/rIWmp1571//iOh9tq0vy2c9hBnmBwDxbeido07MwDOLdqN2M4BUWpFipzVwHJkW5AmcaLRMoXSMab7HEpZL7JQ5ZFu9fajifrqD9eujIK1KL3hBRGqYm/TDRnd1FideCLqWbvKouqbeKKTeh0W1TCxmzb+49OIwpL+8us=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Slab corruption in 2.6.16-rc5-mm2
Date: Mon, 6 Mar 2006 01:17:16 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603060117.16484.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just found the following in dmesg :

Slab corruption: start=f72948a0, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02934eb>](sr_do_ioctl+0x11b/0x270)
000: 70 00 05 00 00 00 00 0a 00 00 00 00 24 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Prev obj: start=f7294854, len=64
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c0173923>](real_lookup+0x93/0xe0)
000: 6c 69 62 6b 64 65 69 6e 69 74 5f 6b 69 6f 5f 68
010: 74 74 70 5f 63 61 63 68 65 5f 63 6c 65 61 6e 65
Next obj: start=f72948ec, len=64
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c01c7c80>](ext3_init_block_alloc_info+0x20/0x70)
000: 10 cf ce f7 00 00 00 00 00 00 00 00 00 00 00 00
010: 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Slab corruption: start=f70aeab4, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02934eb>](sr_do_ioctl+0x11b/0x270)
000: 70 00 02 00 00 00 00 0a 00 00 00 00 3a 01 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Prev obj: start=f70aea68, len=64
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c023d6df>](init_dev+0x5cf/0x630)
000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Next obj: start=f70aeb00, len=64
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c0173923>](real_lookup+0x93/0xe0)
000: 6c 69 62 62 6f 6f 73 74 5f 70 72 67 5f 65 78 65
010: 63 5f 6d 6f 6e 69 74 6f 72 2d 67 63 63 2d 31 5f


Machine is running 2.6.16-rc5-mm2 :
$ uname -a
Linux dragon 2.6.16-rc5-mm2 #1 SMP PREEMPT Mon Mar 6 00:06:54 CET 2006 i686 athlon-4 i386 GNU/Linux

CPU is a dualcore Athlon X2 4400+

Kernel is 32bit, build for i386.

The machine has 2GB of RAM.

Let me know what additional info would be useful, if any.

If patches need testing then just send them my way.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

