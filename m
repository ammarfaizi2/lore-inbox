Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265454AbUGSSNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265454AbUGSSNN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 14:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUGSSNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 14:13:13 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:33445 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S265454AbUGSSNH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 14:13:07 -0400
X-Qmail-Scanner-Mail-From: solt@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.22 (Clear:RC:0(150.254.37.14):SA:0(0.2/5.0):. Processed in 3.248662 secs)
Date: Mon, 19 Jul 2004 20:13:04 +0200
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Mailer: SecureBat! Lite (v2.10.02) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <962257105.20040719201304@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: [partially solved] tcp_window_scaling degrades performance
In-Reply-To: <200407160726.39026.edt@aei.ca>
References: <2igbK-82L-13@gated-at.bofh.it>
 <m3zn615exj.fsf@averell.firstfloor.org>
 <505216170.20040716122132@dns.toxicfilms.tv> <200407160726.39026.edt@aei.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> AK> It is very very likely the firewall, window scaling works for a lot
> AK> of people.
> It is probable, but here: only 2.6.7+ machines behave like this.
> I also noticed, that turning tcp_window_scaling off does not always
> fix the problem, turning tcp_bic to 0 too helps even more.
It appears that checkpoint fw-1 that is here spoils everything so that
current linux boxes need to disable tcp_windows_scaling to get
reasonable throughput. When I switched a server to a different link
that bypasses checkpoint it worked well.

Although it most propably is checkpoint's fault (This one is based on
linux 2.4.9-39cpsmp) I belive that the change in the kernel that started
producing these problems is this one:
http://linux.bkbits.net:8080/linux-2.6/cset@1.1784.10.7?nav=index.html|ChangeSet@-3w

When I removed this patch from a 2.6.8-rc1 kernel it started to work
good again. But of course it may be a blind shot.

I am planning on investigating this issue from the checkpoint's
perspective.

Anyway if there is anyone willing to investigate the tcpdumps and
tcptraces of the slow/fast throughput, here it is:
http://soltysiak.com/tcp.php

I am no guru, but it shows:
1) slower throughput
2) twice as much packets exchanged
3) different advertised windows

Best regards,
Maciek


