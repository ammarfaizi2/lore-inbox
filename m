Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263657AbTEEQnv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263655AbTEEQYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:24:35 -0400
Received: from franka.aracnet.com ([216.99.193.44]:49085 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263648AbTEEQWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:22:43 -0400
Date: Mon, 05 May 2003 09:34:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 662] New: Badness in kobject_register at lib/kobject.c:288 
Message-ID: <10120000.1052152480@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=662

           Summary: Badness in kobject_register at lib/kobject.c:288
    Kernel Version: 2.5.68
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: jochen@jochen.org


Distribution: Debian sarge
Hardware Environment: IBM thinkpad 600

Problem Description:

Loading the ALSA drivers yields in dmesg:

CS4236+ soundcard not found or device busy
Badness in kobject_register at lib/kobject.c:288
Call Trace:
 [<c6d1e27c>] cs423x_pnpc_driver+0x5c/0xa0 [snd_cs4236]
 [<c01eede8>] kobject_register+0x58/0x70
 [<c6d1e26c>] cs423x_pnpc_driver+0x4c/0xa0 [snd_cs4236]
 [<c0226977>] bus_add_driver+0x57/0xf0
 [<c6d1e26c>] cs423x_pnpc_driver+0x4c/0xa0 [snd_cs4236]
 [<c011b958>] printk+0x118/0x180
 [<c6d1e23c>] cs423x_pnpc_driver+0x1c/0xa0 [snd_cs4236]
 [<c6d1e220>] cs423x_pnpc_driver+0x0/0xa0 [snd_cs4236]
 [<c0226e8a>] driver_register+0x3a/0x40
 [<c6d1e250>] cs423x_pnpc_driver+0x30/0xa0 [snd_cs4236]
 [<c6d1e23c>] cs423x_pnpc_driver+0x1c/0xa0 [snd_cs4236]
 [<c6d1e220>] cs423x_pnpc_driver+0x0/0xa0 [snd_cs4236]
 [<c01faaf1>] pnp_register_driver+0x41/0x70
 [<c6d1e250>] cs423x_pnpc_driver+0x30/0xa0 [snd_cs4236]
 [<c6d1c711>] +0x62/0x71 [snd_cs4236]
 [<c01fa676>] pnp_register_card_driver+0x66/0xb0
 [<c6d1e23c>] cs423x_pnpc_driver+0x1c/0xa0 [snd_cs4236]
 [<c6d1e2c0>] +0x0/0xe0 [snd_cs4236]
 [<c6cde038>] +0x38/0x82 [snd_cs4236]
 [<c6d1e220>] cs423x_pnpc_driver+0x0/0xa0 [snd_cs4236]
 [<c01300b1>] sys_init_module+0x131/0x210
 [<c6d1e2c0>] +0x0/0xe0 [snd_cs4236]
 [<c010944b>] syscall_call+0x7/0xb

CS4236+ soundcard not found or device busy

Steps to reproduce:
The config used is:
root@gswi1164:/usr/src/linux-2.5.68# grep SND .config | grep "="
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_MEMORY=y
CONFIG_SND_DEBUG_DETECT=y
CONFIG_SND_MPU401=m
CONFIG_SND_CS4232=m
CONFIG_SND_CS4236=m

Loading is with the debian scripts from testing (0.9.2-6)

