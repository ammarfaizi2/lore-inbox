Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319854AbSINEdo>; Sat, 14 Sep 2002 00:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319855AbSINEdo>; Sat, 14 Sep 2002 00:33:44 -0400
Received: from packet.digeo.com ([12.110.80.53]:55024 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319854AbSINEdn>;
	Sat, 14 Sep 2002 00:33:43 -0400
Message-ID: <3D82C0F1.8733207D@digeo.com>
Date: Fri, 13 Sep 2002 21:54:09 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hirokazu Takahashi <taka@valinux.co.jp>, linux-kernel@vger.kernel.org,
       janetmor@us.ibm.com
Subject: Re: [patch] readv/writev rework
References: <3D80E139.ACC1719D@digeo.com> <20020913.101826.32726068.taka@valinux.co.jp> <3D815C04.A08CB5D9@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Sep 2002 04:38:30.0011 (UTC) FILETIME=[9315D4B0:01C25BA8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ...
> walk this linked list, writing the lines out.  The input was
> `cat linux/kernel/*.c > inputfile' and the output was written
> 1000 times (300 megs).  Benched four different ways of writing the
> output:
> 
>                     2.5.34         2.5.34-mm2         2.5.34-mm2-taka
> 
> write                 54s             54s                   55s
> fwrite                12.8s          12.8s                 12.7s
> fwrite_unlocked       11.6s          11.6s                 11.5s
> writev                39s            33.4s                 15.8s
> 
> So Janet's patch made a 15% improvement with this test.  Yours
> dropped it 50% again.
> 

I've retested with your latest patch.

                   2.5.34-mm4-taka2
write                  55.543
fwrite                 12.625
fwrite_unlocked        11.389
writev                  9.219

So that's another 70% speedup on top of yesterday's 100%, and kernel
beats glibc ;)
