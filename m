Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTKONM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 08:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbTKONM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 08:12:57 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:30894 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261681AbTKONMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 08:12:55 -0500
Date: Sat, 15 Nov 2003 14:12:53 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6 BK Autoloading of modules regression?
Message-ID: <20031115131253.GA11413@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using a recent Linux-2.6 (BK) with module-init-tools 0.9.15-pre3.

I cannot autoload some modules in spite of (what I think) correct
configuration.

When I try to access /dev/nst0, I'd like the st module to be loaded.

$ grep char-major-9\  /etc/modprobe.conf
alias char-major-9 st
$ mt -f /dev/nst0 status
mt: No such device. Cannot open '/dev/nst0'.

dmesg reports
"request_module: failed /sbin/modprobe -s -- char-major-9-128. error = -1"

Changing the alias to char-major-9-* or char-major-9* does not help.

The st module is available, a manual modprobe st loads it fine.

This worked with older post-2.6.0-test9 BK kernels with 0.9.15-pre2
module-init-tools.


The other issue I'm having is that apparently the kernel does not even
try to autoload my "scanner" module. I have "alias char-major-180-48
scanner" in modprobe.conf, /dev/usb/scanner0 which is a character special
wit 180,48 is opened, but the module is not loaded. This has always been
the case for 2.6.0-test9 for me.

Did I do something wrong? Is there a kernel or module-init-tools
problem?

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
