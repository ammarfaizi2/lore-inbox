Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTJMJct (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 05:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTJMJct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 05:32:49 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:41899 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S261598AbTJMJcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 05:32:48 -0400
Message-ID: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Date: Mon, 13 Oct 2003 18:31:16 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Andreas Jellinghaus's suggestion, I ran smartctl logs and tests.
My Linux questions increase in number, but first here are the results.

Before testing, the log included a count of 92 errors, of which the
latest 5 had details available.  Reallocated_Sector_Ct was 1 and
Reallocated_Event_Count was 1.  The offline test succeeded and changed
nothing.  The long self-test found one read error.  After testing, the log
still included a count of 92 errors, of which the latest 5 had details
available, and they were the same 5, so the firmware didn't update
that log with the error that was detected by its self-test.    However,
Reallocated_Sector_Ct was 2 and Reallocated_Event_Count was 2.

The self-test saved one detail of its read error separately from the main
log.  LBA_of_first_error was 0x0122403a.  In decimal this was a very
familiar-looking 19021882.

The sector is in a Reiser partition, which might affect some of the
following questions.

So, why do the syslog entries have so many "sector" numbers, which are
mostly different except for some repetitions, and mostly different from
"LBAsect"?  It seems that LBAsect is the correct number of the bad sector.

How can I find out which file contains the bad sector?  I would like to try
to recreate the file from a source of good data.

How can I tell Linux to mark the sector as bad, knowing the LBA sector
number?

Or did the drive's firmware mark the sector as bad during its self-test?  Is
this why the number of reallocations increased from 1 to 2?  But if so, why
didn't this happen when Linux tried to read the sector?

How can I tell Linux to read every sector in the partition?  Oh, I might
know this one,
  dd if=/dev/hda8 of=/dev/null
I want to make sure that the drive is now using a non-defective replacement
sector.

