Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266370AbUAHXeT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 18:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUAHXeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 18:34:19 -0500
Received: from node-40244ee2.sfo.onnet.us.uu.net ([64.36.78.226]:16004 "EHLO
	fw.dongkiru.net") by vger.kernel.org with ESMTP id S266370AbUAHXeR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 18:34:17 -0500
Date: Thu, 8 Jan 2004 15:34:16 -0800 (PST)
From: LKML <lkml@dongkiru.net>
To: linux-kernel@vger.kernel.org
cc: gibbs@scsiguy.com
Subject: Odd speed problems with aic79xx drivers on RHEL
Message-ID: <Pine.LNX.4.44.0401081518570.5480-100000@fw.dongkiru.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a Dual Xeon server with onboard aic79xx based controller, which is
connected to a 16port SATA-SCSI RAID unit, which supports Ultra160.

When we first got the server, it was running RH9 with a custom kernel, and
we were getting bonnie++ test results of 100MB/s read and write speed on
the custom 2.4.21 based kernel(with aic79xx driver 1.3.x) while keeping a
load average of approximatel 1.7.

Once we installed Redhat Enterprise Linux AS 3.0, with its 2.4.21-4.EL
kernel, we've been getting write speed of 120MB/s, but read speed of only
about 50MB/s.  That's right, read is slower than write.  I've tried upping
the TCQ from the default of 32 to 253, and that decreased the read speed
even further, down to 40MB/s.

We've tried putting back on the server vendor's custom kernel, but that
kernel now seg faults whenever we run bonnie++.

I've tried recomping the Enterprise kernel with the latest aic79xx driver
from Justin's site, with no change.  Turning TCQ turned off, I was able to
get 95MB/s read and write, but at a much higher load average of 2.9.
Shouldn't enabling TCQ improve the speed?  Any thoughts or suggestions on
what to try next?

- John

