Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267748AbUHTI2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267748AbUHTI2S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267726AbUHTI2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:28:17 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:53592 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267737AbUHTI16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:27:58 -0400
Message-ID: <4125B601.5020303@yahoo.com.au>
Date: Fri, 20 Aug 2004 18:27:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.8.1-np1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kerneltrap.org/~npiggin/2.6.8.1-np1/

Again, this is only against 2.6.8.1-mm2 for now due to the amount of
scheduler and memory management patches in Andrew's tree.

This introduces per-zone inode and dcache scanning lists. These
introduce a theoretical problem (solveable, but would take some work)
however in practice I don't think it would cause a problem.

Also introduces "free_local_harder", which attempts to free some node
local memory before going remote. It is quite dumb at the moment, and
performs the scanning from process context (should be moved to kswapd
context), however it seems to usually do what it is supposed to. It
can be switched off by echo 0 > /proc/sys/vm/free_local_harder.

These should be good for NUMA performance, although free_local_harder
will, by definition, introduce regressions for some workloads.

Unfortunately, free_local_harder sits pretty firmly on top of my other
memory management changes, which may introduce problems themselves.
Even so, feedback would be cool.

