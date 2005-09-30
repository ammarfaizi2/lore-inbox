Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbVI3ODX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbVI3ODX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 10:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbVI3ODX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 10:03:23 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:4832 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030302AbVI3ODW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 10:03:22 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 30 Sep 2005 15:03:08 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: New and bogus(!) warning produced by sparse.
Message-ID: <Pine.LNX.4.60.0509301459020.23217@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I just did a git pull on sparse and it produced a new and I believe 
bogus warning when trying to assign a value to a bit field member.  The 
warning is:

warning: generating address of non-lvalue (1)

Below is an example program that triggers the warning when you run:

	sparse sparse-test.c

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

--- sparse-test.c ---

int main(void)
{
	struct {
		unsigned bit1:1;
		unsigned bit2:1;
	} bits = { 0, 0 };

	bits.bit1 = 1; /* sparse warns here! */
	bits.bit2 = 0; /* sparse warns here! */
	return 0;
}
