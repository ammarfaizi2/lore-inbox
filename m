Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUHNRl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUHNRl1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 13:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUHNRl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 13:41:26 -0400
Received: from viefep18-int.chello.at ([213.46.255.21]:42541 "EHLO
	viefep18-int.chello.at") by vger.kernel.org with ESMTP
	id S264346AbUHNRlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 13:41:23 -0400
Date: Sat, 14 Aug 2004 19:52:33 +0200
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.6.8 and ingress scheduling
Message-ID: <20040814175233.GA3617@lazy.shacknet.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
From: lkml@lazy.shacknet.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

the last line (filter add) in the "wondershaper" script does sth. to the
kernel, that lets it panic on receiving network packets.

now, if I could capture the trace, that was great... nothing is on disk,
its also more than fits on the screen, and no scrollback exists.

please cc answers/questions,

regards,

peter



PS: excerpt from wondershaper script:

[...]
tc qdisc add dev $DEV handle ffff: ingress
# filter *everything* to it (0.0.0.0/0), drop everything that's
# coming in too fast:

tc filter add dev $DEV parent ffff: protocol ip prio 50 u32 match ip src \
   0.0.0.0/0 police rate ${DOWNLINK}kbit burst 10k drop flowid :1



PPS: likely relevant lines from .config

# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
# CONFIG_NET_SCH_CLK_JIFFIES is not set
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
CONFIG_NET_SCH_CLK_CPU=y
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=y
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=y
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
# CONFIG_CLS_U32_PERF is not set
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_CLS_RSVP=y
# CONFIG_NET_CLS_RSVP6 is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_CLS_POLICE=y
