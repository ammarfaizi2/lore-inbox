Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268130AbUJDM6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268130AbUJDM6j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 08:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268132AbUJDM6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 08:58:39 -0400
Received: from open.hands.com ([195.224.53.39]:43686 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268130AbUJDM6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 08:58:33 -0400
Date: Mon, 4 Oct 2004 14:09:42 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: [bug] 2.6.8: CDROM_SEND_PACKET ioctls failing as non-root on ide scsi drives
Message-ID: <20041004130941.GE19341@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 2.6.8.  ioctl ("/dev/hdc", CDROM_SEND_PACKET, cmd)

commands that are failing as non-root, even when permission is granted
rwxrwxrwx to /dev/hdc, are, according to some debug info added to k3b:

	GET CONFIGURATION (46)
	error code: 0
	sense key: NO SENSE (2)
	asc: 0
	ascq: 0

and:

	MODE SELECT (55)
	error code: 0
	sense key: NO SENSE (2)
	asc: 0
	ascq: 0

the result is that k3b cannot determine that the drive exists, therefore
it cannot use it even though cdrecord might actually work.


as root, the following errors occur:

	MODE SELECT (46)
	errorcode: 70
	sense key: ILLEGAL REQUEST (5)
	asc: 26
	ascq: 0

	READ DVD STRUCTURE (ad)
	errorcode: 70
	sense key: NOT READY (2)
	asc: 3a
	ascq: 0

presumably it can be concluded that the GET CONFIGURATION ioctl command
is the one at fault.

... what gives?

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

