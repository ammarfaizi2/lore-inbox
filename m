Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030669AbWHKCTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030669AbWHKCTr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 22:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030671AbWHKCTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 22:19:47 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:19641 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030669AbWHKCTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 22:19:46 -0400
Message-ID: <44DBE93F.1040005@us.ibm.com>
Date: Thu, 10 Aug 2006 19:19:43 -0700
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
Subject: [PATCH 0/2] Add SATA support to libsas/aic94xx
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been working on a preliminary patch to enable SATA disk support in
the SAS transport layer.  As it stands now, the patch hooks several
scsi_host_template functions to delegate various port allocation and
command processing functions to libata; this also requires the creation
of a few more functions to ensure that all the scsi_host_template
functions redirect to libata when necessary.  There are also some
helpers so that the hooks don't unduly lengthen the existing functions.
 I'm midway through the implementation and am looking for feedback and
suggestions about how to tighten things up.

At the moment, I've been able to get an 80G Maxtor SATA disk to come up
with the aic94xx driver in both PIO and UDMA modes.  I can do things
like streaming read/write operations, run LTP/pounder stress tests, and
programs like scsi-info and smartctl, and they seem to run ok.

However, there are several sketchy aspects to this patch--I've written
nothing in sas_expander.c to hook up to SATA disks attached to expanders
(will ask Alexis about that one), and the code that tries to push ATA
error codes at libata when SAS errors are seen is rather frightening.
Alas, I don't know ATA error codes quite well enough to feel like I'm
doing justice to the SAS errors.

These patches are based off 2.6.18-rc4 + jejb's scsi-misc, scsi-rc and
aic94xx git trees + Brian King's libata SAS patches.

Questions/comments?  Thanks in advance for feedback,

--Darrick
