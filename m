Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbTJGQkY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 12:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTJGQkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 12:40:24 -0400
Received: from 11.ylenurme.ee ([193.40.6.11]:64472 "EHLO linking.ee")
	by vger.kernel.org with ESMTP id S262484AbTJGQkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 12:40:19 -0400
Date: Tue, 7 Oct 2003 19:39:02 +0200 (EET)
From: Elmer <elmer@linking.ee>
X-X-Sender: elmer@server
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: BUG: softraid,ext3 lockup
In-Reply-To: <Pine.LNX.4.44.0310062138350.1556-100000@logos.cnet>
Message-ID: <Pine.LNX.4.44.0310071920350.16593-100000@server>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



all kernels I have seen are slugish on ide-raid large raw write,

However, now I got some performance test:

dualprocessor server has hda,hdb ibm-hitatchi
	7200 rpm IC35L060AVV207-0, 1860kb cache
uniprocessor  has hda,hdc(was hdb,no diff) western digital
	7200 rpm WDC WD400BB-23DEA0 2000kb cache


Also tested with hdparm -W 1

server      | writeback              |writetrough
------------|------------------------|-----------
dual + ibm: |24 sec,40MB/s,load 1-2  |90 sec 11MB/s,2-4
uni + wdc:  |36 sec,27MB/s,load 1-2  |160 sec 6MB/s,4-7..40


with harddisc writeback the problem does not manifest itself

the problem is present when I do this directly to raw partition /dev/hda2,
(while raid is running on same discs with very slim load and swap being
off, 1GB mem and lots free)

So there are two possible causes now:

1. ServerWorks CSB5 Chipset (rev 93) or driver plus hardiscs
2. Kernel itself, gets too high io performance and everything else is
stuck. So when IO troughput gets a bit higher, the bottleneck goes away.
When some other processes want a little time, they all get very stuck and
load goes to hell.


Elmer.


