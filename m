Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbUBYX2R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbUBYXZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:25:11 -0500
Received: from [209.124.89.92] ([209.124.89.92]:7588 "EHLO removed")
	by vger.kernel.org with ESMTP id S261624AbUBYXXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:23:09 -0500
From: Anton Petrusevich <casus@att-ltd.biz>
To: linux-kernel@vger.kernel.org
Subject: ftruncate64
Date: Thu, 26 Feb 2004 05:23:10 +0600
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402260523.10394.casus@att-ltd.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

That looks funny:
casus@jabbervorx:~$ dd if=/dev/zero of=hole bs=1k count=1 seek=2047M
1+0 records in
1+0 records out
1024 bytes transferred in 0,000133 seconds (7696845 bytes/sec)
casus@jabbervorx:~$ dd if=/dev/zero of=hole bs=1k count=1 seek=2048M
dd: advancing past 2199023255552 bytes in output file `hole': File too large

strace shows the errorneous call:
ftruncate64(1, 2199023255552)           = -1 EFBIG (File too large)

This behavour is observed with 2.4.23 and 2.6.3-rc1 kernels. And with 
2.4.20-28.9smp redhat kernel too. But not with RHEL3 kernels. Looks like 
RedHat silently fixed that bug.

-- 
Anton Petrusevich

