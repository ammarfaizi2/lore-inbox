Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbULGKXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbULGKXR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 05:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbULGKXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 05:23:17 -0500
Received: from quickstop.soohrt.org ([81.2.155.147]:45001 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S261780AbULGKVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 05:21:36 -0500
Date: Tue, 7 Dec 2004 11:21:32 +0100
From: Karsten Desler <kdesler@soohrt.org>
To: Karsten Desler <kdesler@soohrt.org>
Cc: jamal <hadi@cyberus.ca>, Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       "David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
Message-ID: <20041207102132.GA28588@quickstop.soohrt.org>
References: <20041206224107.GA8529@soohrt.org> <E1CbSf8-00047p-00@calista.eckenfels.6bone.ka-ip.net> <20041207002012.GB30674@quickstop.soohrt.org> <1102387595.1088.48.camel@jzny.localdomain> <20041207025456.GA525@soohrt.org> <1102389533.1089.51.camel@jzny.localdomain> <20041207032438.GA7767@soohrt.org> <1102390241.1093.59.camel@jzny.localdomain> <20041207040235.GA10501@soohrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207040235.GA10501@soohrt.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten Desler <kdesler@soohrt.org> wrote:
> * jamal wrote:
> > Beats me. Make sure it boots NAPI. Also if you can turn off ITR; intel
> > loves to turn on that silly feature.
> 
> ITR was in fact activated. I think i've disabled it now
> (e1000.InterruptThrottleRate=0 in the kernel cmdline).
> And as I'm reading the e1000 code, there is no way to enable/disable
> NAPI without a recompile. So the fact that ethtool spat out -NAPI in
> the version string means that NAPI is actually used.

But looking and the int/s number, I'm not so sure anymore. Is there any
other way to find out?

# ethtool -i eth0|grep ^vers
version: 5.5.4-k2-NAPI
# ethtool -i eth1|grep ^vers
version: 5.5.4-k2-NAPI

           CPU0       CPU1
169:          5  115554253   IO-APIC-level  eth0
177:   78998347       5568   IO-APIC-level  eth1

# sar -I 169 5 5
11:20:05         INTR    intr/s
11:20:10          169  10401.40
11:20:15          169  10579.80
11:20:20          169  10965.20
11:20:25          169  10768.20
11:20:30          169  10460.60
Average:          169  10635.04

# sar -I 177 5 5
11:18:50         INTR    intr/s
11:18:55          177   4769.74
11:19:00          177   4780.80
11:19:05          177   4669.74
11:19:10          177   4724.55
11:19:15          177   4748.50
Average:          177   4738.67

Cheers,
 Karsten
