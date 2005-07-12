Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVGLQBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVGLQBo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVGLQBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:01:43 -0400
Received: from posti5.jyu.fi ([130.234.4.34]:49895 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S261516AbVGLQBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:01:14 -0400
Date: Tue, 12 Jul 2005 19:00:37 +0300 (EEST)
From: Tero Roponen <teanropo@cc.jyu.fi>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Mikael Pettersson <mikpe@csd.uu.se>, gregkh@suse.de, jonsmirl@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [SOLVED] Re: 2.6.13-rc2 hangs at boot
In-Reply-To: <20050712174119.A31613@jurassic.park.msu.ru>
Message-ID: <Pine.GSO.4.58.0507121856050.27617@tukki.cc.jyu.fi>
References: <200507081354.j68Ds02b020296@harpo.it.uu.se>
 <20050712174119.A31613@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Checked: by miltrassassin
	at posti5.jyu.fi; Tue, 12 Jul 2005 19:00:39 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Ivan Kokshaysky wrote:

> On Fri, Jul 08, 2005 at 03:54:00PM +0200, Mikael Pettersson wrote:
> > Same here: 2.6.13-rc2 vanilla and 2.6.13-rc2 + patch #2 above both hang,
> > but 2.6.13-rc2 + patch #1 boots fine.
>
> I suspect that those larger (4K) cardbus IO windows are clashing with
> some legacy IO ports. If so, this could be avoided by setting ISAEN
> bridge control bit.
> It would be interesting to see whether the patch below works or not...
>
> Ivan.

Hi,

I tried 2.6.13-rc2-git5 with your patch.

First I forgot to install modules and it booted fine.
Then I did a 'sudo make modules_install' and rebooted. It hang.

It seems that everything is fine until some module
loads and does something.

-
Tero Roponen

ps.

In 2.6.12 lsmod gives me this:

Module                  Size  Used by
xirc2ps_cs             15728  1
pcmcia                 21416  5 xirc2ps_cs
sunrpc                128132  1
binfmt_misc             9352  1
yenta_socket           20360  3
rsrc_nonstatic         11488  1 yenta_socket
pcmcia_core            44280  4
xirc2ps_cs,pcmcia,yenta_socket,rsrc_nonstatic
snd_cs4236             13700  0
snd_opl3_lib            9152  1 snd_cs4236
snd_hwdep               7104  1 snd_opl3_lib
snd_cs4236_lib         15008  1 snd_cs4236
snd_mpu401_uart         6048  1 snd_cs4236
snd_rawmidi            20832  1 snd_mpu401_uart
snd_cs4231_lib         23808  2 snd_cs4236,snd_cs4236_lib
snd_seq_oss            33088  0
snd_seq_midi_event      6496  1 snd_seq_oss
snd_seq                50416  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          6892  4
snd_opl3_lib,snd_rawmidi,snd_seq_oss,snd_seq
snd_pcm_oss            50400  0
snd_mixer_oss          17696  1 snd_pcm_oss
snd_pcm                85096  3 snd_cs4236_lib,snd_cs4231_lib,snd_pcm_oss
snd_timer              21924  4
snd_opl3_lib,snd_cs4231_lib,snd_seq,snd_pcm
snd                    48388  14
snd_cs4236,snd_opl3_lib,snd_hwdep,snd_cs4236_lib,snd_mpu401_uart,snd_rawmidi,snd_cs4231_lib,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               7456  1 snd
snd_page_alloc          7556  2 snd_cs4231_lib,snd_pcm
floppy                 54772  0
ide_cd                 38436  0
cdrom                  38272  1 ide_cd
evdev                   7456  0


