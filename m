Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbTH1OqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 10:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264013AbTH1OqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 10:46:04 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:43952 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263975AbTH1OqC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 10:46:02 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [RFC] /proc/ide/hdx/settings with ide-default pseudo-driver is a 2.6/2.7 show-stopper
Date: Thu, 28 Aug 2003 16:46:16 +0200
User-Agent: KMail/1.5
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308281646.16203.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Some background first: we need ide-default driver (set as a device driver
for all driver-less ide devices) mainly because we allow changing devices
settings through /proc/ide/hdX/settings and some of them (current_speed,
pio_mode) are processed via request queue (we are currently preallocating
gendisk and queue structs for all possible ide devices).  The next problem
is that ide-default doesn't register itself with ide and driverfs.
If it does it will "steal" devices meaned to be used by other drivers.

If we want dynamic hwifs/devices, moving gendisks/queues allocation
to device drivers and ide integration with driverfs we need to:

(a) kill /proc/ide/hdX/settings for driver-less devices and kill ide-default

or

(b) add much more shit to ide-default and deal with driver ordering madness
    when integrating with driverfs

Any important reasons why we cant chose solution (a)?

--bartlomiej

