Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272875AbTHEQzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272899AbTHEQxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:53:25 -0400
Received: from host-208-46-192-132.sierradesign.com ([208.46.192.132]:63760
	"HELO mailsrv1.sierradesign.com") by vger.kernel.org with SMTP
	id S272874AbTHEQv3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:51:29 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Steve Snyder <ssnyder@sierradesign.com>
Organization: Sierra Design Group
To: linux-kernel@vger.kernel.org
Subject: APIC errors seen on v2.4.21
Date: Tue, 5 Aug 2003 09:51:26 -0700
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200308050951.26186.ssnyder@sierradesign.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I found 2 APIC errors in my system log:

  Aug  5 10:45:27 helios kernel: APIC error on CPU0: 00(02)
  Aug  5 10:45:27 helios kernel: APIC error on CPU1: 00(02)

Perhaps this is just coincidence but I had just closed an application that 
uses the serial port.  The serial driver is integral to the kernel, not 
built as a module.  

A snippet of log file, showing the context of the errors, is shown below.  
It documents my shutting down HylaFAX, the errors occurring, and 
restarting HylaFAX.  The APIC errors occurred 38 seconds after closing the 
serial port.

My environment:
  Red Hat Linux v7.3 + all RH updates + plain-vanilla kernel v2.4.21
  Dual Pentium3/850MHz on a Giga-Byte GA-6BXDU motherboard 

The Linux Kernel FAQ (at http://www.tux.org/lkml/#s13-4) says not to worry 
about only a few such errors.  OK, I won't.  I am noting this behavior in 
case anyone is interested.

Thanks.

------------------------

Aug  5 10:44:49 helios FaxQueuer[1072]: QUIT
Aug  5 10:44:49 helios hylafax: Shutting down HylaFAX queue manager (faxq): succeeded
Aug  5 10:44:49 helios hylafax: hfaxd shutdown succeeded
Aug  5 10:44:49 helios FaxGetty[1082]: CAUGHT SIGNAL 15
Aug  5 10:44:49 helios hylafax: faxgetty shutdown succeeded
Aug  5 10:45:27 helios kernel: APIC error on CPU0: 00(02)
Aug  5 10:45:27 helios kernel: APIC error on CPU1: 00(02)
Aug  5 11:07:51 helios FaxQueuer[25301]: HylaFAX (tm) Version 4.1.7
Aug  5 11:07:51 helios FaxQueuer[25301]: Copyright (c) 1990-1996 Sam Leffler
Aug  5 11:07:51 helios FaxQueuer[25301]: Copyright (c) 1991-1996 Silicon Graphics, Inc.
Aug  5 11:07:51 helios hylafax: faxq startup succeeded
Aug  5 11:07:51 helios HylaFAX[25306]: HylaFAX INET Protocol Server: restarted.
Aug  5 11:07:51 helios hylafax: hfaxd startup succeeded
Aug  5 11:07:51 helios hylafax: faxgetty startup succeeded

------------------------

