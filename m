Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWEZM0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWEZM0O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 08:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWEZM0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 08:26:14 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:2834 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932482AbWEZM0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 08:26:13 -0400
Date: Fri, 26 May 2006 14:16:23 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>,
       Grant Coady <grant_lkml@dodo.com.au>,
       Jari Ruusu <jariruusu@users.sourceforge.net>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [ANNOUNCE] Linux-2.4.32-hf32.5
Message-ID: <20060526121623.GA14474@w.ods.org>
References: <20060507131034.GA19198@exosec.fr> <20060525133427.GA22727@w.ods.org> <k2nd725cl0vocvb72boalj06tpjlita644@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k2nd725cl0vocvb72boalj06tpjlita644@4ax.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grant,

On Fri, May 26, 2006 at 09:09:15PM +1000, Grant Coady wrote:
> On Thu, 25 May 2006 15:34:27 +0200, Willy TARREAU <willy@w.ods.org> wrote:
> 
> >Hi,
> >
> >here is the fifth hotfix for 2.4.32 and older kernels. There are 8 new
> >fixes, among which 1 security fix, 1 possible panic and one potential
> >memory leak, and 5 minor bugs :
> 
> Not my day...  Built kernel for 7 targets on 5 machines, each target 
> gave same kernel panic on reboot.  downloaded the patch again, it is 
> same as first download.  started over with new source tree, nada...

Could you please pass it through ksymoops so that we get an idea about the
function causing this ? What was the last version not causing it ? hf32.4 ?
If so, then the bug must be in one of the 8 patches. I've reread them but
nothing obvious gets noticed.

This looks like a structure member gets accessed while a pointer is NULL,
if you always get 0x88... I would be it could come from
2.4.32-ext3-link-unlink-race-1, but that would be strange.

Thanks in advance,
Willy


> copied by hand:
> 
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Unable to handle kernel NULL pointer dereference at virtual address 00000088 printing eip:
> c013ee43
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c013ee43>]    Not tainted
> EFLAGS: 00010246
> eax: 00000088   ebx: c19bb5c0   ecx: 00000088   edx: f7bf0005
> esi: f7e3c508   edi: c19bb5c0   ebp: f7e3c480   esp: f7e6bf18
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 1, stackpage=f7e6b000)
> Stack: c19bb5c0 00000000 c19bb5c0 f7bf0000 f7e6bf3c c19bb5c0 c013f056 f7e3c480
>        c19bb5c0 c19bb440 c19ac140 f7bf0005 00000004 01c0d8cc 00000010 00000000
>        c013e727 00000803 c02a18f6 c0105000 0008e000 c0302bfb c02a18f6 f7bf0000
> Call Trace:    [<c013f056>] [<c013e727>] [<c0105000>] [<c013e890>] [<c01051f3>]
>   [<c0105085>] [<c010568b>] [<c0105070>]
> 
> Code: ff 08 0f 88 8f 16 00 00 8b 5f 08 85 db 74 0c 8b 47 0c 39 68
>  <0>Kernel panic: Attempted to kill init!
> 
> 
> I'd like to seriously damage the person who invented [<...>] 
> display format after typing that lot in ;)
> 
> This is from sempro: <http://bugsplatter.mine.nu/test/linux-2.4/sempro/>
> make oldconfig from working -hf32.4 (the config-* files on my site 
> are filtered with 'grep = config...')
> 
> Three build attempts on the fastest host, last build was with fresh 
> 2.4.32 tree + patch :(  Fails cold (power cycle) + warm boot...
> 
> No, I'm not going to type in from other boxen.  Same failure, different 
> last 4 digits of the eip: value (c013????)  Virtual addr 00000088 on all 
> I checked.
> 
> Grant.
