Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWGFHdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWGFHdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 03:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWGFHdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 03:33:24 -0400
Received: from mail.gmx.de ([213.165.64.21]:13025 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964946AbWGFHdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 03:33:23 -0400
X-Authenticated: #14349625
Subject: 2.6.17-mm6 vmstat breakage
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060705225905.53e61ca0.akpm@osdl.org>
References: <20060703030355.420c7155.akpm@osdl.org>
	 <a762e240607051447x3c3c6e15k9cdb38804cf13f35@mail.gmail.com>
	 <20060705155037.7228aa48.akpm@osdl.org>
	 <a762e240607051628n42bf3b79v34178c7251ad7d92@mail.gmail.com>
	 <20060705164457.60e6dbc2.akpm@osdl.org>
	 <20060705164820.379a69ba.akpm@osdl.org>
	 <a762e240607051705h33952e5elf6bd09c1ccea8ab4@mail.gmail.com>
	 <20060705172545.815872b6.akpm@osdl.org>
	 <m1u05v2st3.fsf@ebiederm.dsl.xmission.com>
	 <20060705225905.53e61ca0.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 09:38:43 +0200
Message-Id: <1152171523.8098.22.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

My single P4/HT box is showing incorrect pgpgin pgpgout numbers with
this kernel.  While disk throughput for dd if=/dev/hdc of=/dev=null
bs=4096 count=1000000 produces about 57MB/S (up ~14% over 2.6.17 btw),
vmstat (procps version 3.2.5) is only showing about 7MB/S.

Looking at the numbers in /proc/vmstat, it looks kinda like pgpgin might
be pages instead of the KB it used to be, with some added >>=1 action on
the side.  At any rate, the numbers below are horse-pookey ;-)

 procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  1   3820   9400 810128  46052    0    0  7040     0 1163  1283  2  7 48 44
 1  1   3820   9220 810288  46156    0    0  7040     0 1151  1335  3  6 48 45
 1  1   3820   9280 810176  46204    0    0  7168     0 1156  1207  1  7 48 44
 2  1   3820   9408 810048  46068    0    0  7168     0 1160  1192  1  6 49 46

	-Mike

