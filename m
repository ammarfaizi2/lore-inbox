Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbWAKAff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWAKAff (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWAKAff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:35:35 -0500
Received: from osagesoftware.com ([216.144.204.42]:40088 "EHLO
	mail.osagesoftware.com") by vger.kernel.org with ESMTP
	id S932546AbWAKAff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:35:35 -0500
Date: Tue, 10 Jan 2006 19:35:34 -0500
From: David Relson <relson@osagesoftware.com>
To: linux-kernel@vger.kernel.org
Subject: Problem with kernel 2.6.15's build target .tmp_vmlinux1
Message-ID: <20060110193534.09a6031c@osage.osagesoftware.com>
Organization: Osage Software Systems, Inc.
X-Mailer: Sylpheed-Claws 1.9.100cvs93 (GTK+ 2.8.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,

I've run into a problem building 2.6.15.  Starting with my 2.6.14
.config file, I ran oldconfig to generate a .config for 2.6.15.
Running "make" results in:

      LD      .tmp_vmlinux1
    kernel/built-in.o: In function `do_exit':
    : undefined reference to `exit_io_context'
    mm/built-in.o: In function `generic_write_checks':
    : undefined reference to `bdev_read_only'
    mm/built-in.o: In function `__generic_file_aio_write_nolock':
    : undefined reference to `bdev_read_only'
    mm/built-in.o: In function `__alloc_pages':
    : undefined reference to `blk_congestion_wait'
    mm/built-in.o: In function `__alloc_pages':
    : undefined reference to `blk_congestion_wait'

Makefile indicates that KALLSYMS is involved in building this target,
so here are two combinations of KALLSYMS settings that result in the
same problem:

CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS is not set
# CONFIG_KALLSYMS is not set

CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_EXTRA_PASS=y

Makefile mentions that the maintainers are working on problems with
kallsyms, which is why I'm reporting this problem.

If you need any more info (such as a copy of .config), let me know.

Regards,

David

P.S. As I'm not subscribed to this list, please CC me for all replies.
