Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbTFQK6q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 06:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbTFQK6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 06:58:46 -0400
Received: from grouse.mail.pas.earthlink.net ([207.217.120.116]:58872 "EHLO
	grouse.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264647AbTFQK6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 06:58:43 -0400
Date: Tue, 17 Jun 2003 07:14:00 -0400
To: piggin@cyberone.com.au, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: i/o benchmarks on 2.5.70* kernels
Message-ID: <20030617111400.GA11839@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> tiobench on SMP results are not very good, lots of
> fragmentation, the random IO throughput drops is
> probably due to AS strangling TCQ though. You are
> using SMP and TCQ, right?

SMP yes.  The non-benchmarked disks (which don't matter
say this at boot time:

scsi0:A:1:0: Tagged Queuing enabled.  Depth 4
(aic7xxx)

These config options on the non-benchmarked disks:
CONFIG_AIC7XXX_CMDS_PER_DEVICE=4
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y

----

The benchmarked disks are on scsi3 and scsi4.
The benchmarked disks do not tell what TCQ they have.

CONFIG_SCSI_QLOGIC_ISP=y
CONFIG_SCSI_QLOGIC_FC=y
CONFIG_SCSI_QLOGIC_FC_FIRMWARE=y

TCQ on the benchmarked disks may be 1024...
+#define        MAXISPREQUEST(isp)      ((IS_FC(isp) || IS_ULTRA2(isp))? 1024 : 256)

but that's just a guess.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

