Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267512AbSIRQhq>; Wed, 18 Sep 2002 12:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267312AbSIRQgl>; Wed, 18 Sep 2002 12:36:41 -0400
Received: from packet.digeo.com ([12.110.80.53]:44014 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267311AbSIRQgb>;
	Wed, 18 Sep 2002 12:36:31 -0400
Message-ID: <3D88ACB6.6374E014@digeo.com>
Date: Wed, 18 Sep 2002 09:41:26 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Re: [BENCHMARK] contest results for 2.5.36
References: <1032360386.3d8891c2bc3d3@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Sep 2002 16:41:26.0596 (UTC) FILETIME=[3B327040:01C25F32]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> Here are the latest results with 2.5.36 compared with 2.5.34
> 
> No Load:
> Kernel                  Time            CPU
> 2.4.19                  68.14           99%
> 2.4.20-pre7             68.11           99%
> 2.5.34                  69.88           99%
> 2.4.19-ck7              68.40           98%
> 2.4.19-ck7-rmap         68.73           99%
> 2.4.19-cc               68.37           99%
> 2.5.36                  69.58           99%

page_add/remove_rmap.  Be interesting to test an Alan kernel too.

> Process Load:
> Kernel                  Time            CPU
> 2.4.19                  81.10           80%
> 2.4.20-pre7             81.92           80%
> 2.5.34                  71.39           94%
> 2.5.36                  71.80           94%

Ingo ;)
 
> Mem Load:
> Kernel                  Time            CPU
> 2.4.19                  92.49           77%
> 2.4.20-pre7             92.25           77%
> 2.5.34                  138.05          54%
> 2.5.36                  132.45          56%

The swapping fix in -mm1 may help here.
 
> IO Halfmem Load:
> Kernel                  Time            CPU
> 2.4.19                  99.41           70%
> 2.4.20-pre7             99.42           71%
> 2.5.34                  74.31           93%
> 2.5.36                  94.82           76%

Don't know.  Was this with IO load against the same disk as
the one on which the kernel was being compiled, or a different
one?  This is a very important factor - one way we're testing the
VM and the other way we're testing the IO scheduler.
 
> IO Fullmem Load:
> Kernel                  Time            CPU
> 2.4.19                  173.00          41%
> 2.4.20-pre7             146.38          48%
> 2.5.34                  74.00           94%
> 2.5.36                  87.57           81%

If the IO load was against the same disk 2.5 _should_ have sucked,
due to the writes-starves-reads problem which we're working on.  So
I assume it was against a different disk.  In which case 2.5 should not
have shown these improvements, because all the fixes for this are still
in -mm.  hm.  Helpful, aren't I?
