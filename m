Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265548AbUATOuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 09:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbUATOuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 09:50:08 -0500
Received: from ns.suse.de ([195.135.220.2]:37357 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265548AbUATOuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 09:50:03 -0500
Date: Tue, 20 Jan 2004 15:48:32 +0100
From: Olaf Dabrunz <od@suse.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA vs. OSS
Message-ID: <20040120144832.GJ14815@suse.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Jaroslav Kysela <perex@suse.cz>
References: <1074532714.16759.4.camel@midux> <Pine.LNX.4.58.0401192036070.3707@pnote.perex-int.cz> <20040120142422.GA14811@suse.de> <Pine.LNX.4.58.0401201524230.2010@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0401201524230.2010@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-Jan-04, Jaroslav Kysela wrote:
> On Tue, 20 Jan 2004, Olaf Dabrunz wrote:
> 
> > > We don't do this in kernel. We implemented the direct stream mixing in our 
> > > library (userspace). If your applications already uses ALSA APIs or if you 
> > > redirect the OSS ioctls to ALSA library (our aoss library), you can enjoy 
> >   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > How can this be done? Just by creating symlinks?
> 
> No. Use aoss script in our alsa-oss package.

Ah, I see.

# objdump -t /usr/lib/libaoss.so.0.0.0

/usr/lib/libaoss.so.0.0.0:     file format elf32-i386

SYMBOL TABLE:
[...]
000062a0 g     F .text	00000088              ioctl
[...]
00006490 g     F .text	0000008f              munmap
[...]
00006bc0 g     F .text	00000857              select
[...]
000063c0 g     F .text	000000cf              mmap
[...]
00006180 g     F .text	00000088              write
[...]
00006210 g     F .text	00000088              read
[...]
00006890 g     F .text	00000325              poll
[...]
00005fd0 g     F .text	000000da              open
[...]
00006330 g     F .text	00000088              fcntl
[...]
000060b0 g     F .text	000000c9              close
[...]

So libaoss.so is a wrapper for all file-related system-calls, I suppose
to catch calls involving /dev/dsp and /dev/audio.

-- 
Olaf Dabrunz (od / odabrunz), SUSE Linux AG, Nürnberg

