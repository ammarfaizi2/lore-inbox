Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVHUVgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVHUVgs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVHUVgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:36:48 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:17389 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751155AbVHUVgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:36:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=S9jIkfEWACcvCVO2XWff9Etb8l6MLwQmb3oOzOvMOe8KmUthlHiTXKYLByfx0Evvay7TjcqYvxunNk79hqAQErLeqn88pF9OYJLgQMhY6G3E6IqYfeN4SPECY2l7krlX7U87uSTep8Wq15pmXfacJa3K+tXEy62tcCfCrZuBvzQ=
Date: Mon, 22 Aug 2005 01:45:42 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Unused defines: some numbers
Message-ID: <20050821214541.GA28803@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Inspired by LWN article "Our [desktop] bloat problem" and a comment
about probability of finding unused prototype in kernel.

This is purely FYI.

   version   |   LOC   |    size   | nr_defines | nr_used | bloat |
             |  *.[ch] |   *.[ch]  |     [1]    |   [2]   |   %   |
-------------+---------+-----------+------------+---------+-------+
        0.01 |    8413 |    190551 |        698 |     398 | 42.98 | [4]
         1.0 |  165165 |   4413579 |       5791 |    4472 | 22.78 |
         1.2 |  281985 |   7599324 |      10840 |    7721 | 28.77 |
         1.3 |  310545 |   8332410 |      11637 |    8303 | 28.65 |
         2.0 |  674422 |  18866984 |      23804 |   16746 | 29.65 |
2.6.13-rc6-? | 6133558 | 180252914 |     248063 |  151492 | 38.93 | [3]

Consider the numbers as zero-order approximation because of obvious
flaws in this "research":

* Once one layer of unused defines is removed, another appears
  (real bloat >= bloat).
* Possible ## obfuscation (real bloat <= bloat).
* _Of_course_, my regexp-fu sucks (real nr_defines != nr_defines).
* Counting doesn't understand that
	include/asm-alpha/unistd.h: #define FUBAR 1
	include/asm-sparc/unistd.h: #define FUBAR 1
   means "unused" (real bloat >= bloat).
* Some numbers in *.c files can be these unused defines
  (real bloat <= bloat).

HTH to not put every single piece of hardware spec into kernel next
time.

P. S.: regk_iop_sw_cfg_rw_fifo_out1_extra_owner_default, no less.
-------------------------------------------------------------------
[1] As in

	find . -type f -name *.[ch]		| \
		xargs grep "#[\t ]*define[\t ]"	| \
		sed "s/.*#[\t ]*define[\t ]*//"	| \
		sed "s/[\t (].*//"		| \
		sort -u

[2] "used" means

	grep $DEFINE -w -r . | wc -l	>= 2

[3] Quite recent 2.6.13-rc6-git-something. I forgot [to cat down] exact version. 
[4] Not Linus's fault ;-). Remember about __NR_*.

