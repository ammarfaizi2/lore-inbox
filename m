Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264129AbUDVPb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUDVPb5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbUDVPb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:31:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36575 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264132AbUDVPbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:31:01 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16519.58589.773562.492935@segfault.boston.redhat.com>
Date: Thu, 22 Apr 2004 11:29:33 -0400
To: linux-kernel@vger.kernel.org
Subject: netconsole hangs w/ alt-sysrq-t
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If netconsole is enabled, and you hit Alt-Sysrq-t, then it will print a
small amount of output to the console(s) and then hang the system.  In this
case, I'm using the e100 driver, and we end up exhausting the available
cbs.  Since we are in interrupt context, the driver's poll routine is never
run, and we loop infinitely waiting for resources to free up that never
will.  Kernel version is 2.6.5.

No easy solutions jump out at me, unfortunately.  Comments?

Regards,

Jeff
