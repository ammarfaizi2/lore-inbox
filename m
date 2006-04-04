Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWDDXTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWDDXTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 19:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWDDXTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 19:19:25 -0400
Received: from mail.gondor.com ([212.117.64.182]:24837 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S1750919AbWDDXTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 19:19:24 -0400
Date: Wed, 5 Apr 2006 01:19:11 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ken Moffat <zarniwhoop@ntlworld.com>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] Slab corruptions & Re: 2.6.17-rc1: Oops in sound applications
Message-ID: <20060404231911.GA4862@knautsch.gondor.com>
References: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain> <20060404133814.GA11741@knautsch.gondor.com> <s5hlkul72rv.wl%tiwai@suse.de> <20060404190631.GA4895@knautsch.gondor.com> <s5h7j656tpp.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h7j656tpp.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 09:12:18PM +0200, Takashi Iwai wrote:
> At Tue, 4 Apr 2006 21:06:31 +0200,
> Jan Niehusmann wrote:
> > 
> > On Tue, Apr 04, 2006 at 05:56:36PM +0200, Takashi Iwai wrote:
> > > Could you try the patch below by OGAWA Hirofumi
> > > <hirofumi@mail.parknet.co.jp>?
> > 
> > Sorry, no success with that patch applied:
> > 
> > Apr  4 20:18:00 knautsch kernel: [17179569.184000] Linux version 2.6.17-rc1-g231a1569-dirty (root@knautsch) (gcc version 4.0.3 (Debian 4.0.3-1)) #1 Tue Apr 4 19:37:29 CEST 2006 
> > 
> > (This is 2.6.17-rc1 with the patch you sent applied)
> > 
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000] BUG: unable to handle kernel paging request at virtual address 6b6b6b6b
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000]  printing eip:
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000] e04a2eb6
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000] *pde = 00000000
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000] Oops: 0000 [#1]
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000] Modules linked in: tun ipv6 lp i915 drm rfcomm l2cap bluetooth thermal processor fan button battery asus_acpi ac usb_storage usbmouse sbp2 usbkbd autofs4 af_packet nls_iso8859_1 nls_cp437 usbhid cm4000_cs 8250_pci 8250 serial_core eth1394 pcmcia snd_intel8x0 snd_pcm_oss snd_mixer_oss snd_intel8x0m snd_ac97_codec snd_ac97_bus ipw2200 ieee80211 ieee80211_crypt 8139too mii nsc_ircc irda snd_pcm snd_timer ohci1394 ieee1394 evdev joydev crc_ccitt parport_pc parport pcspkr firmware_class yenta_socket rsrc_nonstatic pcmcia_core rtc snd soundcore snd_page_alloc ehci_hcd uhci_hcd usbcore intel_agp agpgart
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000] CPU:    0
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000] EIP:    0060:[pg0+537210550/1069212672]    Not tainted VLI
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000] EFLAGS: 00210002   (2.6.17-rc1-g231a1569-dirty #1) 
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000] EIP is at snd_pcm_lib_write1+0x196/0x4a0 [snd_pcm]
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000] eax: 000009c4   ebx: cc785a84   ecx: de505e54   edx: 6b6b6b6b
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000] esi: 0000062c   edi: 00000000   ebp: dede51a4   esp: de505e78
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000] ds: 007b   es: 007b   ss: 0068
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000] Process twinkle (pid: 4936, threadinfo=de505000 task=cae0f550)
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000] Stack: <0>dede51a4 000015cd e07a5000 00000b42 0000003c 00000001 cc785b28 c84ef000 
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000]        e07a5000 00000b7e 00000b7e 00000000 00000000 0001c639 00000000 cae0f550 
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000]        c0114d60 cc785b28 cc785b28 c0000000 de505000 dede51a4 cc785a84 e0547727 
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000] Call Trace:
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000]  <c0114d60> default_wake_function+0x0/0x20   <e0547727> snd_pcm_oss_write3+0x67/0xe0 [snd_pcm_oss]
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000]  <e04a0250> snd_pcm_lib_write_transfer+0x0/0xc0 [snd_pcm]   <e054949f> snd_pcm_plug_write_transfer+0x8f/0xe0 [snd_pcm_oss]
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000]  <e054781a> snd_pcm_oss_write2+0x7a/0x110 [snd_pcm_oss]   <e054892e> snd_pcm_oss_write+0x10e/0x1f0 [snd_pcm_oss]
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000]  <c0158f85> vfs_write+0xb5/0x190   <c0159a1b> sys_write+0x4b/0x80
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000]  <c0102e97> syscall_call+0x7/0xb  
> > Apr  4 20:25:51 knautsch kernel: [17180076.984000] Code: b8 c4 09 00 00 e8 db fb e5 df fa 85 c0 0f 85 05 02 00 00 8b 93 98 00 00 00 8b 02 83 f8 02 74 0b 8b 02 83 f8 06 0f 85 da 02 00 00 <8b> 02 83 f8 05 0f 8f ed 01 00 00 83 f8 04 0f 8d 1e 02 00 00 48 
> > 
> > This oops is different from the others in that it contains the 6b6b6b6b
> > magic from slab poisoning. But, again, this is clearly sound related:
> > EIP points to snd_pcm_lib_write, and the trigger procedure was the
> > following:
> > 
> > 1) Use twinke to make a VoIP-Call. Sound was a little bit choppy, so
> > there is already something wrong here. No oops or other error message 
> > yet, though.
> > 
> > 2) From a second xterm, call "yes >/dev/dsp"
> > 
> > This lead to a beeping sound (as expected), so opening the device and
> > sending sound was successful - and to the oops quoted above.
> 
> What happens if you copy the whole subtree linux/sound and
> linux/include/sound from 2.6.16?
> 
> I don't figure out yet what could break except for that typo.

After the sound tree from 2.6.16 did work fine, I used git-bisect to
find the offending commit:

$git-bisect good
3bf75f9b90c981f18f27a0d35a44f488ab68c8ea is first bad commit
diff-tree 3bf75f9b90c981f18f27a0d35a44f488ab68c8ea (from bf1bbb5a49eec51c30d341606885507b501b37e8)
Author: Takashi Iwai <tiwai@suse.de>
Date:   Mon Mar 27 16:40:49 2006 +0200

    [ALSA] Clean up PCM codes (take 2)
    
    - Clean up initialization and destruction of substream instance
      Now snd_pcm_open_substream() alone does most initialization jobs.
      Add pcm_release callback for cleaning up at snd_pcm_release_substream()
    - Tidy up PCM oss code
    
    Signed-off-by: Takashi Iwai <tiwai@suse.de>

:040000 040000 df14b16c98da02d8aea1e5ee18baae5caae6245b a6779060f9e41f5033376735f9b290ba5db98b6e M      include
:040000 040000 7578b410668bcbfc2ed1f3f31011270e6e44f716 c70f96dd906c74d559385ef08ac6e518132936d1 M      sound

...which happens to be the commit which contains the bug you already
mentioned. I wonder if there is a second one hidden somewhere in that
commit, or if git-bisect led me to that bug while the second one is
hidden in a different commit...

Jan

