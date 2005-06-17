Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVFQKWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVFQKWH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 06:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVFQKWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 06:22:07 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:24295 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261936AbVFQKV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 06:21:58 -0400
Date: Fri, 17 Jun 2005 12:21:55 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc6 missing commit(s) in cpufreq?
Message-Id: <20050617122155.0d8190c2.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


According to:
http://www.kernel.org/pub/linux/kernel/v2.6/testing/ChangeLog-2.6.12-rc6

There should be a:

commit 1206aaac285904e3e3995eecbf4129b6555a8973
Author: Dave Jones <davej@redhat.com>
Date:   Tue May 31 19:03:48 2005 -0700

    [CPUFREQ] Allow ondemand stepping to be changed by user.

And when I look at:
http://www.kernel.org/git/?p=linux/kernel/git/davej/cpufreq.git;a=commit;h=1206aaac285904e3e3995eecbf4129b6555a8973

There are changes in the diff like:

--- drivers/cpufreq/cpufreq_ondemand.c
+++ drivers/cpufreq/cpufreq_ondemand.c
@@ -79,6 +79,7 @@ struct dbs_tuners {
unsigned int up_threshold;
unsigned int down_threshold;
unsigned int ignore_nice;
+ unsigned int freq_step;
};

Problem is that neither a clean 2.6.11 patched with patch-2.6.12-rc6 nor
a full linux-2.6.12-rc6.tar.bz (I just downloaded it) contain that
commit.

The first example from above looks like:

struct dbs_tuners {
        unsigned int            sampling_rate;
        unsigned int            sampling_down_factor;
        unsigned int            up_threshold;
        unsigned int            ignore_nice;
};

Even more strange is the other discrepancies in that list, suggesting
other missed commits. Live directory from 2.6.12-rc :

root:sleipner:/sys/devices/system/cpu/cpu0/cpufreq/ondemand# ls
total 0
0 ignore_nice           0 sampling_rate      0 sampling_rate_min
0 sampling_down_factor  0 sampling_rate_max  0 up_threshold

Perhaps this is why I can't get the conservative governor to work at all
(it just sits at the freq at which it was loaded, never going up/down no
matter the load).

Mvh
Mats Johannesson
--
