Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161415AbWBUHJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161415AbWBUHJH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 02:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161417AbWBUHJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 02:09:07 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:154 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161415AbWBUHJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 02:09:06 -0500
Date: Tue, 21 Feb 2006 02:03:38 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Kernel panic when compiling with SMP support
To: Chris Largret <largret@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602210207_MC3-1-B8DE-2105@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1140437271.7849.21.camel@shogun.daga.dyndns.org>

On Mon, 20 Feb 2006 at 04:07:51 -0800, Chris Largret wrote:

> In short, I only get these kernel panics when I enable SMP.
> ...
> invalid opcode: 0000 [1] SMP
> RIP: 0010:[<ffffffff8100efa8>] <ffffffff8100efa8>{timer_interrupt+0}
> ...
> Code: 83 3d 7d d6 38 00 01 55 48 89 d7 48 89 e5 7f 13 e8 50 fc ff
> --------------------------------------------------------------------
> Unable to handle kernel NULL pointer dereference at 0000000000000001
> RIP:
> <ffffffff8100cfa8>{timer_interrupt+0}
> ...
> Code: 83 3d 7d d6 38 00 01 55 48 89 d7 48 89 e5 7f 13 e8 50 fc ff

Maybe your CPU is overheating or it's not getting enough current.

Both oopses happen at the same exact address and they are complete
nonsense.  For #1, the instruction is valid (it's
cmpl $1,0x38d67d(%rip)) and for #2 it's the same instruction, which
can't be referencing address 1.

You can try slowing down your CPUs by doing:

# echo -n "powersave" >/sys/devices/system/cpu/cpuN/cpufreq/scaling_governor

for each cpu (assuming you have a driver loaded, and you should.)

And please post your complete .config

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

