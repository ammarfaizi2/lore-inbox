Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbTDLKcD (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 06:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263230AbTDLKcD (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 06:32:03 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:53638 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S263229AbTDLKcC convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 06:32:02 -0400
content-class: urn:content-classes:message
Subject: RE: [BUG] settimeofday(2) succeeds for microsecond value more than USEC_PER_SEC and for negative value
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Sat, 12 Apr 2003 16:13:33 +0530
Message-ID: <94F20261551DC141B6B559DC491086723E10C2@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] settimeofday(2) succeeds for microsecond value more than USEC_PER_SEC and for negative value
Thread-Index: AcMAcn0J/0sNbQvnT7e1iVshKtvuAgAbUPdg
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: "george anzinger" <george@mvista.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Apr 2003 10:43:33.0855 (UTC) FILETIME=[5D8AAEF0:01C300E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

|Aniruddha M Marathe wrote:
|> Even then, I think, we can modify the settimeofday  code to 
|check -1 and USEC_PER_SEC
|> Conditions, can't we?
|> 

George wrote:

|Uh, sure.  This is the test I prefer:
|
|	if( (unsigned long)tv->usec > USEC_PER_SEC)
|		return EINVAL;
|
|
|This change should go in do_sys_settimeofday() in kernel/time.c.  It 
|will fix both settimeofday and clock_settime(CLOCK_REALTIME,...  And 
|also fixes it in all archs.
|
|-g

How about
If( (unsigned long)tv->usec >= USEC_PER_SEC)
	return EINVAL;

Even if tv_usec value is 10^6, it should give EINVAL.
Man page must also be updated
