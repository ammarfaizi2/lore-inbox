Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbVIOMcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbVIOMcw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 08:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbVIOMcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 08:32:52 -0400
Received: from ns.sevcity.net ([193.47.166.213]:11450 "EHLO mail.sevcity.net")
	by vger.kernel.org with ESMTP id S1030258AbVIOMcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 08:32:51 -0400
Subject: [BUG] signal deliver or scheduler issue.
From: Alex Lyashkov <shadow@psoft.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Positive Software
Message-Id: <1126787558.3384.15.camel@berloga.shadowland>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-16) 
Date: Thu, 15 Sep 2005 15:32:39 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List

how i see 2.6 kernels have issue (my test with all RHEL3 and RHEL4
kernels) with deliver SIG_CHILD signal.
It can be replicate very trivial.
start Midnight Commander and run LTP from MC prompt, after first test
LTP is stoping.
ps ax show:
1872 pts/1    Ss     0:00 bash -rcfile .bashrc
1891 pts/1    S+     0:00 /bin/sh ./runltp
1993 pts/1    S+     0:00 /root/work/ltp/pan/pan -e -S -a 1891 -n 1891
-f /tmp/
1994 pts/1    T      0:00 sh -c ulimit -c 1024;abort01
1995 pts/1    T      0:00 abort01

small investigate show it issue can be fixed with remove schedule() at
finish_stop function, but it broke other cases.

It`s know issue ?

-- 
FreeVPS Developers Team  http://www.freevps.com
Positive Software        http://www.psoft.net

