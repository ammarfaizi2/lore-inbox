Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263947AbUCZGES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 01:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263954AbUCZGES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 01:04:18 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:16368 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S263950AbUCZGEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 01:04:08 -0500
Date: Fri, 26 Mar 2004 13:59:53 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Pavel Machek" <pavel@suse.cz>,
       "Nigel Cunningham" <ncunningham@users.sourceforge.net>
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]]
Cc: "Suspend development list" <swsusp-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20040323233228.GK364@elf.ucw.cz> <opr5d7ad0b4evsfm@smtp.pacific.net.th> <20040325014107.GB6094@elf.ucw.cz> <200403250857.08920.matthias.wieser@hiasl.net> <1080247142.6679.3.camel@calvin.wpcb.org.au> <20040325222745.GE2179@elf.ucw.cz>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr5gf93ik4evsfm@smtp.pacific.net.th>
In-Reply-To: <20040325222745.GE2179@elf.ucw.cz>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004 23:27:45 +0100, Pavel Machek <pavel@suse.cz> wrote:

> Hi!
>
>> By the way, here's an example where having the /proc interface is a good
>> thing: which do you use? zip compression, lzf compression or no
>> compression? Until recently I always used lzf compression. I just
>
> We should select one, and drop the others.
>
> gzip is useless for almost everyone -> gets little testing -> is
> probably broken.
>
>> upgraded my laptop's hard drive, and found I wasn't getting the
>> performance improvements in suspending I expected. It turns out that the
>> CPU is now the limiting factor. Because I had the /proc interface, I
>> could easily adjust the debug settings to show me throughput and then
>> try a couple of suspend cycles with compression enabled and with it
>> disabled. Without the /proc interface, I would have had to have
>> recompiled the kernel to switch settings. (I didn't try gzip because I
>> knew it wasn't going to be a contender for me).
>

/proc is needed a lot

- enable escape
- select reboot mode
	which is essential for multibooting. We use it all the time to
	boot various installations of Linux
- select compression none, lzw or gzip
	none is used when disk faster that cpu-limited lzf
	lzf is used when cpu is fast enough to compress to disk
		Fast CPU can do 100MB/s+ to 50MB/s drives
	gzip is used by some who care about image size eg flash users
- keep image mode (when compiled in)
	which is used for embedded kiosks for example
		Boeing requested and uses it
- default console level
	Controls console messages or nice display
- access debug info header
	This is needed to analyze swsusp2 performance
- access resume parameters
	Saves a reboot when changing parameters
- activate
	swsusp2 activation independent of apci, apm
- last result
	info on why swsusp2 did not suspend such as out of
	memory or swap or freezing failure
- access version info
	could be dropped in mainline
- access interface version info
	could be dropped in mainline

Michael

