Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWHNNMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWHNNMS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 09:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWHNNMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 09:12:18 -0400
Received: from erik-slagter.demon.nl ([83.160.41.216]:49053 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S932081AbWHNNMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 09:12:17 -0400
Subject: md mirror / ext3 / dual core performance strange phenomenon?
From: Erik Slagter <erik@slagter.name>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 14 Aug 2006 15:12:14 +0200
Message-Id: <1155561134.7809.27.camel@skylla.slagter.name>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This may be a very stupid question or equally misplaced but I really
don't know where to ask it elsewhere.

I have this configuration (imho significant parts): dual core P915, 2x
sata harddisk configured as (root) md mirror on intel ICH7R (ahci mode),
1G ram.

The harddisks can sustain both around 55 Mb/s, according to hdparm -tT
(okay, I now that's only straight reads). Also they can deliver this
amount of data independent of each other, if both hdparms are run in
parallel, the same performance is reported. I also did similar tests
using ddrescue which shows the same.

Now, what puzzles me, is that compiling the kernel (2.6.17.7) using
either "make -j1 ..." or "make -j2 ..." or "make -j3 ..." makes the
building take about 6.5 minutes, which is really dissatisfying for this
cpu/harddisks combination. Also, top shows that most of the time both
core are between 10-40% idle.

BUT... starting from -j4 (and upwards) the compile time suddenly goes to
3.5 minutes!

I am really blown away here. It looks like disk access is the bottleneck
here, but I can't imagine my disks being so slow (at seeking, I guess)
it should matter that much.

So, I tried changing the readahead value of all relevant devices and...
there is no difference at all!

I changed journalling parameters to data writeback and commit time =
30s. Still no difference.

I kicked one of the two disks out of the mirror. Still no joy.

Then, I tried all i/o schedulers on all relevant devices (except md0 of
course) and... still no difference at all!

Is there anybody who can shed some light on this or give me a clue or
pointer?

