Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263055AbTDBQis>; Wed, 2 Apr 2003 11:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263057AbTDBQis>; Wed, 2 Apr 2003 11:38:48 -0500
Received: from franka.aracnet.com ([216.99.193.44]:62423 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263055AbTDBQir>; Wed, 2 Apr 2003 11:38:47 -0500
Date: Wed, 02 Apr 2003 08:50:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 531] New: cdrom ioctl CDROM_SEND_PACKET broken
Message-ID: <33830000.1049302207@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=531

           Summary: cdrom ioctl CDROM_SEND_PACKET broken
    Kernel Version: 2.5.66+
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: pee@erkkila.org


Distribution: gentoo/other
Hardware Environment: amd/asus p4/intel
Software Environment:
Problem Description:

  I think i've located the problem with doing generic commands
to atapi drives.

mmc_ioctl calls cdrom_do_cmd with it's own copy of cgc made
from IOCTL_IN

cdrom_do_cmd then does it's thing, and copies back into
the cgc from mmc_ioctl. And then returns, however mmc_ioctl
is returning immediatly w/o updating the user passed in cgc.

The pointers to return to user space never get updated, so if you
set all 1's in a cgc->buffer and send it in you will get all 1's back
as that buffer is not updated correctly. nor is the sense data.

It looks like the copy_to_user needs to move to mmc_ioctl, or mmc_ioctl
needs to update the user cgc correctly.


Steps to reproduce:

Run a small program that calls CDROM_SEND_PACKET, i'll attach one


