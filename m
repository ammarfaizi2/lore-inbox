Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUFKIfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUFKIfM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 04:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUFKIfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 04:35:12 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:32787 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261389AbUFKIfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 04:35:05 -0400
Subject: PROBLEM: Heavy iowait on 2.6 kernels
From: Guy Van Sanden <n.b@myrealbox.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086942905.10540.69.camel@cronos.home.vsb>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 11 Jun 2004 10:35:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently discovered why my new Gentoo server slows to a crawl on a
intermediate load on the 2.6 kernel series.  The reason seems to be an
unusual amount of iowait.
I can reproduce this on two systems, one with a KT400 and and one with
Sis735 chipset.

iostat -c 1 (or vmstat) while running something like bonnie produces
iowaits of 99%.
Any 2.6 kernel responds the same (regardless of the patchset), even
vanilla. (2.6.5-mm, 2.6.6-mm, 2.6.6-vanilla and 2.6.5-gentoo-r1).
Any 2.4-series kernel is fine.

This is a sample iostat output
--
avg-cpu:  %user   %nice    %sys %iowait   %idle
          26.73    0.00   10.89   62.38    0.00
avg-cpu:  %user   %nice    %sys %iowait   %idle
           0.00    0.00   13.00   87.00    0.00
avg-cpu:  %user   %nice    %sys %iowait   %idle
           1.01    0.00   16.16   82.83    0.00
avg-cpu:  %user   %nice    %sys %iowait   %idle
           0.00    0.00   11.88   88.12    0.00
avg-cpu:  %user   %nice    %sys %iowait   %idle
           0.00    0.00    1.01   98.99    0.00
avg-cpu:  %user   %nice    %sys %iowait   %idle
           0.99    0.00    2.97   96.04    0.00
--
-- 
______________________________________________________________________  

  Guy Van Sanden 
  http://unixmafia.port5.com  

  Registered Linux user #249404 - September 1997
______________________________________________________________________

