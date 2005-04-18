Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVDRPRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVDRPRg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 11:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVDRPRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 11:17:35 -0400
Received: from mail.ccur.com ([208.248.32.212]:7080 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S262103AbVDRPRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 11:17:14 -0400
Subject: nonlinear timeslice gap?
From: Jason Baietto <jason.baietto@ccur.com>
To: linux-kernel@vger.kernel.org
Cc: nickpiggin@yahoo.com, mingo@elte.hu
Content-Type: text/plain
Message-Id: <1113837431.26528.39.camel@sprout>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 18 Apr 2005 11:17:12 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Apr 2005 15:17:12.0531 (UTC) FILETIME=[B2479230:01C54429]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1832.6.22 (2004/08/24 11:10:51 mingo@elte.hu) introduced the
following time slice mapping for nice values:

   [ -20 ... 0 ... 19 ] => [800ms ... 100ms ... 5ms]

This met the goal of a 1:160 ratio for nice-20/nice+19, however it
introduced a 320ms gap between 0 and -1.  Was this gap intentional or
accidental, and is it really acceptable?

Here's the full mapping (verified by sched_rr_get_interval):

-20 => 800ms
-19 => 780ms
-18 => 760ms
-17 => 740ms
-16 => 720ms
-15 => 700ms
-14 => 680ms
-13 => 660ms
-12 => 640ms
-11 => 620ms
-10 => 600ms
 -9 => 580ms
 -8 => 560ms
 -7 => 540ms
 -6 => 520ms
 -5 => 500ms
 -4 => 480ms
 -3 => 460ms
 -2 => 440ms
 -1 => 420ms *** gap ***
  0 => 100ms
  1 => 95ms
  2 => 90ms
  3 => 85ms
  4 => 80ms
  5 => 75ms
  6 => 70ms
  7 => 65ms
  8 => 60ms
  9 => 55ms
 10 => 50ms
 11 => 45ms
 12 => 40ms
 13 => 35ms
 14 => 30ms
 15 => 25ms
 16 => 20ms
 17 => 15ms
 18 => 10ms
 19 => 5ms

Take care,
Jason
--
jason.baietto@ccur.com
http://www.ccur.com/oss

