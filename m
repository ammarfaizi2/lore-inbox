Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268131AbTB1UA0>; Fri, 28 Feb 2003 15:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268140AbTB1UA0>; Fri, 28 Feb 2003 15:00:26 -0500
Received: from scrye.com ([216.17.180.1]:65261 "EHLO scrye.com")
	by vger.kernel.org with ESMTP id <S268131AbTB1UAX>;
	Fri, 28 Feb 2003 15:00:23 -0500
Message-ID: <20030228201041.8334.qmail@scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Feb 2003 13:10:38 -0700
From: Kevin Fenzi <kevin-linux-kernel@scrye.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: SCSI check sense bit not getting back to st driver
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


[ reposted under this subject instead of the old one about end of tape
handling]

I (and several others at least) have been seeing a problem with end of
tape error handling under linux. Instead of getting a ENOSPC, you get
a EIO error when you hit the end of the tape. This makes multivolume
backups kinda difficult.

Some more information on this problem was discovered by Tim Jones
<tjones@tolisgroup.com>:

Tim> Additional news.

Tim> This is actually related to the check sense bit not being
Tim> propagated up to the ST driver.  A simpler test (beats writing
Tim> 40GB to a tape ...):

Tim> use a 2.2.19/20/21 or 22 kernel, or a 2.4.9-34 kernel Remove the
Tim> tape from the tape device execute:

Tim>   tar -cvvf /dev/nst0 /etc

Tim> You will receive a "No medium found" message

Tim> Replace the kernel with 2.4.11+ and repeat the tar write test.
Tim> This time, you will receive a write failure.

Tim> This is caused by the check sense not being set and the ST driver
Tim> sending up a EIO instead of the ENOMEDIUM.

So, it looks like this problem is _not_ in the st driver itself, but
somewhere in the SCSI layer. 

Anyone have any ideas how to better track it down?

Happy to run debug code/test cases here. 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+X8JA3imCezTjY0ERAjvaAJ91SmJHXQ/d3xHZ70qDsdIFCkHQtwCeJ7rB
MGmw0pHOE0t6WfH+NC1B8W8=
=PLfR
-----END PGP SIGNATURE-----
