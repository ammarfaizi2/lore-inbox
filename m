Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWAGDyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWAGDyJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 22:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWAGDyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 22:54:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56226 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030245AbWAGDyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 22:54:07 -0500
Date: Fri, 6 Jan 2006 22:53:51 -0500
From: Dave Jones <davej@redhat.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, airlied@linux.ie
Subject: Re: 2.6.15-mm1 - locks solid when starting KDE (EDAC errors)
Message-ID: <20060107035351.GH9402@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	airlied@linux.ie
References: <9a8748490601051552x4c8315e7n3c61860283a95716@mail.gmail.com> <20060105162714.6ad6d374.akpm@osdl.org> <9a8748490601051640s5a384dddga46d8106442d10c@mail.gmail.com> <20060105165946.1768f3d5.akpm@osdl.org> <9a8748490601061625q14d0ac04ica527821cf246427@mail.gmail.com> <20060107002833.GB9402@redhat.com> <20060106164012.041e14b2.akpm@osdl.org> <9a8748490601061851p7ecfab9fua866fc2a79153b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490601061851p7ecfab9fua866fc2a79153b0@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 03:51:48AM +0100, Jesper Juhl wrote:

 > Ok, this is with a pristine 2.6.15-mm1 + Dave's oops-pausing-patch
 > Captured by switching to tty1 just after logging in via kdm.
 > A *lot* of info still scrolls down when the problem hits before Daves
 > patch stops it at a BUG dump, it scrolls by too fast for me to see
 > what it is, but I guess it must be warning/error messages other than
 > Oops's or BUG()'s ???
 > 
 > Anyway, here's the entire contents of my screen after Daves patch
 > stops the output - again written down by hand and then typed in from
 > my handwritten notes, so there may be typos, but I've tried to be
 > accurate.
 > 
 > 
 > 050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > 060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > 070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > 080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > 090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > 0a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > 0b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

My first thought was 'slab poison', but you don't have slab debugging turned on.
Randy's followup to my patch: http://lkml.org/lkml/2006/1/5/15
had another trick that may be useful. It'll slow down printk's
to a point where you might be able to see what happened.

another trick may be to just add a for (;;) into the BUG macro.

 > ------------{ cut here ]------------
 > kernel BUG at include/linux/list.h:166!
 > invalid opcode: 0000 [#1]
 > PREEMPT SMP
 > Last sysfs file: /class/vc/vcsa2/dev
 > Modules linked in: snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss
 > snd_mixer_oss uhci_hcd usbcore snd_emu10k1 snd_rawmidi snd_ac97_codec
 > snd_ac97_bus snd_pcm snd_seq_device snd_timer snd_page_alloc
 > snd_util_mem snd_hwdep snd agpgart
 > CPU:    0
 > EIP:    0060:[<c01475f5>]    Tainted: G    B VLI

Hmm, you had hit bad_page(), so that may be a more useful place
to add a pause.

		Dave

