Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbTEORAE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 13:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264130AbTEORAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 13:00:04 -0400
Received: from fmr05.intel.com ([134.134.136.6]:39675 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264129AbTEORAD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 13:00:03 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Problem with e100 driver and latency on different packet sizes
Date: Thu, 15 May 2003 10:12:34 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010107D6D0@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem with e100 driver and latency on different packet sizes
Thread-Index: AcMa8valj1p1ADDeSQuVea4hTsN+CAAEV4Fg
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Corey Minyard" <cminyard@mvista.com>,
       "LKML" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 May 2003 17:12:35.0224 (UTC) FILETIME=[2DB6B180:01C31B05]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've attached a small program to measure latency of 
> round-trip time on UDP.  If I send 85-byte packets between 
> two of my machines, I get 170us round-trip latency.  If I 
> send 86-byte packets, I get 1329us latency. 
> This seems quite odd.  If I test on the eepro100 driver, I 
> get expected linear increase in round-trip time as the packet 
> size increases, and it never gets close to 1300us.

This sounds like a side-effect of the "CPU Cycle Saver" feature to
bundle Rx packets per one interrupt.  See
Documentation/networking/e100.txt.  I haven't tried your setup, but I
would guess that you can play around with the BundleSmallFr module
parameter, or better yet, if you want the lowest latencies, turn off CPU
Saver (ucode=0).

CPU Saver trades latency for reduced interrupts, resulting in CPU
savings, hence the name.

Hope this helps.

-scott
