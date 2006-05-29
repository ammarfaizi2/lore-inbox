Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWE2Ur4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWE2Ur4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 16:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWE2Ur4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 16:47:56 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:44744 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S1751286AbWE2Urz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 16:47:55 -0400
Date: Mon, 29 May 2006 22:47:24 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060529204724.GA22250@fks.be>
References: <20060526182217.GA12687@fks.be> <20060526133410.9cfff805.zaitcev@redhat.com> <20060529120102.1bc28bf2@doriath.conectiva> <20060529132553.08b225ba@doriath.conectiva> <20060529141110.6d149e21@doriath.conectiva> <20060529194334.GA32440@fks.be> <20060529172410.63dffa72@doriath.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529172410.63dffa72@doriath.conectiva>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-105.814,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL 0.09,
	BAYES_00 -2.60, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2006 at 05:24:10PM -0300, Luiz Fernando N. Capitulino wrote:
> On Mon, 29 May 2006 21:43:35 +0200
> Frank Gevaerts <frank.gevaerts@fks.be> wrote:
> 
> | On Mon, May 29, 2006 at 02:11:10PM -0300, Luiz Fernando N. Capitulino wrote:
> | > 
> | >  Frank, could you try this one please?
> | > 
> | >  I have no sure whether this makes sense, but every USB-Serial driver
> | > I know exits in the write URB callback if the URB got an error.
> | 
> | It looks sane to me at least.
> | The machine is now running with this patch (and my ipaq_open patch, see
> | http://www.ussg.iu.edu/hypermail/linux/kernel/0605.2/1901.html).
> 
>  Hmmm. Then does the workqueue problem began to happen _after_ you applied
> your patch?

No. I saw it a few times before that as well. Here is the oldest one I found (using 2.6.15)

May  8 13:11:17 localhost kernel: kernel BUG at kernel/workqueue.c:109!
May  8 13:11:17 localhost kernel: invalid operand: 0000 [#1]
May  8 13:11:17 localhost kernel: Modules linked in: ppp_generic slhc ipaq usbserial sd_mod uhci_hcd yealink usb_storage usbhid ohci_hcd ehci_hcd usbcore tun 8139too mii sr_mod sbp2 scsi_mod ieee1394 psmouse ide_generic ide_cd cdrom genrtc ext3 jbd mbcache ide_disk generic via82cxxx ide_core evdev mousedev
May  8 13:11:17 localhost kernel: CPU:    0
May  8 13:11:17 localhost kernel: EIP:    0060:[queue_work+23/50]    Not tainted VLI
May  8 13:11:17 localhost kernel: EFLAGS: 00010213   (2.6.15-1-686)
May  8 13:11:17 localhost kernel: EIP is at queue_work+0x17/0x32
May  8 13:11:17 localhost kernel: eax: d7fcf944   ebx: dbec6680   ecx: 00000000   edx: d7fcf940
May  8 13:11:17 localhost kernel: esi: 00000000   edi: d9b6aa14   ebp: d9b6aa14   esp: d7a03e18
May  8 13:11:17 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  8 13:11:17 localhost kernel: Process rmmod (pid: 4340, threadinfo=d7a02000 task=d77fb050)
May  8 13:11:17 localhost kernel: Stack: d9ab4f20 dca3a9df d7fcf000 d9b6aa00 dca36740 dca36760 dc9e70ea d9b6aa00
May  8 13:11:17 localhost kernel:        d9b6aa7c d9b6aa14 c0202e2a d9b6aa14 d9b6aa14 d9fe1068 d9fe1000 c0202e5c
May  8 13:11:17 localhost kernel:        d9b6aa14 d9b6aa14 c02027f9 d9b6aa14 d9b6aa14 c0201ae9 d9b6aa14 00000000
May  8 13:11:17 localhost kernel: Call Trace:
May  8 13:11:17 localhost kernel:  [pg0+476928479/1070175232] usb_serial_disconnect+0x5b/0x9f [usbserial]
May  8 13:11:17 localhost kernel:  [pg0+476586218/1070175232] usb_unbind_interface+0x36/0x6f [usbcore]
May  8 13:11:17 localhost kernel:  [__device_release_driver+72/99] __device_release_driver+0x48/0x63
May  8 13:11:17 localhost kernel:  [device_release_driver+23/38] device_release_driver+0x17/0x26
May  8 13:11:17 localhost kernel:  [bus_remove_device+82/101] bus_remove_device+0x52/0x65
May  8 13:11:17 localhost kernel:  [device_del+57/101] device_del+0x39/0x65
May  8 13:11:17 localhost kernel:  [pg0+476612208/1070175232] usb_disable_device+0x73/0xe7 [usbcore]
May  8 13:11:17 localhost kernel:  [pg0+476594141/1070175232] usb_disconnect+0x93/0xec [usbcore]
May  8 13:11:17 localhost kernel:  [pg0+476594123/1070175232] usb_disconnect+0x81/0xec [usbcore]
May  8 13:11:17 localhost kernel:  [pg0+476594123/1070175232] usb_disconnect+0x81/0xec [usbcore]
May  8 13:11:17 localhost kernel:  [pg0+476607388/1070175232] usb_remove_hcd+0x58/0xa3 [usbcore]
May  8 13:11:17 localhost kernel:  [pg0+476632530/1070175232] usb_hcd_pci_remove+0x16/0x77 [usbcore]
May  8 13:11:17 localhost kernel:  [pci_device_remove+25/44] pci_device_remove+0x19/0x2c
May  8 13:11:17 localhost kernel:  [__device_release_driver+72/99] __device_release_driver+0x48/0x63
May  8 13:11:17 localhost kernel:  [driver_detach+54/76] driver_detach+0x36/0x4c
May  8 13:11:17 localhost kernel:  [bus_remove_driver+60/93] bus_remove_driver+0x3c/0x5d
May  8 13:11:17 localhost kernel:  [driver_unregister+11/21] driver_unregister+0xb/0x15
May  8 13:11:17 localhost kernel:  [pci_unregister_driver+14/25] pci_unregister_driver+0xe/0x19
May  8 13:11:17 localhost kernel:  [pg0+476326132/1070175232] ehci_hcd_pci_cleanup+0xa/0xc [ehci_hcd]
May  8 13:11:17 localhost kernel:  [sys_delete_module+304/347] sys_delete_module+0x130/0x15b
May  8 13:11:17 localhost kernel:  [do_munmap+223/235] do_munmap+0xdf/0xeb
May  8 13:11:17 localhost kernel:  [sys_munmap+58/85] sys_munmap+0x3a/0x55
May  8 13:11:17 localhost kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  8 13:11:17 localhost kernel: Code: ff 40 04 83 c0 10 6a 00 e8 fb 17 ff ff 58 57 9d 5b 5e 5f c3 53 31 c9 89 c3 0f ba 2a 00 19 c0 85 c0 75 1f 8d 42 04 39 42 04 74 08 <0f> 0b 6d 00 65 5f 28 c0 52 ff 33 e8 96 ff ff ff 5a b9 01 00 00
May  8 13:11:17 localhost kernel:  <6>ohci_hcd 0000:00:0a.1: remove, state 1

>  Are you sure your patch is the right thing to do? Does it look reasonable
> to submit that urb 1000 times that way?

It only submits it once, just after the control message has succeeded.
The loop is needed because sometimes the ipaq takes a very long time
(more than a minute) before it starts accepting the control message.

>  At first, it seems something else.
> 
>  Couldn't you run your test-case in a kernel previous to the TTY layer
> buffering revamp change?

We first used 2.6.15. We got different types of error : a panic in
ipaq_read_bulk_callback(), the bug I mentionned in
http://www.ussg.iu.edu/hypermail/linux/kernel/0605.2/1770.html and the
current problem. We first tried upgrading to 2.6.16, which did not help.

The panic was caused by the read urb being submitten in ipaq_open,
regardless of success, and never killed in case of failure. What my
patch basically does is to submit the urb only after succesfully sending
the control message, and adding a sleep between tries. As long as this
patch is not applied, we hardly get any other error because the kernel
panics as soon as an ipaq reboots.

After changing ipaq_open, we did not get the panic any more, and the
first error (in do_tty_hangup) seems to have gone at the same time, but
the usb_serial_disconnect bug was still there.

Frank

> | If the problem is still there, it should occur within 24 hours in our
> | usage mode (25 ipaqs rebooting every 15 minutes to provide lots of
> | connects and disconnects).  I'll let you know the results.
> 
>  Wow, nice.
> 
> -- 
> Luiz Fernando N. Capitulino

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19
