Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVFUTmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVFUTmK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 15:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVFUTmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 15:42:02 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:33517 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262267AbVFUTjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 15:39:31 -0400
Message-ID: <42B86CF0.1020601@ens-lyon.org>
Date: Tue, 21 Jun 2005 21:39:28 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-mm1
References: <20050619233029.45dd66b8.akpm@osdl.org>	<42B6777F.2050008@ens-lyon.org>	<42B80AB5.7090506@ens-lyon.org>	<s5hll53oet1.wl%tiwai@suse.de>	<42B84820.9010105@ens-lyon.org> <s5hekavocjj.wl%tiwai@suse.de>
In-Reply-To: <s5hekavocjj.wl%tiwai@suse.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21.06.2005 19:16, Takashi Iwai a écrit :
> Yes.  It enables hardware volume contorl - volume up/down and
> mute/unmute via keys on your laptop.

Great, that's the last missing feature on my laptop !

> Could you give the output of lspci -nv?  If it's listed in
> m3_hw_quirk_list, the h/w volume control is enabled in the code
> indeed.  Try to comment out the entry (together with my second
> patch).

0000:02:09.0 0401: 125d:1988 (rev 12)
        Subsystem: 0e11:0094
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at 2400 [size=256]
        Capabilities: [c0] Power Management version 2

Yes it's listed in m3_hv_quirk_list,
and yes, commenting out the entry fixes the problem.

> This might include some changes applied to mm, but at least, you can
> apply only the patch to maestro3.c.

Guess what, git-alsa.patch (and actually also only the patch
to maestro3.c) do work on top on 2.6.12. Hardware volume control
works. That's great !

Actually, I'm experiencing another problem with -mm1 which might
be related to PCI and IO ports. This might be the cause of outw
generating the divide error I was seeing -mm1 if IO ports are
not mapped at the right place ?

Thanks,
Brice
