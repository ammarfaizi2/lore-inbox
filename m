Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbTEEQRi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTEEQRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:17:37 -0400
Received: from franka.aracnet.com ([216.99.193.44]:38836 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263270AbTEEQRd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:17:33 -0400
Date: Mon, 05 May 2003 09:29:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 641] New: sleeping function called from illegal context 
Message-ID: <9220000.1052152171@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=641

           Summary: sleeping function called from illegal context
    Kernel Version: 2.5.68
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: angus.sawyer@dsl.pipex.com


Distribution: redhat 9 
Hardware Environment: Athlon/ SoundBlaster Live 
Software Environment: alsa drivers/rosegarden 
Problem Description: 
Debug: sleeping function called from illegal context at
include/asm/semaphore.h:  119 
Call Trace: 
 [<c011dadf>] __might_sleep+0x5f/0x80 
 [<e325c3f6>] +0x40a/0x574 [snd_emux_synth] 
 [<e3258b4a>] lock_preset+0x1ca/0x290 [snd_emux_synth] 
 [<e325c3f6>] +0x40a/0x574 [snd_emux_synth] 
 [<e325aaaf>] snd_soundfont_search_zone+0x2f/0xf0 [snd_emux_synth] 
 [<e0911f10>] snd_timer_s_function+0x0/0x20 [snd_timer] 
 [<e3256830>] get_zone+0x70/0x90 [snd_emux_synth] 
 [<e3254632>] snd_emux_note_on+0xf2/0x4a0 [snd_emux_synth] 
 [<c010c263>] do_IRQ+0x233/0x370 
 [<e325eec0>] emux_ops+0x0/0x20 [snd_emux_synth] 
 [<e09090f6>] +0xf6/0x3c0 [snd_seq_midi_emul] 
 [<c014b0eb>] check_poison_obj+0x3b/0x190 
 [<c02aefb4>] kfree_skbmem+0x64/0x70 
 [<e3257293>] snd_emux_event_input+0x63/0xa0 [snd_emux_synth] 
 [<e325eec0>] emux_ops+0x0/0x20 [snd_emux_synth] 
 [<e3241657>] snd_seq_deliver_single_event+0x147/0x1b0 [snd_seq] 
 [<e3241965>] snd_seq_deliver_event+0x45/0xb0 [snd_seq] 
 [<e3241a9a>] snd_seq_dispatch_event+0xca/0x1b0 [snd_seq] 
 [<c011165a>] do_gettimeofday+0x1a/0x90 
 [<e3247335>] snd_seq_check_queue+0x245/0x500 [snd_seq] 
 [<c016b19b>] do_sync_read+0x8b/0xc0 
 [<e09113fd>] snd_timer_interrupt+0x48d/0x610 [snd_timer] 
 [<c02ab029>] sock_poll+0x29/0x40 
 
Steps to reproduce: play midi files using hardware synth

