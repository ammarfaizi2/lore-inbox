Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWE3GkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWE3GkU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 02:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWE3GkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 02:40:20 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:2723 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932158AbWE3GkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 02:40:19 -0400
Message-ID: <348971216.13769@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 30 May 2006 14:40:26 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Voluspa <lista1@comhem.se>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: Adaptive Readahead V14 - statistics question...
Message-ID: <20060530064026.GA4950@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Voluspa <lista1@comhem.se>, Valdis.Kletnieks@vt.edu,
	linux-kernel@vger.kernel.org
References: <20060530053631.57899084.lista1@comhem.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530053631.57899084.lista1@comhem.se>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 05:36:31AM +0200, Voluspa wrote:
> 
> Sorry about the top-post, I'm not subscribed.
> 
> On 2006-05-30 0:37:57 Wu Fengguang wrote:
> > On Mon, May 29, 2006 at 03:44:59PM -0400, Valdis Kletnieks wrote:
> [...]
> >> doing anything useful? (One thing I've noticed is that xmms, rather
> >> than gobble up 100K of data off disk every 10 seconds or so, snarfs
> >> a big 2M chunk every 3-4 minutes, often sucking in an entire song at
> >> (nearly) one shot...)
> >
> > Hehe, it's resulted from the enlarged default max readahead size(128K
> > => 1M). Too much aggressive? I'm interesting to know the recommended
> > size for desktops, thanks. For now you can adjust it through the
> > 'blockdev --setra /dev/hda' command.
> 
> And notebooks? I'm running a 64bit system with 2gig memory and a 7200
> RPM disk. Without your patches a movie like Elephants_Dream_HD.avi
> causes a continuous silent read. After patching 2.6.17-rc5 (more on that
> later) there's a slow 'click-read-click-read-click-etc' during the
> same movie as the head travels _somewhere_ to rest(?) between reads.
> 
> Distracting in silent sequences, and perhaps increased disk wear/tear.
> I'll try adjusting the readahead size towards silence tomorrow.

Hmm... It seems risky to increase the default readahead size.
I would appreciate a feed back when you are settled with some new
size, thanks.

btw, maybe you will be interested in the 'laptop mode'.
It prolongs battery life by making disk activity "bursty":
http://www.xs4all.nl/~bsamwel/laptop_mode/

> But as size slides in a mainstream direction, whence will any benefit
> come - in this Joe-average case? It's not a faster 'cp' at least:
> 
> _Cold boot between tests - Copy between different partitions_

I have never did 'cp' tests, because it involves writes caching
problems. Which makes the result hard to interpret. However I will
try to explain the two tests.

> 2.6.17-rc5-proper (Elephants_Dream_HD.avi 854537054 bytes)
> 
> real    0m44.050s
> user    0m0.076s
> sys     0m6.344s
> 
> 2.6.17-rc5-patched
> 
> real    0m49.353s
> user    0m0.075s
> sys     0m6.287s

- only size matters in this trivial case.
- the increased size generally do not help single reading speed.
- but it helped reducing overhead(i.e. decreased user/sys time)
- not sure why real time increased so much.

> 2.6.17-rc5-proper (compiled kernel tree linux-2.6.17-rc5 ~339M)
> 
> real    0m47.952s
> user    0m0.198s
> sys     0m6.118s
> 
> 2.6.17-rc5-patched
> 
> real    0m46.513s
> user    0m0.200s
> sys     0m5.827s

- the small files optimization in the new logic helped a little

Thanks,
Wu
