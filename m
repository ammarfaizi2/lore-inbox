Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271955AbRH2Mc5>; Wed, 29 Aug 2001 08:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271957AbRH2Mcr>; Wed, 29 Aug 2001 08:32:47 -0400
Received: from ns.ithnet.com ([217.64.64.10]:1284 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271955AbRH2Mcj>;
	Wed, 29 Aug 2001 08:32:39 -0400
Date: Wed, 29 Aug 2001 14:26:39 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Gergely Madarasz <gorgo@thunderchild.debian.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: vm problems
Message-Id: <20010829142639.27385bcf.skraw@ithnet.com>
In-Reply-To: <20010829131419.Z6202@thunderchild.ikk.sztaki.hu>
In-Reply-To: <20010829131419.Z6202@thunderchild.ikk.sztaki.hu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2001 13:14:19 +0200
Gergely Madarasz <gorgo@thunderchild.debian.net> wrote:

> Hello,
> 
> I get hundreds of this error message:
> 
> __alloc_pages: 0-order allocation failed.
> 
> The machine is an IBM x250 with 4G ram, the kernel is vanilla 2.4.9 and
> 2.4.9-ac3, no swap, running bonnie++. When the memory fills up with cache,
> I start receiving the error message. 
> 
>              total       used       free     shared    buffers     cached
> Mem:       3863628    3854532       9096          0       5160    3734832
> -/+ buffers/cache:     114540    3749088
> Swap:            0          0          0

Unfortunately I found out this is "normal" behaviour, not only under 2.4.9 but also 2.4.8 and 2.4.7. You could use just about any test that does filesystem load with more data moved than you have physical mem. It basically means that you can easily break the vm management by forcing it in a state where "cleanup" has to be done to find free pages (e.g. page_launder). If you have enough spare time you can try to make page_launder run not only through 1/64 of the list but all through and find out in the end, that it cannot find free pages not matter how often it is run. This looks like a self-produced deadlock situation. On the one hand the basic strategy seems to use as much resources (mem) as possible to gain speed, on the other hand there is no way out, if resources get very low, and this basic strategy fails (which you can see because performance drops down below the cellar).
Try 2.4.10-pre2, possibly you find out, that it doesn't fail that often, but performance stays low.

Regards, Stephan


