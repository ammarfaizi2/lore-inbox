Return-Path: <linux-kernel-owner+w=401wt.eu-S964890AbWLOUzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWLOUzz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWLOUzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:55:55 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:43594 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964876AbWLOUzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:55:52 -0500
Message-ID: <45830BD5.7000208@us.ibm.com>
Date: Fri, 15 Dec 2006 12:55:49 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alexis Bruemmer <alexisb@us.ibm.com>, Malahal Naineni <malahal@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>
Subject: [PATCHSET] Various sas_ata feature additions and EH fixes
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

As a companion to today's libsas roll-up, this is the queue of patches
for the SATL connector between SAS and ATA.  For patches not
specifically focusing on SAS ATA, please refer to my previous email (or
the patches themselves).  Each patch has its own preamble description,
but I'd like to call attention to a few of the larger shifts.

The most significant modifications are a few fixes to make ATAPI devices
work again, the beginnings of SATA PHY control (as best as can be
approximated), and integration with the new libsas EH strategy.

These patches should apply in number order cleanly against 2.6.19 +
scsi_misc + aic94xx-sas.  At the moment 2.6.20-rc isn't stable enough to
boot cleanly on any of our machines, but we've been running insmod/rmmod
and pounder tests on a x206m with mixed SAS/SATA/SATAPI devices for
several days without problems.

One can pick up the patches at the URL below.

http://sweaglesw.net/~djwong/docs/sas_ata-patches/

A rough breakdown of the patches follows.

These patches were covered in my libsas email, though the numbers shift
a bit.
03-libsas-discovery-failure_6.patch
04-libsas-discovery-failure-expander_6.patch
05-aic94xx-abort-task-race_2.patch
06-libsas-enable-phy_2.patch
07-libsas-taskless-cmnd-reset-timer_2.patch
08-libsas-kill-task-collector-after-ports_1.patch
09-aic94xx-set-max-execute-num_1.patch
10-libsas-use-scan-wildcard_1.patch
11-aic94xx-dont-eat-query-task-results_1.patch
12-libsas-remove-initiator-aborted_1.patch
13-libsas-add-dev-reset-to-eh_1.patch
14-libsas-abort-sas-task-deferral_1.patch
15-aic94xx-defer-task-abort_1.patch
16-libsas-smp-portal_1.patch
17-aic94xx-fix-fw-leak_1.patch
18-aic94xx-fix-ddb-scb-init_2.patch
19-aic94xx-lock-ddb-access_2.patch
20-libsas-phy-sysfs-ctrl-not-iwugo_1.patch
33-andmike-lockdep-fix.patch
34-malahal-discovery-race.patch
35-alexisb-aic94xx-abort-task-failed-fallthrough.patch

Roughly the same as last time:
21-libsas-ata-kconfig-fix_1.patch
22-libsas-fix-ata-qc-locking_3.patch
23-libsas-fix-qc-issue-err_1.patch
24-libsas-fix-libata-error_3.patch
25-libsas-ata-preserve-sactive_2.patch
31-libsas-satl-registration_3.patch
32-libsas-ata-module_3.patch

Add some semblance of PHY control:
26-libsas-ata-enable-phy_1.patch

ATAPI fixes:
27-libsas-atapi-sam-good_1.patch
28-libsas-ata-handle-unknown_1.patch

This patch enables ATAPI devices for patch testing, though jejb is
working on a better fix:
02-libata-atapi-handle-failed-report-luns_2.patch

This goes with the new EH strategy code:
29-libsas-ata-assign-task-to-cmd_1.patch
30-libsas-ata-sas-task-abort_1.patch

I appreciate any feedback/comments/flames people have about this patch
set.  Thanks!

--D
