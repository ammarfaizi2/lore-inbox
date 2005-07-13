Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbVGMErA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbVGMErA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 00:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVGMErA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 00:47:00 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:33960 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262569AbVGMEq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 00:46:59 -0400
Date: Tue, 12 Jul 2005 21:46:47 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Romain Lievin <roms@tilp.info>
Cc: zippel@linux-m68k.org, lkml <linux-kernel@vger.kernel.org>
Subject: dependency bug in gconfig?
Message-Id: <20050712214647.447fdaf0.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

(2.6.13-rc2 or later)

This appears to be a dependency bug in gconfig to me.

If I enable NETCONSOLE to y, NETPOLL becomes y.  (OK)
If I then disable NETCONSOLE to n, NETPOLL remains y.

If I enable NETCONSOLE to m, NETPOLL remains n.  Why is that?

config NETPOLL
	def_bool NETCONSOLE

Should this cause NETCONSOLE to track NETPOLL?



xconfig and menuconfig have much stricter tracking of
NETCONSOLE -> NETPOLL.  E.g.,
enabling NETCONSOLE=m or y in xconfig also enables NETPOLL=y
and disabling NETCONSOLE also disables NETPOLL.

---
~Randy
