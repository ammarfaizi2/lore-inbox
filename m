Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbTLUOTY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 09:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTLUOTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 09:19:24 -0500
Received: from cpr.sovintel.ru ([213.221.51.82]:39432 "EHLO cpr.sovintel.ru")
	by vger.kernel.org with ESMTP id S263166AbTLUOTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 09:19:22 -0500
From: aal@evidence-cpr.com (Alexey Lobanov)
Organization: Evidence CPR
To: linux-kernel@vger.kernel.org
Date: Sun, 21 Dec 2003 17:18:50 +0300
MIME-Version: 1.0
Subject: PROBLEM: pptp client crashes 2.4 kernel
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Message-Id: <20031221141850.96CFF5D841@office.cpr.spb.ru>
X-Sanitizer: This message has been sanitized!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

To folks related to PPP and PPtP in Linux.

This is neither a question nor proper bugreport. Just a preliminary alert. No explicit 
advice assumed. If the problem seems to be interesting, please request any additional 
information via personal mail.

The essence of problem: Linux box with kernel 2.4.23 is crashed to kernel oops by PPtP 
connection to Alcatel ADSL modem. Not instantly but "upon load", after few minutes to few 
hours of real networking. Same box is rock stable for months with old 2.2.19 kernel. 
Complete hardware replace and complete replace of all(?) the related user-space software 
(pppd daemon, pptp-linux daemon) changes nothing. So, the problem seems to be related to 
either ppp or virtual terminal driver in latest 2.4 kernel.

  Details.

The very basic (without crypto) PPtP-over-Ethernet tunnel is used by some ADSL providers, 
mostly in Europe. Client machine has 10.0.0.1 at Ethernet card, modem has something like 
10.0.0.138. PPP connection is authorized via plain PAP and uses no any MS extensions (no 
mppe, ms-chap-*, etc), no any compression. 

The problem appeared while production router upgrade from 2.2 kernel to 2.4 kernel. 
System works fine during some time (minutes to hours), then crashes with "Null pointer 
dereference..." in different points: several times it was "swapper", then something else. 
Downgrade to 2.2.19 kernel restores stability. Hardware problems are excluded: the 
hardware was replaced completely during tests, including netcard model.

  User-level software versions.

ppp daemon: either 2.4.1 from Debian 3.0r2 or self-compiled 2.4.2b3. No difference.

pptp-linux client daemon: either 1.1.0 from Debian 3.0r2 or self-compiled 1.3.1. No 
difference.

  Kernel patches: Openwall OW1 security patch.

Some raw ideas obtained from Internet search: (1) conflicts with ipchains netfilter; (2) 
conflicts in mtu/mss size. No probes without ipchains.o were done.

Please do not ask me for any test in next weeks: this exotic pptp configuration works in 
an unattended production box 750 km away from my normal location. Not the best guinea-
pig. However, tests will be possible in January, after our Christmas (which is 7 Jan).

Regards,
Alexey

