Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTJOKLx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 06:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTJOKLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 06:11:53 -0400
Received: from web40901.mail.yahoo.com ([66.218.78.198]:61976 "HELO
	web40901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262491AbTJOKLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 06:11:52 -0400
Message-ID: <20031015101151.11153.qmail@web40901.mail.yahoo.com>
Date: Wed, 15 Oct 2003 03:11:51 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: 2.6.0-test7-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After compiling 2.6.0-test7-mm1, I get the following error after installing the
modules:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.0-test7-mm1; fi
WARNING: /lib/modules/2.6.0-test7-mm1/kernel/fs/ext2/ext2.ko needs unknown symbol
__blockdev_direct_IO

I checked the filesystem code and the function __blockdev_direct_IO is defined
at fs/direct-io.c, line 1020. However, the EXPORT_SYMBOL() definition uses
"blockdev_direct_IO", not "__blockdev_direct_IO". Grepping the include/linux
directory shows inline definitions for various wrappers for __blockdev_direct_IO,
including "blockdev_direct_IO", in include/linux/fs.h at line 1355. Yet depmod
can't seem to find it for the ext2 module.

Does this have anything to do with Jens Axboe's IDE write barrier/JBD write
barrier work?

Brad



=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
