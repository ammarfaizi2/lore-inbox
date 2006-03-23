Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWCWNG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWCWNG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 08:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWCWNG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 08:06:59 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:8400 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751144AbWCWNG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 08:06:58 -0500
Date: Thu, 23 Mar 2006 21:14:39 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Con Kolivas <kernel@kolivas.org>,
       linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>
Subject: Re: [ck] 2.6.16-ck1
Message-ID: <20060323131439.GA4700@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Con Kolivas <kernel@kolivas.org>,
	linux list <linux-kernel@vger.kernel.org>,
	ck list <ck@vds.kolivas.org>
References: <200603202145.31464.kernel@kolivas.org> <20060323113118.GA9329@spherenet.spherevision.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323113118.GA9329@spherenet.spherevision.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodney,

Thanks for your testing :)

On Thu, Mar 23, 2006 at 05:31:18AM -0600, Rodney Gordon II wrote:
> Adaptive readahead: I had probs with this before, and I still do.. On
> a desktop if you have odd problems (nothing responding for SECONDS,
> very slow disk I/O during heavy I/O, etc..) disable it.

Your problem on I/O latency with ara can be tracked down with the help
of Ingo's latency tracing patch. It goes like this:

1) download
http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.16.tar.bz2
http://www.vanheusden.com/ara/adaptive-readahead-11-2.6.16-rc6.patch.gz
http://people.redhat.com/mingo/latency-tracing-patches/latency-tracing-v2.6.16.patch

2)
tar jxf linux-2.6.16.tar.bz2
gunzip adaptive-readahead-11-2.6.16-rc6.patch.gz
cd linux-2.6.16
patch -p1 < ../adaptive-readahead-11-2.6.16-rc6.patch
patch -p1 < ../latency-tracing-v2.6.16.patch

3) compile kernel with Adaptive readahead support
4) boot with the new kernel, and run
echo 0 > /proc/sys/kernel/preempt_max_latency
5) feel some latency problems
6) report the content of /proc/latency_trace

Thanks,
Wu
