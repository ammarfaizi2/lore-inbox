Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVANXVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVANXVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 18:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVANXU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 18:20:59 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:32178 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261420AbVANXUh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 18:20:37 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 14 Jan 2005 23:20:00 +0000
Message-Id: <1105744800.7565.4.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: IBM-ACPI broken in 2.6.10
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ibm-acpi module included in 2.6.10 doesn't appear to parse
parameters correctly. This seems to be due to a patch from Rusty Russell
[1] which attempted to fix up the parameter parsing. Unfortunately, it
seems that the parameters have to be parsed /after/ module_init has been
called, as otherwise the parsing code calls acpi functions that fail. If
the init function is called first, everything works as it should do. (I
haven't actually looked closely enough at the driver to work out what
it's doing, but...)

What's the right way of fixing this?

[1] http://lkml.org/lkml/2004/11/28/164 - without this, everything
works. With it, parameter setting fails.
-- 
Matthew Garrett | mjg59@srcf.ucam.org

