Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265929AbTFSVWi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 17:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265965AbTFSVWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 17:22:38 -0400
Received: from gherkin.frus.com ([192.158.254.49]:50560 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S265929AbTFSVWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 17:22:37 -0400
Subject: 2.5.72: SCSI tape error handling
To: linux-kernel@vger.kernel.org
Date: Thu, 19 Jun 2003 16:36:35 -0500 (CDT)
Cc: axboe@suse.de, Kai.Makisara@metla.fi
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20030619213635.AD2874F01@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to do the responsible thing and back up my system today
(for the first time in too many weeks :-)), and got the following
errors in syslog about 15 minutes into the process:

Jun 19 09:55:04 gherkin kernel: st0: Error with sense data: Info fld=0x3ba, Deferred stst0: sense key Medium Error
Jun 19 09:55:04 gherkin kernel: Additional sense: Write append position error
Jun 19 09:55:04 gherkin kernel: st0: Error with sense data: Current stst0: sense key Medium Error
Jun 19 09:55:04 gherkin kernel: Additional sense: Write append position error
Jun 19 09:55:04 gherkin kernel: st0: Error with sense data: Current stst0: sense key Medium Error
Jun 19 09:55:04 gherkin kernel: Additional sense: Write append position error
(... ad infinitum for the next three hours -- backup was unattended.
There were no error messages of any kind on the console.)

I'm going to ASSume that cpio would have done something appropriate if
the underlying write() call had returned some kind of error.  The fact
that write() is evidently NOT returning an error is a problem.  For me,
it's a show-stopper.  I can handle bad tapes if the userland side of
things will report there's a problem.

st0 is an Exabyte 8mm tape drive.  SCSI adapter is an Adaptec 2930U2
using the new aic7xxx driver (as included with the 2.5.72 kernel).

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
