Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWDXB6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWDXB6q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 21:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWDXB6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 21:58:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7351 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751486AbWDXB6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 21:58:45 -0400
Date: Sun, 23 Apr 2006 18:57:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: ALSA regression: oops on shutdown
Message-Id: <20060423185721.39ff4207.akpm@osdl.org>
In-Reply-To: <20060423235730.GA7934@mipter.zuzino.mipt.ru>
References: <20060423235730.GA7934@mipter.zuzino.mipt.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> ALSA oops I reported against 2.6.16-rc1-mm4 [1] sneaked into mainline
>  after release.

One wonders why the ALSA developers merged up which was known to cause
oopses.


>  ----------------------------
>  EIP is at remove_proc_entry
>  Process rmmod
> 
>  snd_info_unregister             [snd]
>  snd_pcm_oss_proc_done           [snd_pcm_oss]
>  snd_pcm_oss_unregister_minor    [snd_pcm_oss]
>  snd_pcm_notify                  [snd_pcm]
>  sys_delete_module
>  do_munmap
>  syscall_call
>  ----------------------------
>  Fine-grained bisecting points to commit 21a3479a0b606d36fe24093f70a1c27328cec286
> 
>      [ALSA] PCM midlevel & PCM OSS - make procfs & OSS plugin code optional
> 
>  .config is
> 
>  	CONFIG_SOUND=m
>  	CONFIG_SND=m
>  	CONFIG_SND_TIMER=m
>  	CONFIG_SND_PCM=m
>  	CONFIG_SND_OSSEMUL=y
>  	CONFIG_SND_MIXER_OSS=m
>  	CONFIG_SND_PCM_OSS=m
>  	CONFIG_SND_AC97_CODEC=m
>  	CONFIG_SND_AC97_BUS=m
>  	CONFIG_SND_INTEL8X0=m

Cannot reproduce it.  Please send full .config and precise means of
reproduction, thanks.

