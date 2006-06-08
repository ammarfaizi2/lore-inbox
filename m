Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWFHMjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWFHMjB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 08:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWFHMjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 08:39:01 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:5529 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S964779AbWFHMjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 08:39:00 -0400
Message-ID: <349770337.30464@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 8 Jun 2006 20:39:00 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Voluspa <lista1@comhem.se>
Cc: akpm@osdl.org, Valdis.Kletnieks@vt.edu, diegocg@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: adaptive readahead overheads
Message-ID: <20060608123900.GA6885@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <wfg@mail.ustc.edu.cn>,
	Voluspa <lista1@comhem.se>, akpm@osdl.org, Valdis.Kletnieks@vt.edu,
	diegocg@gmail.com, linux-kernel@vger.kernel.org
References: <349406446.10828@ustc.edu.cn> <20060604020738.31f43cb0.akpm@osdl.org> <1149413103.3109.90.camel@laptopd505.fenrus.org> <20060605031720.0017ae5e.lista1@comhem.se> <349562623.17723@ustc.edu.cn> <20060608094356.5c1272cc.lista1@comhem.se> <349766648.27054@ustc.edu.cn> <20060608142556.2e10e379.lista1@comhem.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060608142556.2e10e379.lista1@comhem.se>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2006 at 02:25:56PM +0200, Voluspa wrote:
> On Thu, 8 Jun 2006 19:37:31 +0800 Fengguang Wu wrote:
> > I'd like to show some numbers on the pure software overheads come with
> > the adaptive readahead in daily operations.
> [...]
> > 
> > # time find /usr -type f -exec md5sum {} \; >/dev/null
> > 
> > ARA
> > 
> > 406.00s user 325.16s system 97% cpu 12:28.17 total
> 
> Just out of interest, all your figures show an almost maxed out CPU.
> Why is it that my own runs use so little CPU? I'm running the above

It does not have to wait for disk _seeks_, I guess.
All reads inside qemu actually hit the page cache in the host system ;)

> command as we 'speak' and on average only 40% is utilized, with the
> occasional spike at max 75%. And this is on the lowest CPU level
> 800MHz, which means that the 80% up_threshold of the ondemand cpufreq
> governor never is breached (there are 1800MHz, 2000MHz and 2200MHz
> levels above it).
> 
> Are you only 'giving' qemu something like 400MHz to play with or is
> qemu so inefficient in itself 

My qemu command line is:

        qemu -m 156 /lab/wfg/linux_image -kernel ./arch/i386/boot/bzImage
                        -append "root=/dev /hda console=ttyS0,9600" -nographic

I do not have the qemu accelerator, though.

Thanks,
Wu
