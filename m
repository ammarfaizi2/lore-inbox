Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWDLAeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWDLAeu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 20:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWDLAeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 20:34:50 -0400
Received: from mx0.karneval.cz ([81.27.192.108]:39047 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1751193AbWDLAes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 20:34:48 -0400
Message-ID: <443C4B33.60102@gmail.com>
Date: Wed, 12 Apr 2006 02:34:59 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: =?UTF-8?B?TWFydGluIE1PS1JFSsWg?= <mmokrejs@ribosome.natur.cuni.cz>
CC: LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Subject: Re: Oops in 2.6.17-rc1: EIP is at snd_pcm_oss_sync+0x1f/0x260 [snd_pcm_oss]
References: <443C41F2.5070307@ribosome.natur.cuni.cz>
In-Reply-To: <443C41F2.5070307@ribosome.natur.cuni.cz>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Martin MOKREJŠ napsal(a):
> I used skype to chat and after I tried to close the application it did
> not return
> to xterm. This is what I have found. Hope this helps someone to find the
> cause. ;-)
> 
> BUG: unable to handle kernel NULL pointer dereference at virtual address
> 000000a0
> printing eip:
> f9a2e57f
> *pde = 00000000
> Oops: 0000 [#1]
> Modules linked in: snd_pcm_oss snd_mixer_oss snd_seq_oss
> snd_seq_midi_event snd_seq snd_seq_device ohci_hcd ehci_hcd radeon drm
> eth1394 pcmcia ohci1394 ieee1394 uhci_hcd snd_intel8x0 snd_ac97_codec
> snd_ac97_bus snd_pcm snd_timer snd snd_page_alloc yenta_socket
> rsrc_nonstatic pcmcia_core intel_agp agpgart 8139too
> CPU:    0
> EIP:    0060:[<f9a2e57f>]    Not tainted VLI
> EFLAGS: 00010282   (2.6.17-rc1 #1) EIP is at snd_pcm_oss_sync+0x1f/0x260
> [snd_pcm_oss]
> eax: c1fe6580   ebx: f79f2140   ecx: f9a2f562   edx: 00000000
> esi: dfdbdb60   edi: f79f2000   ebp: da51ae24   esp: da51ae00
> ds: 007b   es: 007b   ss: 0068
> Process skype (pid: 12275, threadinfo=da51a000 task=f09bd070)
> Stack: <0>c1ee1a60 c1ee1a40 c1ee1a40 00000000 c1fe6580 dfdbdb60 f79f2140
> dfdbdb60       f79f2000 da51ae3c f9a2f587 f4738540 00000008 f4738540
> f752ae9c da51ae58       c014b2a3 c1cd4e40 f75208d4 f4738540 c1ec5f00
> 00000000 da51ae60 c014b20e Call Trace:
> <c0102f11> show_stack_log_lvl+0x89/0x91   <c0103066>
> show_registers+0x10e/0x176
> <c010321a> die+0xd8/0x168   <c01124ef> do_page_fault+0x452/0x538
> <c0102bb7> error_code+0x4f/0x54   <f9a2f587>
> snd_pcm_oss_release+0x25/0x88 [snd_pcm_oss]
> <c014b2a3> __fput+0x93/0x120   <c014b20e> fput+0x16/0x18
> <c0149fab> filp_close+0x4e/0x58   <c011a88e> close_files+0x57/0x67
> <c011a8c6> put_files_struct+0x17/0x3d   <c011b129> do_exit+0x19d/0x2fb
> <c011b305> sys_exit_group+0x0/0x11   <c0121a3a>
> get_signal_to_deliver+0x20b/0x21b
> <c01027a1> do_signal+0x54/0xfd   <c0102876> do_notify_resume+0x2c/0x3a
> <c0102a1e> work_notifysig+0x13/0x19  Code: 6f c6 8d 65 f4 89 d8 5b 5e 5f
> 5d c3 55 89 e5 57 56 53 83 ec 18 89 45 f0 8b 00 85 c0 89 45 ec 0f 84 f5
> 01 00 00 8b 50 5c 89 55 e8 <8b> 82 a0 00 00 00 85 c0 0f 85 a0 01 00 00
> 8b 45 ec e8 c0 f6 ff <1>Fixing recursive fault but reboot is needed!
Try this:
http://bugzilla.kernel.org/show_bug.cgi?id=6329#c10
(comment 10 patch)
I think, that's it, if not, turn on sound debug on and retest.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEPEszMsxVwznUen4RAiYzAKCV9qZb6SMMRv0DltWeY+Ty1EfOtACdFpL3
YIxT7B1auhk840e5akEN4wk=
=nuw5
-----END PGP SIGNATURE-----
