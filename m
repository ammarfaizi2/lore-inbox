Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWFHIN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWFHIN4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 04:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWFHINz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 04:13:55 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:29124 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751228AbWFHINy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 04:13:54 -0400
Message-ID: <349754431.09938@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 8 Jun 2006 16:13:52 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Voluspa <lista1@comhem.se>
Cc: akpm@osdl.org, arjan@infradead.org, Valdis.Kletnieks@vt.edu,
       diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] readahead: initial method - expected read size - fix fastcall
Message-ID: <20060608081352.GB5515@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <wfg@mail.ustc.edu.cn>,
	Voluspa <lista1@comhem.se>, akpm@osdl.org, arjan@infradead.org,
	Valdis.Kletnieks@vt.edu, diegocg@gmail.com,
	linux-kernel@vger.kernel.org
References: <349406446.10828@ustc.edu.cn> <20060604020738.31f43cb0.akpm@osdl.org> <1149413103.3109.90.camel@laptopd505.fenrus.org> <20060605031720.0017ae5e.lista1@comhem.se> <349562623.17723@ustc.edu.cn> <20060608094356.5c1272cc.lista1@comhem.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060608094356.5c1272cc.lista1@comhem.se>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's interesting that copying of sparse file is more efficient with small
readahead size :) I get the same conclusion, though with smaller differences:

SUMMARY
              user       sys       cpu         total
ARA, 1M       0.15       6.28      82.80       7.73
ARA, 128k     0.14       6.09      85.60       7.26
STOCK, 128k   0.15       6.05      85.60       7.22

TEST CASE

wfg ~% ll work/sparse
-rw-r--r-- 1 wfg wfg 1.6G 2006-05-21 15:11 work/sparse
wfg ~% free
             total       used       free     shared    buffers     cached
Mem:           501        496          5          0          5        191
-/+ buffers/cache:        300        201
Swap:          127          0        127

wfg ~% time cp work/sparse /dev/null

ARA, 1M
cp work/sparse /dev/null  0.15s user 6.35s system 80% cpu 8.125 total
cp work/sparse /dev/null  0.14s user 6.28s system 84% cpu 7.556 total
cp work/sparse /dev/null  0.14s user 6.25s system 82% cpu 7.744 total
cp work/sparse /dev/null  0.15s user 6.23s system 85% cpu 7.495 total
cp work/sparse /dev/null  0.16s user 6.30s system 83% cpu 7.719 total

ARA, 128k
cp work/sparse /dev/null  0.15s user 6.07s system 86% cpu 7.224 total
cp work/sparse /dev/null  0.15s user 6.05s system 84% cpu 7.334 total
cp work/sparse /dev/null  0.14s user 6.18s system 86% cpu 7.328 total
cp work/sparse /dev/null  0.13s user 6.11s system 86% cpu 7.217 total
cp work/sparse /dev/null  0.14s user 6.06s system 86% cpu 7.179 total

STOCK, 128k
cp work/sparse /dev/null  0.16s user 6.01s system 86% cpu 7.162 total
cp work/sparse /dev/null  0.14s user 6.10s system 86% cpu 7.222 total
cp work/sparse /dev/null  0.14s user 6.04s system 86% cpu 7.186 total
cp work/sparse /dev/null  0.15s user 6.02s system 85% cpu 7.210 total
cp work/sparse /dev/null  0.14s user 6.09s system 85% cpu 7.320 total

Wu
