Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWE3SuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWE3SuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 14:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWE3SuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 14:50:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53268 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932385AbWE3SuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 14:50:21 -0400
Date: Tue, 30 May 2006 20:51:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: .17rc5 cfq slab corruption.
Message-ID: <20060530185158.GG4199@suse.de>
References: <20060526213915.GB7585@redhat.com> <20060526170013.67391a2b.akpm@osdl.org> <20060527070724.GB24988@suse.de> <20060527133122.GB3086@redhat.com> <20060530131728.GX4199@suse.de> <20060530161232.GA17218@redhat.com> <20060530164917.GB4199@suse.de> <20060530165649.GB17218@redhat.com> <20060530170435.GC4199@suse.de> <20060530184911.GD4199@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530184911.GD4199@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30 2006, Jens Axboe wrote:
> On Tue, May 30 2006, Jens Axboe wrote:
> > On Tue, May 30 2006, Dave Jones wrote:
> > > On Tue, May 30, 2006 at 06:49:18PM +0200, Jens Axboe wrote:
> > > 
> > >  > > List corruption. next->prev should be f74a5e2c, but was ea7ed31c
> > >  > > Pointing at cfq_set_request.
> > >  > 
> > >  > I think I'm missing a piece of this - what list was corrupted, in what
> > >  > function did it trigger?
> > > 
> > > If you look at the attachment in the bugzilla url in my previous msg,
> > > you'll see this:
> > > 
> > > ay 30 05:31:33 mandril kernel: List corruption. next->prev should be f74a5e2c, but was ea7ed31c
> > > May 30 05:31:33 mandril kernel: ------------[ cut here ]------------
> > > May 30 05:31:33 mandril kernel: kernel BUG at include/linux/list.h:58!
> > > May 30 05:31:33 mandril kernel: invalid opcode: 0000 [#1]
> > > May 30 05:31:33 mandril kernel: SMP
> > > May 30 05:31:33 mandril kernel: last sysfs file: /devices/pci0000:00/0000:00:1f.3/i2c-0/0-002e/pwm3
> > > May 30 05:31:33 mandril kernel: Modules linked in: iptable_filter ipt_DSCP iptable_mangle ip_tables x_tables eeprom lm85 hwmon_vid hwmon i2c_isa ipv6 nls_utf8 loop dm_mirror dm_mod video button battery ac lp parport_pc parport ehci_hcd uhci_hcd floppy snd_intel8x0 snd_ac97_codec snd_ac97_bus sg snd_seq_dummy matroxfb_base snd_seq_oss snd_seq_midi_event matroxfb_DAC1064 snd_seq matroxfb_accel matroxfb_Ti3026 3w_9xxx matroxfb_g450 snd_seq_device g450_pll matroxfb_misc snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd e1000 soundcore snd_page_alloc i2c_i801 i2c_core ext3 jbd 3w_xxxx ata_piix libata sd_mod scsi_mod
> > > May 30 05:31:33 mandril kernel: CPU:    0
> > > May 30 05:31:33 mandril kernel: EIP:    0060:[<c04e3310>]    Not tainted VLI
> > > May 30 05:31:33 mandril kernel: EFLAGS: 00210292   (2.6.16-1.2227_FC6 #1)
> > > May 30 05:31:33 mandril kernel: EIP is at cfq_set_request+0x202/0x3ff
> > 
> > Just do a l *cfq_set_request+0x202 from gdb if you have
> > CONFIG_DEBUG_INFO enabled in your vmlinux.
> 
> Doh, found it. Dave, please try and reproduce with this applied:

Nevermind, that's not it either. Damn. Stay tuned.

-- 
Jens Axboe

