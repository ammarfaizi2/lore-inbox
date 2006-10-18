Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWJRMwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWJRMwL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 08:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWJRMwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 08:52:10 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:39085 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1030220AbWJRMwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 08:52:09 -0400
Date: Wed, 18 Oct 2006 14:47:20 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
cc: Ralf Baechle <ralf@linux-mips.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Andrew Morton <akpm@osdl.org>,
       Erik Frederiksen <erik_frederiksen@pmc-sierra.com>,
       linux-kernel@vger.kernel.org
Subject: Re: IS_ERR Threshold Value
In-Reply-To: <20061016193140.GA6422@rhlx01.fht-esslingen.de>
Message-ID: <Pine.LNX.4.61.0610181442120.15009@yvahk01.tjqt.qr>
References: <1151528227.3904.1110.camel@girvin.pmc-sierra.bc.ca>
 <20060628140825.692f31be.rdunlap@xenotime.net> <20060629181013.GA18777@linux-mips.org>
 <20061016193140.GA6422@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Subject: Re: IS_ERR Threshold Value
>
>> > Peter Anvin mentioned just a few days ago that this threshold value
>> > should be 4095 for all arches.  I think we need to get that patch
>> > done & submitted to Andrew for -mm.
>> 
>> So here the patch is:
>> 
>>  o Raise the maximum error number in IS_ERR_VALUE to 4095.
>>
>> +#define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)

There seems to be a slight problem with doing that. Running
`ldd /bin/bash` prints out

	linux-gate.so.1 =>  (0xffffe000)

and the topmost address a kernel function can return is 0xFFFFf000 when 
MAX_ERRNO=4095, but that is going to be tight with the vdso mapped at 
0xffffE000.

Or is ldd giving wrong output? Because actually, `cat /proc/$$/maps` 
($$=bash) says it is mapped a lot less high:

a7fbe000-a7fbf000 r-xp a7fbe000 00:00 0          [vdso]

(CONFIG_COMPAT_VDSO=y, CONFIG_PAGE_OFFSET=0xB0000000, 2.6.18)

	-`J'
-- 
