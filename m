Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWIYVBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWIYVBg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWIYVBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:01:36 -0400
Received: from pas38-1-82-67-71-117.fbx.proxad.net ([82.67.71.117]:24493 "EHLO
	siegfried.gbfo.org") by vger.kernel.org with ESMTP id S1751198AbWIYVBf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:01:35 -0400
Date: Mon, 25 Sep 2006 23:01:52 +0200 (CEST)
From: Jean-Marc Saffroy <saffroy@gmail.com>
X-X-Sender: saffroy@erda.mds
To: Vivek Goyal <vgoyal@in.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       Dave Anderson <anderson@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: oops in :snd_pcm_oss:resample_expand+0x19c/0x1f0
In-Reply-To: <20060925153047.GA19794@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0609252034030.4825@erda.mds>
References: <Pine.LNX.4.64.0609241825280.4838@erda.mds>
 <20060924135417.c0c18b76.akpm@osdl.org> <Pine.LNX.4.64.0609242256540.4950@erda.mds>
 <20060925153047.GA19794@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

Thanks for all the good news on the future of kdump, it's nice to know 
that people are working on improving the user experience.

On Mon, 25 Sep 2006, Vivek Goyal wrote:

>>>> Oh and I wish I could use gdb on a kdump core. :-)
>
> Currently we can use gdb but only for linearly mapped region. You are 
> right its just a matter of re-generating the elf headers and remap the 
> vmalloc areas to enable module debugging in gdb. I can not do it after 
> the crash so probably the best place would be do it in user space. A 
> program can read /proc/vmcore and regenerate the headers for enabling 
> module debugging with gdb.

I assume that "after the crash" means "in the kernel crash handler", 
AFAICT the current dump from vmcore has all what's needed.

> Hmm.. Crash vs gdb is an interesting issue. I have not used gdb very 
> extensively on core dumps, but with my limited experiece, I found 
> "crash" to be more friendly.

One thing I like *very much* in gdb is its ability to display function 
params and local variables in any stack frame, and I haven't found out how 
to do it with crash.

> Crash has got so many in-built commands tailored for kernel debugging 
> and gdb lacks all those. Yes, we can write gdb scripts to implement 
> those, but last time Alaxender Nyberg wrote few gdb scripts to dump all 
> the threads and it was so slow.

I agree that gdb is sometimes very slow, but maybe it's easier to optimize 
gdb than to make crash smarter?

For this particular problem (listing threads), the real fix would be to 
add the PT_NOTE entry that each thread deserves, then gdb would let you do 
"info threads" instead, and dump nice backtraces of each.

> Look at Documentation/kdump/gdbmacros.txt

Hmmm, these need an update, they no longer work with 2.6.18. But I have an 
idea of how slow they can be, having tried a few things myself.

> So what's issue with crash? Is it just a matter of being more familiar 
> with gdb or gdb has got advantages over "crash" when it comes to kernel 
> debugging?

Oh I am certainly biased towards gdb :-) but function params and local 
vars are very useful when debugging.

Of course crash is still a very useful tool, and until we can really use 
gdb on kdumps (which requires some work), it will remain the best option 
we have. Heck, it even impressed Andrew Morton! ;-)


Cheers,

-- 
saffroy@gmail.com
