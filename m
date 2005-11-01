Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbVKAUCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVKAUCp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVKAUCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:02:44 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:27162 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751261AbVKAUCo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:02:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lTnFyxTC56dcsye5u3J9N401+b1vAuNZxSHVzT1qo5S5GIx6ZhGXNYE/0U/U19+vlJKUk746a3GwPaHCtX2enIp4Mn29dBFl1uEF9S/XM2zmYYA/5Gi0RXP3fvfvzD8C2lwkmwu7ijOKzuJHJF6aI3EDNkgpDK3SZOZWHSgazQM=
Message-ID: <cb2ad8b50511011202l5bdc8c82se145adf158221e28@mail.gmail.com>
Date: Tue, 1 Nov 2005 15:02:43 -0500
From: Carlos Antunes <cmantunes@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Realtime-preempt performs worse for many threads?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've been developing some code for the OpenPBX project
(http://www.openpbx.org) and wrote a program to test how the system,
responds when hundreds of threads are spawned. These threads run at
high priority (SCHED_FIFO) and use clock_nanocleep with absolute
timeouts on a 20ms loop cycle.

With the stock 2.6.14 kernel, I get latencies in the order of several
milliseconds (but less than 20ms) when running 1250 threads
simultaneously. However, when I switch to a kernel patched with
realtime-preempt latency increases to several hundred milliseconds in
many cases.

When I only only spawn 10 or so threads, realtime-preempt gives me
latencies of less than 1ms while the stock kernel still gives me a few
milliseconds. However, when the number of threads sleeping on
clock_nanosleep increases to several hundred, things just break.

Should I assume that realtime-preempt at this time is not ready to
deal with hundreds of realtime threads sleeping most of the time on
clock_nanosleep?

Any ideas on how to maybe debug this and see if there is some kind of problem?

Thanks!

Carlos



--
"We hold [...] that all men are created equal; that they are
endowed [...] with certain inalienable rights; that among
these are life, liberty, and the pursuit of happiness"
        -- Thomas Jefferson
