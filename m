Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVAOFIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVAOFIB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 00:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVAOFIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 00:08:01 -0500
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:37827 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S262147AbVAOFHw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 00:07:52 -0500
Date: Sat, 15 Jan 2005 07:07:50 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.6.10-ac9
Message-ID: <20050115050749.GB8456@m.safari.iki.fi>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <1105636996.4644.70.camel@localhost.localdomain> <20050114030135.GA6032@m.safari.iki.fi> <1105743716.9839.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105743716.9839.29.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 12:32:59AM +0000, Alan Cox wrote:
> On Gwe, 2005-01-14 at 03:01, Sami Farin wrote:
> > at this spot I have no /dev/dsp etc.
> > then I reload snd_ens1371:
> 
> That sounds like the new udev rather than kernel side. The changes from
> ac8 to ac9 are tiny on the audio side and don't involve driver setup
> stuff.
>
> > also, with 2.6.10 I can't disable write cache...
> > I could do it in 2.6.9.
> 
> Works for me in 2.6.10-ac. Are there any diagnostics on dmesg when you
> try and turn the cache off ?

no, nothing.

how do I know now is hdparm -I or -W lying?
(-I says it's enabled and -W0 says it was disabled just fine.)

my drives do not support cache flushes, I guess your drives do?

drivers/ide/ide-disk.c:write_cache()
if (!ide_id_has_flush_cache(drive->id))
  return 1;

cat /proc/ide/hda/settings does not work, either

cat           D C0572788     0  8016   5187                6044 (NOTLB)
cdc97eb0 00000046 cf7f00a0 c0572788 00005699 c01fe93f 000001ad 00000023 
       01078345 00005699 cf7f00a0 00000bbb 02ed12c3 00005699 cfec51d8 c04de020 
       cfec5080 00000246 cdc97ee8 c0409764 c04de028 00000001 cfec5080 c011ab70 
Call Trace:
 [<c0409764>] __down+0x64/0xc0
 [<c04098ba>] __down_failed+0xa/0x10
 [<c0302acf>] .text.lock.ide_proc+0x8b/0x1fc
 [<c018c594>] proc_file_read+0xc4/0x260
 [<c0158fbf>] vfs_read+0xcf/0x150
 [<c01592db>] sys_read+0x4b/0x80
 [<c0103163>] syscall_call+0x7/0xb

-- 
