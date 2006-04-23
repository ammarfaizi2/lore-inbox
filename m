Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWDXAAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWDXAAQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 20:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWDXAAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 20:00:16 -0400
Received: from nproxy.gmail.com ([64.233.182.188]:32811 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751465AbWDXAAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 20:00:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=W2FLbAbq2NknR4ycg+fmFH1FZitBXknGl6nA6mZW7aV/rKEdbfxP+QFUoPhYjKXLL6DU93Qxmlu/QB2Z90lUl3AwOuTS7t8fxO8SCShVcmamxsea9lk1nSkfBM20QO8/a3NoZ+FACXcSy8XrAbBWt7P0wzUh25o4Pml61YYIW2U=
Date: Mon, 24 Apr 2006 03:57:30 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@alsa-project.org
Subject: ALSA regression: oops on shutdown
Message-ID: <20060423235730.GA7934@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ALSA oops I reported against 2.6.16-rc1-mm4 [1] sneaked into mainline
after release.
----------------------------
EIP is at remove_proc_entry
Process rmmod

snd_info_unregister             [snd]
snd_pcm_oss_proc_done           [snd_pcm_oss]
snd_pcm_oss_unregister_minor    [snd_pcm_oss]
snd_pcm_notify                  [snd_pcm]
sys_delete_module
do_munmap
syscall_call
----------------------------
Fine-grained bisecting points to commit 21a3479a0b606d36fe24093f70a1c27328cec286

    [ALSA] PCM midlevel & PCM OSS - make procfs & OSS plugin code optional

.config is

	CONFIG_SOUND=m
	CONFIG_SND=m
	CONFIG_SND_TIMER=m
	CONFIG_SND_PCM=m
	CONFIG_SND_OSSEMUL=y
	CONFIG_SND_MIXER_OSS=m
	CONFIG_SND_PCM_OSS=m
	CONFIG_SND_AC97_CODEC=m
	CONFIG_SND_AC97_BUS=m
	CONFIG_SND_INTEL8X0=m

[1] google-groups "2.6.16-rc1-mm4: ALSA oops at remove_proc_entry"

[2] cat ~/bin/google-groups
#!/bin/sh

case "$#" in
0)
	$BROWSER http://groups.google.com/advanced_search
	;;
1)
	$BROWSER http://groups.google.com/groups?as_q="$1"
	;;
esac

