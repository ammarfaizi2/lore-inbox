Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTEGNa4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 09:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbTEGNa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 09:30:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:48258 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263187AbTEGNaw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 09:30:52 -0400
Date: Wed, 7 May 2003 09:45:13 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
In-Reply-To: <20030507132024.GB18177@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.53.0305070933450.11740@chaos>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, [iso-8859-1] Jörn Engel wrote:

> 41 functoins for 2.5.69, 45 functions for 2.5.68, 44 for 2.5.67.
> Things are improving again.
>
> There are five more fixes remaining in -je, so it might be time for a
> resend session.
>
> P 0xc0229406 presto_get_fileid:                            sub    $0x1198,%esp
> P 0xc0227bf6 presto_copy_kml_tail:                         sub    $0x1028,%esp
> 0xc08f1458 ide_unregister:                               sub    $0x9dc,%esp
> 0xc082b66b v4l_compat_translate_ioctl:                   sub    $0x8d4,%esp
> 0xc08b2d23 ia_ioctl:                                     sub    $0x84c,%esp
> 0xc0e48233 snd_emu10k1_fx8010_ioctl:                     sub    $0x830,%esp
> 0xc0845e86 w9966_v4l_read:                               sub    $0x828,%esp
> 0xc0dd895b snd_cmipci_ac3_copy:                          sub    $0x7c0,%esp
> 0xc0dd8f7b snd_cmipci_ac3_silence:                       sub    $0x7c0,%esp
> P 0xc0a9f1a8 amd_flash_probe:                              sub    $0x72c,%esp
> 0xc0105650 huft_build:                                   sub    $0x59c,%esp
> 0xc01073d0 huft_build:                                   sub    $0x59c,%esp
> 0xc02e4a96 dohash:                                       sub    $0x594,%esp
> 0xc0108256 inflate_dynamic:                              sub    $0x554,%esp
> P 0xc05d8733 ida_ioctl:                                    sub    $0x54c,%esp
> 0xc01064a6 inflate_dynamic:                              sub    $0x538,%esp
> P 0xc0fbf8b3 device_new_if:                                sub    $0x520,%esp
> 0xc021ddd6 presto_ioctl:                                 sub    $0x508,%esp
> 0xc0e424b8 snd_emu10k1_add_controls:                     sub    $0x4dc,%esp
> 0xc0e6a066 snd_trident_mixer:                            sub    $0x4c0,%esp
> 0xc0106307 inflate_fixed:                                sub    $0x4ac,%esp
> 0xc01080b7 inflate_fixed:                                sub    $0x4ac,%esp
> 0xc0908ab1 ide_config:                                   sub    $0x4a8,%esp
> 0xc05bcc5c parport_config:                               sub    $0x490,%esp
> 0xc0c0e643 ixj_config:                                   sub    $0x484,%esp
> 0xc10ad9e6 sctp_hash_digest:                             sub    $0x45c,%esp
> 0xc104da33 gss_pipe_downcall:                            sub    $0x450,%esp
> 0xc03bc4c8 ciGetLeafPrefixKey:                           sub    $0x428,%esp
> 0xc045fae3 befs_error:                                   sub    $0x418,%esp
> 0xc045fb53 befs_warning:                                 sub    $0x418,%esp
> 0xc045fbc3 befs_debug:                                   sub    $0x418,%esp
> 0xc07a5c86 wv_hw_reset:                                  sub    $0x418,%esp
> 0xc0b4bea0 isd200_action:                                sub    $0x414,%esp
> 0xc1685145 root_nfs_name:                                sub    $0x414,%esp
> 0xc0c32172 bt3c_config:                                  sub    $0x410,%esp
> 0xc0c36282 btuart_config:                                sub    $0x410,%esp
> 0xc07642c1 hex_dump:                                     sub    $0x40c,%esp
> 0xc0331cf7 jffs2_rtime_compress:                         sub    $0x408,%esp
> 0xc0c3073f dtl1_config:                                  sub    $0x408,%esp
> 0xc0c34556 bluecard_config:                              sub    $0x408,%esp
> 0xc0331df5 jffs2_rtime_decompress:                       sub    $0x404,%esp
>
> Jörn
>

You know (I hope) that allocating stuff on the stack is not
"bad". In fact, it's the quickest way to allocate data that
will automatically go away when the function returns. One
just subtracts a value from the stack-pointer and you have
the data area. I sure hope that these temporary allocations
are not being replaced with kmalloc()/kfree(). If so, the
code is badly broken and you are eating my CPU cycles for
nothing.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

