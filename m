Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278004AbRJIWBO>; Tue, 9 Oct 2001 18:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278005AbRJIWBE>; Tue, 9 Oct 2001 18:01:04 -0400
Received: from pC19F9C6D.dip.t-dialin.net ([193.159.156.109]:10756 "EHLO
	router.abc") by vger.kernel.org with ESMTP id <S278004AbRJIWAx> convert rfc822-to-8bit;
	Tue, 9 Oct 2001 18:00:53 -0400
Message-ID: <3BC373A8.CD94917B@baldauf.org>
Date: Wed, 10 Oct 2001 00:01:13 +0200
From: Xuan Baldauf <xuan--lkml@baldauf.org>
Organization: Medium.net
X-Mailer: Mozilla 4.78 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: dynamic swap prioritizing
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a linux box with 3 harddisks of different
characteristics (size, seek time, throughput), each capable
of holding a swap partition. Sometimes, one harddisk is
driven heavily (e.g. database application), sometimes, the
other harddisk is busy.

I imagine following optimization:
- all swap partitions have the same priority from the start
on
- runtime statistics are gathered covering response time
(time from page request to availability)
- the fastest drive is used first (or maybe in striping mode
parallely woth the second-fastest drive)
- because the fastest drive will be more busy, its response
times will rise, reaching equality with other drives
- at that point, other drives are also considered for
swapout
- that system regularily adapts its decisions based on
recent statistics ("recent" is a tuning parameter)

Such an algorithm also would properly prioritize
network-swap and video-memory-swap, reducing time and cost
of a manual priority configuration (and statistics
gathering).

Does the linux kernel already implement such an
optimization? Is it planned?

Xuân.


