Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268894AbUHZMn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268894AbUHZMn0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268882AbUHZMje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:39:34 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:59821
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S268937AbUHZMeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 08:34:14 -0400
Message-ID: <412DD8BC.2070808@bio.ifi.lmu.de>
Date: Thu, 26 Aug 2004 14:34:04 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Con Kolivas <kernel@kolivas.org>, Diego Calleja <diegocg@teleline.es>,
       John McGowan <jmcgowan@inch.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.8.1: memory leak? cdrecord problem?
References: <20040821172646.GA8781@localhost.localdomain> <20040821194457.38920e99.diegocg@teleline.es> <41281496.8080800@kolivas.org> <412DD033.6000903@bio.ifi.lmu.de>
In-Reply-To: <412DD033.6000903@bio.ifi.lmu.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Steiner wrote:

> Unfortunately the host always crashes before it writes the messages
> to the log files, but I saw some messages about "cpu0..." and DMA.

Now I got it to do an emergency sync :-)

Aug 26 14:13:42 wirth kernel: oom-killer: gfp_mask=0xd0
Aug 26 14:13:42 wirth kernel: DMA per-cpu:
Aug 26 14:13:42 wirth kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 26 14:13:42 wirth kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 26 14:13:42 wirth kernel: Normal per-cpu:
Aug 26 14:13:42 wirth kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 26 14:13:42 wirth kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 26 14:13:42 wirth kernel: HighMem per-cpu:
Aug 26 14:13:42 wirth kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 26 14:13:42 wirth kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 26 14:13:42 wirth kernel:
Aug 26 14:13:42 wirth kernel: Free pages:      107700kB (105792kB HighMem)
Aug 26 14:13:42 wirth kernel: Active:13356 inactive:253643 dirty:0 writeback:0 unstable:0 free:26925 slab:2333 mapped:12041 pagetables:151
Aug 26 14:13:42 wirth kernel: DMA free:44kB min:16kB low:32kB high:48kB active:4kB inactive:0kB present:16384kB
Aug 26 14:13:42 wirth kernel: protections[]: 8 476 732
Aug 26 14:13:42 wirth kernel: Normal free:1864kB min:936kB low:1872kB high:2808kB active:1236kB inactive:1060kB present:901120kB
Aug 26 14:13:42 wirth kernel: protections[]: 0 468 724
Aug 26 14:13:42 wirth kernel: HighMem free:105792kB min:512kB low:1024kB high:1536kB active:52184kB inactive:1013512kB present:1179632kB
Aug 26 14:13:42 wirth kernel: protections[]: 0 0 256
Aug 26 14:13:42 wirth kernel: DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 44kB
Aug 26 14:13:42 wirth kernel: Normal: 0*4kB 1*8kB 0*16kB 0*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1864kB
Aug 26 14:13:42 wirth kernel: HighMem: 222*4kB 417*8kB 216*16kB 96*32kB 121*64kB 42*128kB 8*256kB 6*512kB 1*1024kB 1*2048kB 18*4096kB = 105792kB
Aug 26 14:13:42 wirth kernel: Swap cache: add 0, delete 0, find 0/0, race 0+0
Aug 26 14:13:42 wirth kdm[6478]: Greeter exited unexpectedly
Aug 26 14:13:42 wirth kernel: Out of Memory: Killed process 6906 (kdm_greet).
...
(continues to kill processes)

If hope that helps...

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

