Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbVJEHQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbVJEHQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 03:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbVJEHQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 03:16:28 -0400
Received: from quark.didntduck.org ([69.55.226.66]:14739 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932562AbVJEHQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 03:16:28 -0400
Message-ID: <43437DEB.4080405@didntduck.org>
Date: Wed, 05 Oct 2005 03:16:59 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.4 (X11/20050928)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Andi Kleen <ak@suse.de>
Subject: Bogus load average and cpu times on x86_64 SMP kernels
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been seeing bogus values from /proc/loadavg on an x86-64 SMP kernel 
(but not UP).

$ cat /proc/loadavg
-1012098.26 922203.26 -982431.60 1/112 2688

This is in the current git tree.  I'm also seeing strange values in 
/proc/stat:

cpu  2489 40 920 60530 9398 171 288 1844674407350
cpu0 2509 60 940 60550 9418 191 308 0

The first line is the sum of all cpus (I only have one), so it's picking 
up up bad data from the non-present cpus.  The last value, stolen time, 
is completely bogus since that value is only ever used on s390.

It looks to me like there is some problem with how the per-cpu 
structures are being initialized, or are getting corrupted.  I have not 
been able to test i386 SMP yet to see if the problem is x86_64 specific.

--
				Brian Gerst
