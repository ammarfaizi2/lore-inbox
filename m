Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTJCUiF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 16:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTJCUiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 16:38:05 -0400
Received: from mail.netbeat.de ([193.254.185.26]:37128 "HELO mail.netbeat.de")
	by vger.kernel.org with SMTP id S261188AbTJCUiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 16:38:00 -0400
Subject: PPP not working on test6-mm2
From: Jan Ischebeck <mail@jan-ischebeck.de>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1065220814.2261.1.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 04 Oct 2003 00:40:14 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

PPP isn't working anymore since test5-mm1.

Here a stacktrace from test6-mm2, last lines from dmesg:

Badness in local_bh_enable at kernel/softirq.c:119
Call Trace:
[<c01281e5>] local_bh_enable+0x85/0x90
[<c0243762>] ppp_async_push+0xa2/0x190
[<c024307d>] ppp_asynctty_wakeup+0x2d/0x60
[<c020fcf8>] pty_unthrottle+0x58/0x60
[<c020c67d>] check_unthrottle+0x3d/0x40
[<c020c723>] n_tty_flush_buffer+0x13/0x60
[<c0210107>] pty_flush_buffer+0x67/0x70
[<c0208f55>] do_tty_hangup+0x405/0x470
[<c020a4dc>] release_dev+0x64c/0x680
[<c014abfb>] zap_pmd_range+0x4b/0x70
[<c014ac63>] unmap_page_range+0x43/0x70
[<c0170562>] dput+0x22/0x270
[<c020a8aa>] tty_release+0x2a/0x60
[<c015ac40>] __fput+0x100/0x120
[<c0159229>] filp_close+0x59/0x90
[<c0125b34>] put_files_struct+0x54/0xc0
[<c0126795>] do_exit+0x155/0x3f0
[<c0126aca>] do_group_exit+0x3a/0xb0
[<c02fb427>] syscall_call+0x7/0xb


PPP is build in, 

# CONFIG_PLIP is not set
CONFIG_PPP=y
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=y
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPPOE=y
# CONFIG_SLIP is not set


trying to start pppd doesn't work. Syslog:

Oct  4 00:05:39 JHome pppoe[2108]: ioctl(SIOCGIFHWADDR): Session 0: No
such device
Oct  4 00:05:39 JHome pppd[1134]: Serial connection established.
Oct  4 00:05:39 JHome pppd[1134]: Couldn't get channel number:
Input/output error


Jan

Pleace CC on reply.


-- 
Jan Ischebeck <mail@jan-ischebeck.de>

