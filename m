Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTDPGQ6 (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 02:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264247AbTDPGQ6 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 02:16:58 -0400
Received: from daimi.au.dk ([130.225.16.1]:58005 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id S264246AbTDPGQ5 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 02:16:57 -0400
Message-ID: <3E9CF81F.F7CCCADF@daimi.au.dk>
Date: Wed, 16 Apr 2003 08:28:47 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] Port 0x80 writes considered harmful
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had quite some problems with the parallel port on a
computer of the model "F@MILY net" (details available on
request). While Linux was running there would constantly be
changing output lines on the parallel port.

The problem was observed with different kernel versions and
even a 2.4.19 kernel stripped so much down that it could
merely boot and panic because of missing root filesystem
drivers.

I found that if I from a userspace program using ioperm and
outb blocked interrupts the output would stop. I busylooped
for a few seconds using the TSC, and then reenabled interrupts
while interrupts was disabled there was no activity on the
parallel port.

Then I inserted port 0x80 writes in the loop, and at that
point there would be parallel port output during the entire
execution of the loop.

What would be the best solution to my problem?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
