Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUEXLJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUEXLJD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 07:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264215AbUEXLJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 07:09:03 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:56966 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264251AbUEXLJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 07:09:00 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: <linux-kernel@vger.kernel.org>
Subject: Memory starvation in linux
Date: Mon, 24 May 2004 04:12:14 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRBcZru1IqZXgmaQIaKSa31QzUAxg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <S264251AbUEXLJA/20040524110900Z+622@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the proper way to determine that memory is low in linux?

In solaris, after Solaris 8 it is sufficient to check for a non-zero scan
rate in vmstat output which represents whether the two-handed clock
algorithm is running looking for pages to evict. Since it only turns on when
free physical memory (freemem) reaches 1/64 total physical memory (lotsfree)
it's a decent indicator of starvation.

Previous to Solaris 8, it was far more complex. File system I/O would fill
up the pagecache and this would qualify as used memory. This mean that on an
I/O bound system, the scanner would run regardless. There was a bandaid for
this called priority paging where you could look to see if freemem was
between two watermarks, (lotsfree and cachefree) but otherwise you just had
to guess by observing the number of filesystem page ins/outs vs executable
and anonymous page outs.

What is the proper way to go about checking memory utilization in linux?
Does the pagecache count as free memory in linux or does it compete freely
with executable and libraries to stay resident?

I would love to RTFM if someone would just please direct me to the "fine
manual" I

Thanks in advance,

--Buddy

