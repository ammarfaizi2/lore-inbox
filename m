Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316617AbSEWNKi>; Thu, 23 May 2002 09:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316631AbSEWNKh>; Thu, 23 May 2002 09:10:37 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:38142 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S316617AbSEWNKh>; Thu, 23 May 2002 09:10:37 -0400
Date: Thu, 23 May 2002 09:10:23 -0400
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: tiobench
Message-ID: <20020523091023.A555@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> tiobench sequential read throughput is enormously sensitive to the
> readahead setting.  With the readahead at the default 128k
> with
>
>         blockdev --setra 512 /dev/hda
>
> gives very nice throughput.  But somehow 2.4.x seems to cheat
> and seems to do twice the readahead than the setting says, or something.

Bigger readahead helps dbench too.

Readahead in 2.5.x and dbench and tiobench sequential read 
average throughput on my uniproc ide box was roughly:

kernel          readahead        dbench         tiobench
2.5.0 - 2.5.7       8            8.1 mb/s       9.9 mb/s
2.5.8 - 2.5.10      0            3.5 mb/s       9.9 mb/s
2.5.11 - 2.5.17   256           13   mb/s      10.2 mb/s
2.5.8-akpm       1024           22   mb/s      18.1 mb/s

Bigger readahead appears to lower tiobench sequential read 
latency a little.

2.4.x showed readahead = 8 for 2.4.3 - 2.4.19-pre8, including
aa, ac, jam, mjc, and rmap.

-- 
Randy Hron

