Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUGMJpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUGMJpw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 05:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUGMJpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 05:45:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:44999 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264704AbUGMJpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 05:45:51 -0400
Date: Tue, 13 Jul 2004 02:44:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: rlrevell@joe-job.com, linux-audio-dev@music.columbia.edu, mingo@elte.hu,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040713024423.2367b4e3.akpm@osdl.org>
In-Reply-To: <s5hbrikb6aj.wl@alsa2.suse.de>
References: <20040709182638.GA11310@elte.hu>
	<20040710222510.0593f4a4.akpm@osdl.org>
	<1089673014.10777.42.camel@mindpipe>
	<20040712163141.31ef1ad6.akpm@osdl.org>
	<1089677823.10777.64.camel@mindpipe>
	<20040712174639.38c7cf48.akpm@osdl.org>
	<1089687168.10777.126.camel@mindpipe>
	<20040712205917.47d1d58b.akpm@osdl.org>
	<1089707483.20381.33.camel@mindpipe>
	<20040713014316.2ce9181d.akpm@osdl.org>
	<1089708818.20381.36.camel@mindpipe>
	<20040713020025.7400c648.akpm@osdl.org>
	<s5hekngb6u0.wl@alsa2.suse.de>
	<20040713022501.5e41b1a2.akpm@osdl.org>
	<s5hbrikb6aj.wl@alsa2.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:
>
> > You can do unlock_kernel()/lock_kernel() in soundcore_open().
> 
>  I remember ioctl() is also in lock_kernel()?

yes, you'll need to do unlock_kernel/lock_kernel there too.  If someone
changes the rules, or otherwise calls your ioctl withoht lock_kernel() held
it will reliably go BUG with spinlock debugging enabled, so make sure you
test with CONFIG_DEBUG_SPINLOCK=y.
