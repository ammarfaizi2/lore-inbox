Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVGLQlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVGLQlf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVGLQjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:39:00 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:17998 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261589AbVGLQhU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:37:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lPq8OHmvBTdaD7SsQ/N/R3zVSmg1aBe1AJra365RcuWcd/V/u4ESSDaNsqwASb4fHlGlgMr+QOtfTzf3WiNDt/2FcqqGVdcfhxsPwtpPvGbfSrr2F9EU+Q4C0Z/uwLXPnts8d/8flIhDTiYy43pF9+mrEMURDHL7edYuhB/zRjs=
Message-ID: <4ad99e0505071209372176f625@mail.gmail.com>
Date: Tue, 12 Jul 2005 18:37:16 +0200
From: Lars Roland <lroland@gmail.com>
Reply-To: Lars Roland <lroland@gmail.com>
To: Bron Gondwana <brong@fastmail.fm>
Subject: Re: 2.6.12.2 dies after 24 hours
Cc: Rob Mueller <robm@fastmail.fm>, linux-kernel@vger.kernel.org,
       Jeremy Howard <jhoward@fastmail.fm>
In-Reply-To: <1121176268.15213.238283120@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <01dd01c586c3$cdd525d0$7c00a8c0@ROBMHP>
	 <4ad99e05050712024319bc7ada@mail.gmail.com>
	 <021801c586d7$5ebf4090$7c00a8c0@ROBMHP>
	 <4ad99e05050712051341cf6e3@mail.gmail.com>
	 <1121176268.15213.238283120@webmail.messagingengine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/05, Bron Gondwana <brong@fastmail.fm> wrote:
> We're also applying the attached patch.  There's a bug in reiserfs that
> gets tickled by our huge MMAP usage (it's amazing what really busy
> Cyrus daemons can do to a server, ouch).  It's fixed in generic_write,
> so we take the few percent performance hit for something that doesn't
> break!

Interesting - When I got the problem it was on mail servers under high
load (handling 60.000 emails pr. hour) with reiserfs as file system. I
have seen this problem on 5 different servers so I am confident that
it is not hardware failure.

Sometimes the server load just rises and then the server dies other
times the load rises but the kernel manages to get it back alive
filling up syslog with messages like this


---------
June 29 14:06:59 dkcphmx12 kernel: oom-killer: gfp_mask=0xd2
June 29 14:07:15 dkcphmx12 kernel: DMA per-cpu:
June 29 14:07:24 dkcphmx12 kernel: cpu 0 hot: low 2, high 6, batch 1
June 29 14:07:24 dkcphmx12 kernel: cpu 0 cold: low 0, high 2, batch 1
June 29 14:07:26 dkcphmx12 logger[17427]: *** SYSTEM UPDATE STARTED ***
June 29 14:07:26 dkcphmx12 kernel: cpu 1 hot: low 2, high 6, batch 1
June 29 14:07:26 dkcphmx12 kernel: cpu 1 cold: low 0, high 2, batch 1
June 29 14:07:26 dkcphmx12 kernel: cpu 2 hot: low 2, high 6, batch 1
June 29 14:07:26 dkcphmx12 kernel: cpu 2 cold: low 0, high 2, batch 1
June 29 14:07:26 dkcphmx12 kernel: cpu 3 hot: low 2, high 6, batch 1
June 29 14:07:26 dkcphmx12 kernel: cpu 3 cold: low 0, high 2, batch 1
June 29 14:07:26 dkcphmx12 kernel: Normal per-cpu:
June 29 14:07:26 dkcphmx12 kernel: cpu 0 hot: low 62, high 186, batch 31
June 29 14:07:26 dkcphmx12 kernel: cpu 0 cold: low 0, high 62, batch 31
June 29 14:07:26 dkcphmx12 kernel: cpu 1 hot: low 62, high 186, batch 31
June 29 14:07:26 dkcphmx12 kernel: cpu 1 cold: low 0, high 62, batch 31
June 29 14:07:26 dkcphmx12 kernel: cpu 2 hot: low 62, high 186, batch 31
June 29 14:07:26 dkcphmx12 kernel: cpu 2 cold: low 0, high 62, batch 31
June 29 14:07:26 dkcphmx12 kernel: cpu 3 hot: low 62, high 186, batch 31
June 29 14:07:26 dkcphmx12 kernel: cpu 3 cold: low 0, high 62, batch 31
June 29 14:07:26 dkcphmx12 kernel: HighMem per-cpu:
June 29 14:07:26 dkcphmx12 kernel: cpu 0 hot: low 62, high 186, batch 31
June 29 14:07:26 dkcphmx12 kernel: cpu 0 cold: low 0, high 62, batch 31
June 29 14:07:26 dkcphmx12 kernel: cpu 1 hot: low 62, high 186, batch 31
June 29 14:07:26 dkcphmx12 kernel: cpu 1 cold: low 0, high 62, batch 31
June 29 14:07:26 dkcphmx12 kernel: cpu 2 hot: low 62, high 186, batch 31
June 29 14:07:26 dkcphmx12 kernel: cpu 2 cold: low 0, high 62, batch 31
June 29 14:07:26 dkcphmx12 kernel: cpu 3 hot: low 62, high 186, batch 31
June 29 14:07:26 dkcphmx12 kernel: cpu 3 cold: low 0, high 62, batch 31
June 29 14:07:26 dkcphmx12 kernel:
June 29 14:07:26 dkcphmx12 kernel: Free pages:       49196kB (496kB HighMem)
June 29 14:07:26 dkcphmx12 kernel: Active:246580 inactive:244789
dirty:0 writeback:0 unstable:0 free:12299 slab:4271 mapped:494975
pagetables:2332

June 29 14:07:26 dkcphmx12 kernel: DMA free:8192kB min:68kB low:84kB
high:100kB active:2644kB inactive:2108kB present:16384kB
pages_scanned:35654 all_unreclaimable? yes

June 29 14:07:26 dkcphmx12 kernel: lowmem_reserve[]: 0 880 2031
June 29 14:07:26 dkcphmx12 kernel: Normal free:40508kB min:3756kB
low:4692kB high:5632kB active:400096kB inactive:396232kB
present:901120kB pages_scanned:1933718 all_unreclaimable? yes

June 29 14:07:26 dkcphmx12 kernel: lowmem_reserve[]: 0 0 9214
June 29 14:07:26 dkcphmx12 kernel: HighMem free:496kB min:512kB
low:640kB high:768kB active:583452kB inactive:580816kB
present:1179504kB pages_scanned:8651915 all_unreclaimable? yes

June 29 14:07:26 dkcphmx12 kernel: lowmem_reserve[]: 0 0 0
June 29 14:07:26 dkcphmx12 kernel: DMA: 0*4kB 2*8kB 1*16kB 1*32kB
1*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 1*4096kB = 8192kB

June 29 14:07:26 dkcphmx12 kernel: Normal: 251*4kB 38*8kB 6*16kB
0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 1*2048kB 9*4096kB =
40508kB

June 29 14:07:26 dkcphmx12 kernel: HighMem: 0*4kB 0*8kB 1*16kB 1*32kB
1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 496kB

June 29 14:07:26 dkcphmx12 kernel: Swap cache: add 958067, delete
958073, find 182890/223964, race 0+1251
June 29 14:07:26 dkcphmx12 kernel: Free swap  = 0kB
June 29 14:07:26 dkcphmx12 kernel: Total swap = 2097136kB
