Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbTLPS2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 13:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTLPS2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 13:28:40 -0500
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:38067 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP id S262048AbTLPS2j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 13:28:39 -0500
To: linux-kernel@vger.kernel.org
Subject: Trivial hard lockup, SCSI, 2.4.23
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Tue, 16 Dec 2003 13:28:38 -0500
Message-ID: <9cfiskgpqg9.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've found that I can lock a machine running 2.4.23aa1 by trying to
access a nonexistent SCSI device.  In other words, if a userspace
program tries to access /dev/sdd, but no device is attached on any
SCSI bus using that device node, the machine locks hard.

We found this when we disconnected a SCSI hardware RAID from a server,
but forgot to remove the cron job which checked its status.

The lockup leaves no errors whatsoever in the logs.  I finally tracked
it down with the NMI watchdog.

Ian


