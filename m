Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbUB0UE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 15:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbUB0UE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:04:57 -0500
Received: from pop-4.dnv.wideopenwest.com ([64.233.207.9]:52700 "EHLO
	pop-4.dnv.wideopenwest.com") by vger.kernel.org with ESMTP
	id S262940AbUB0UEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:04:54 -0500
Date: Fri, 27 Feb 2004 15:04:59 -0500
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: harddisk speed: 2.4.24 20+% faster then 2.6.3
Message-ID: <20040227200459.GO3925@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org
References: <c1m1id$u31$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1m1id$u31$1@news.cistron.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny ter Haar <dth@ncc1701.cistron.net>, on Fri Feb 27, 2004 [12:04:29 AM] said:
> I've been checking, rechecking but cannot explain
> why a "vannilla" debian install kernel (sid-testing install
> cdrom) is faster then "Feisty Dunnart" on the same hardware.
> 
> hardware: Mini-itx with 1Ghz via-C3
> 200GB udma harddisk.
> 
> 2.4.24:  
>  Timing buffered disk reads:  150 MB in  3.01 seconds =  49.83 MB/sec
> 
> 2.6.3 (vanilla):
>  Timing buffered disk reads:  102 MB in  3.05 seconds =  33.40 MB/sec
> 
> 2.6.3-mm4:
>  Timing buffered disk reads:  108 MB in  3.00 seconds =  35.95 MB/sec
> 

	Hi;

	
	By default, my hdparm numbers and my kernel build time
benchmark were worse on all 2.6 vs. 2.4 kernels, until I tried:

/sbin/hdparm -a 4096 /dev/hdx

eg. (typical averages)
2.4.21:
Timing buffered disk reads:   80 MB in  3.07 seconds =  26.06 MB/sec
2.6.0-test5:
Timing buffered disk reads:   68 MB in  3.06 seconds =  22.21 MB/sec
2.6.1: [readahead 4096]
Timing buffered disk reads:   90 MB in  3.02 seconds =  29.82 MB/sec

2.6.0-test10 building 2.4.18-packet (personal config) gcc3.2.3 glibc2.3.2
160g Maxtor, ext3
(2xpII 400)
time (make -j4 clean && make -j4 dep && make -j4 bzImage)
[with default read-ahead]
real    9m1.496s
user    16m1.977s
sys     0m45.347s

[read-ahead = 4096]
real    7m2.923s
user    12m6.889s
sys     0m46.190s

	pIIx4, ata33, 160g maxtor

Paul
set@pobox.com
