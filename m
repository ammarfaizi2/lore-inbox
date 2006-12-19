Return-Path: <linux-kernel-owner+w=401wt.eu-S1752964AbWLSPul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbWLSPul (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 10:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753051AbWLSPul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 10:50:41 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:53831 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbWLSPuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 10:50:40 -0500
X-Originating-Ip: 24.163.66.209
Date: Tue, 19 Dec 2006 10:46:24 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: my handy-dandy, "coding style" script
Message-ID: <Pine.LNX.4.64.0612191044170.7588@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-12.808, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_NJABL_DUL 1.95, RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  just for fun, i threw the following together to peruse the tree (or
any subdirectory) and look for stuff that violates the CodingStyle
guide.  clearly, it's far from complete and very ad hoc, but it's
amusing.  extra searches happily accepted.

rday



#!/bin/sh

DIR=${1-.}

echo -e "\n===== Deprecated 'depends' in Kconfig files ...\n"
grep depends $(find . -name Kconfig) | grep -v "depends on"

echo -e "\n===== Potentially unnecessary casting of k[cmz]alloc() calls ...\n"
grep -Er "\([^\)]+\) ?k[cmz]alloc ?\(" *

echo -e "\n===== Discouraged kcalloc(1,...) calls ...\n"
grep -Er "kcalloc ?\(1," *

echo -e "\n===== Where ARRAY_SIZE() should be used ...\n"
grep -Er "sizeof\((.*)\) ?/ ?sizeof\(\1\[0\]\)" *

echo -e "\n===== Where FIELD_SIZEOF() should be used ...\n"
grep -Er "sizeof ?\( ?\( ?\([^\*]*[^ ] ?\*\) ?0 ?\)->[^\)]+\)" *

echo -e "\n===== People who seem to be redefining MAX() or MIN() ...\n"
grep -Er "# +define +MAX ?\(" *
grep -Er "# +define +MIN ?\(" *

echo -e "\nDone."
