Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWDXDy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWDXDy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 23:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWDXDy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 23:54:26 -0400
Received: from nproxy.gmail.com ([64.233.182.185]:469 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751505AbWDXDy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 23:54:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Xlr7LrBZbdA0Ac3GcQ+1Avn5hLmDe5DaCRv0OmFJ1HIsVC/Lkwj+Rm5FpJB61Yls8V11sRSHymlsYauUHQzIPzbl8XZO5tUi8oPWTMYquFVZwyqKtQsljGv3qOUEh05OTQ3TcZWwcoYVgAxI+Te3aeo/jYZAgzHEv2shuX6XDdE=
Date: Mon, 24 Apr 2006 07:51:44 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, perex@suse.cz,
       alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] Re: ALSA regression: oops on shutdown
Message-ID: <20060424035144.GA7750@mipter.zuzino.mipt.ru>
References: <20060423235730.GA7934@mipter.zuzino.mipt.ru> <20060423185721.39ff4207.akpm@osdl.org> <b6fcc0a0604231937h6f2754f9k68ec76dc19c7ddb9@mail.gmail.com> <1145846360.31507.50.camel@mindpipe> <20060424031142.GA7735@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424031142.GA7735@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 07:11:42AM +0400, Alexey Dobriyan wrote:
> On Sun, Apr 23, 2006 at 10:39:19PM -0400, Lee Revell wrote:
>
> Andrew asked about precise steps of reproduction:
>
> 	rmmod snd_pcm_oss
>
> which is part of Gentoo install scripts (/etc/init.d/alsasound:134-140, to
> be precise) (basically lsmod | grep snd | xargs rmmod).
>
> BUG: unable to handle kernel paging request at virtual address 6b6b6b6b
>  printing eip:
> c016c6a4
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in: snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd uhci_hcd usbcore
> CPU:    0
> EIP:    0060:[<c016c6a4>]    Not tainted VLI
> EFLAGS: 00010286   (2.6.17-rc2-6b426e785cb81e53dc2fc4dcf997661472b470ef #1)
> EIP is at remove_proc_entry+0x2c/0x11c
> eax: 00000000   ebx: deb48b80   ecx: ffffffff   edx: de11ed24
> esi: de11ed24   edi: 6b6b6b6b   ebp: de4cb000   esp: de4cbf28
> ds: 007b   es: 007b   ss: 0068
> Process rmmod (pid: 7735, threadinfo=de4cb000 task=c1487a90)
> Stack: <0>de11ed24 6b6b6b6b deb48b80 de11ed24 bf8590cc df93603b de4f0e78 00000000
>        df965fc8 de4f0d84 df967e74 df966184 de4f0d88 df95292d df967f00 00000000
>        c0125f7a 00000000 5f646e73 5f6d6370 0073736f de85d4a4 b7f27000 c013789d
> Call Trace:
>  [<df93603b>] snd_info_unregister+0x2e/0x44 [snd]
>  [<df965fc8>] snd_pcm_oss_proc_done+0x19/0x30 [snd_pcm_oss]
>  [<df966184>] snd_pcm_oss_unregister_minor+0x3b/0x3f [snd_pcm_oss]
>  [<df95292d>] snd_pcm_notify+0x4a/0x91 [snd_pcm]
>  [<c0125f7a>] sys_delete_module+0x113/0x138
>  [<c013789d>] do_munmap+0xe2/0xef
>  [<c010259b>] syscall_call+0x7/0xb
> Code: 85 d2 56 53 51 51 89 14 24 89 44 24 04 75 13 8d 4c 24 04 89 e2 e8 dd f7 ff ff 85 c0 0f 85 f2 00 00 00 8b 7c 24 04 31 c0 83 c9 ff <f2> ae f7 d1 49 b0 01 89 ce e8 fa 13 fa ff 8b 04 24 8d 58 38 83
> EIP: [<c016c6a4>] remove_proc_entry+0x2c/0x11c SS:ESP 0068:de4cbf28
>  BUG: rmmod/7735, lock held at task exit time!
>  [df960920] {register_mutex}
> .. held by:             rmmod: 7735 [c1487a90, 118]
> ... acquired at:               snd_pcm_notify+0x10/0x91 [snd_pcm]

Other symptoms are 6 (six) "prealloc" files, 3 "oss" files and 1 "oss"
directory (according to highlighting):

$ ls /proc/asound/
card0  devices  modules  oss  oss  prealloc  prealloc  prealloc  timers
			      ^^^
			      directory

cards  ICH5     oss      oss  pcm  prealloc  prealloc  prealloc  version

"ls -l" thinks all 4 "oss" files are files (again, according to
highlighting).

