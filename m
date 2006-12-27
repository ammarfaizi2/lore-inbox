Return-Path: <linux-kernel-owner+w=401wt.eu-S932956AbWL0PaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932956AbWL0PaG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 10:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932960AbWL0PaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 10:30:05 -0500
Received: from javad.com ([216.122.176.236]:2825 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932956AbWL0PaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 10:30:04 -0500
From: Sergei Organov <osv@javad.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: moxa serial driver testing
References: <45222E7E.3040904@gmail.com> <87wt7hw97c.fsf@javad.com>
	<4522ABC3.2000604@gmail.com> <878xjx6xtf.fsf@javad.com>
	<4522B5C2.3050004@gmail.com> <87mz8borl2.fsf@javad.com>
	<45251211.7010604@gmail.com> <87zmcaokys.fsf@javad.com>
	<45254F61.1080502@gmail.com> <87vemyo9ck.fsf@javad.com>
	<4af2d03a0610061355p5940a538pdcbd2cda249161e8@mail.gmail.com>
	<87vemtnbyg.fsf@javad.com> <452A1862.9030502@gmail.com>
	<87r6urket6.fsf@javad.com> <552766292581216610@wsc.cz>
	<552766292581216610@wsc.cz> <554564654653216610@wsc.cz>
Date: Wed, 27 Dec 2006 18:29:47 +0300
In-Reply-To: <554564654653216610@wsc.cz> (Jiri Slaby's message of "Wed, 27
 Dec
	2006 14:36:56 +0100 (CET)")
Message-ID: <87r6uluzkk.fsf@javad.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> writes:

>> Jiri Slaby <jirislaby@gmail.com> writes:
>> 
>> > Could you test the patch below, if something changes?
>> 
>> Just tested with low_latency commented out. Still oopses:
>> 
>> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000008
>>  printing eip:
>> f8f1730f
>> *pde = 00000000
>> Oops: 0000 [#1]
>> SMP 
>> Modules linked in: nvidia agpgart ipv6 nfs lockd nfs_acl sunrpc dm_mod sr_mod sbp2 ieee1394 ide_generic ide_disk e1000 snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer i2c_i801 tsdev psmouse snd soundcore snd_page_alloc i2c_core serio_raw parport_pc parport mxser_new evdev floppy pcspkr rtc ext3 jbd mbcache usb_storage usbhid ide_cd cdrom sd_mod uhci_hcd piix usbcore skge ata_piix libata scsi_mod generic ide_core thermal processor fan
>> CPU:    0
>> EIP:    0060:[<f8f1730f>]    Tainted: P      VLI
>> EFLAGS: 00010046   (2.6.18-3-686 #1) 
>> EIP is at mxser_receive_chars+0x21b/0x249 [mxser_new]
>
> Yes, port->tty still somewhere becomes NULL -- does this patch help?

In addition to my previous answer. I've performed the same tests with
regular PC serial port. The issues with "Disabling Irq #N" and with I/O
error on open() exist with this port as well, so they aren't
mxser-specific.  I wasn't able to reproduce oopses, so they do seem to
be mxser-specific.

-- Sergei.
