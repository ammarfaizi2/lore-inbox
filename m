Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbTILCq7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 22:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbTILCq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 22:46:59 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:9389 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261483AbTILCq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 22:46:57 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Stephan von Krawczynski <skraw@ithnet.com>
Date: Fri, 12 Sep 2003 12:46:46 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16225.13206.910616.386713@notabene.cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
In-Reply-To: message from Stephan von Krawczynski on Tuesday September 9
References: <20030909110112.4d634896.skraw@ithnet.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday September 9, skraw@ithnet.com wrote:
> Hello,
> 
> lately I upgraded my testbox from 2 to 6 GB ram and found out some oddities I
> would like to hear your opinions.
> The box ran flawlessly and performant with 2 GB - was in fact a real joy.
> After upgrading the ram and recompiling kernel 2.4.22 with support for 64 GB I
> noticed:
> 
> 1) nfs clients see timeouts again, like
> 
> Sep  9 03:37:35 clienta kernel: nfs: server 192.168.1.1 not responding, still
> trying
> Sep  9 03:37:35 clienta kernel: nfs: server 192.168.1.1 OK
> Sep  9 03:37:35 clienta kernel: nfs: server 192.168.1.1 not responding, still
> trying
> Sep  9 03:37:35 clienta kernel: nfs: server 192.168.1.1 OK
> Sep  9 03:41:13 clienta kernel: nfs: server 192.168.1.1 not responding, still
> trying
> Sep  9 03:41:13 clienta kernel: nfs: server 192.168.1.1 OK
> 
> Both are 2.4.22. 192.168.1.1 is the testbox. I saw those with 2GB, but could
> fix it through more nfs-daemons and
> 
>         echo 2097152 >/proc/sys/net/core/rmem_max
>         echo 2097152 >/proc/sys/net/core/wmem_max
> 
> Are these values too small for 6 GB?

No.  The values are proportional to the number of server threads, not
the amount of RAM... and they should be un-necessary after 2.4.20
anyway as nfsd in the kernel makes the appropriate settings.


> 
> 2) Box is very slow, kswapd looks very active during tar of a local harddisk.
> Interactivity is really bad. Seems vm has a high time looking for free or
> usable pages. Compared to 2 GB the behaviour is unbelievably bad.
> 
> 3) Network performance has a remarkable dropdown during above tar. In fact
> doing simple pings every few minutes shows that quite a lot of them are simply
> dropped, never make it over the ethernet.

My only guess is that it is doing a lot of copying into low memory
because your devices can only DMA into/outof low memory.
Have you tried 2.6 ??
How about CONFIG_HIGHMEM4G ?
It won't use all the RAM, but it would be interesting if it were
faster.

NeilBrown
