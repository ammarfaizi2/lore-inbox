Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbVKPQdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbVKPQdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 11:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbVKPQdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 11:33:38 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:41435 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030400AbVKPQdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 11:33:37 -0500
Subject: Re: Linuv 2.6.15-rc1
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Cc: Zhu Yi <yi.zhu@intel.com>, Andrew Morton <akpm@osdl.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jketreno@linux.intel.com
In-Reply-To: <20051116131505.GD31362@gemtek.lt>
References: <4378980C.7060901@ens-lyon.fr>
	 <20051114162942.5b163558.akpm@osdl.org> <20051115100519.GA5567@gemtek.lt>
	 <20051115115657.GA30489@gemtek.lt>
	 <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com>
	 <20051115140023.GB9910@gemtek.lt>
	 <1132120145.18679.12.camel@debian.sh.intel.com>
	 <20051116094551.GA23140@gemtek.lt> <20051116114052.GA14042@gemtek.lt>
	 <Pine.LNX.4.58.0511161415010.4402@sbz-30.cs.Helsinki.FI>
	 <20051116131505.GD31362@gemtek.lt>
Date: Wed, 16 Nov 2005 18:33:32 +0200
Message-Id: <1132158813.8902.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zilvinas,

On Wed, 2005-11-16 at 15:15 +0200, Zilvinas Valinskas wrote:
> Also this time I saw f/w loading problem and as a result, oops:
> http://www.gemtek.lt/~zilvinas/dumps/trace.4. 
> 
> F/W load has failed as a result followed oops in yenta driver +
> slabcorruption ... Rebooted several times, no f/w loading problems and
> now I am running 2.6.15-rc1 in runlevel 2 (X started & services ...).

The oops is not in yenta but most likely in the release() function of
fs/sysfs/bin.c and related to ipw firmware loading. The function is
touching already freed memory. As I am mostly clueless of sysfs and
hotplug, perhaps someone can give us a hint?

The oops from Zilvinas logs is the following:

Unable to handle kernel paging request at virtual address 6b6b6c6b
 printing eip:
c0181cec
*pde = 00000000
Oops: 0002 [#1]
DEBUG_PAGEALLOC
Modules linked in: ehci_hcd yenta_socket rsrc_nonstatic pcmcia_core ohci_hcd snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss irtty_sir snd_pcm snd_timer sir_dev ipw2200 irda snd soundcore ieee80211 ieee80211_crypt crc_ccitt snd_page_alloc floppy firmware_class 8250_pnp intel_agp agpgart pcspkr 8250 serial_core ide_cd cdrom
CPU:    0
EIP:    0060:[<c0181cec>]    Not tainted VLI
EFLAGS: 00010202   (2.6.15-rc1) 
EIP is at release+0x2a/0x4f
eax: 6b6b6b6b   ebx: ddb23f00   ecx: 1dcde000   edx: 00000001
esi: dd900ddc   edi: deff2000   ebp: deb0bf74   esp: deb5ff74
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 1926, threadinfo=deb5f000 task=dd845b10)
Stack: 00000008 de36bfd4 ddb54eb4 c0149a4d 00000000 de36bf70 c14d9e38 ddb54eb4 
       deb0bf74 00000000 df8d2e48 deb5f000 c01484ef 00000001 00000001 b7f275c0 
       ffffffff c0102bd3 00000001 00000000 b7f26ff4 b7f275c0 ffffffff bfe649e8 
Call Trace:
 [<c0149a4d>] __fput+0xa0/0x14f
 [<c01484ef>] filp_close+0x3e/0x62
 [<c0102bd3>] sysenter_past_esp+0x54/0x75
Code: e8 57 56 53 8b 4a 08 8b 41 14 8b 40 50 8b 58 14 8b 41 50 8b 70 14 8b 7a 74 85 db 74 07 89 d8 e8 26 4b 0a 00 8b 46 04 85 c0 74 0b <ff> 88 00 01 00 00 83 38 02 74 0d 89 f8 e8 7e 4e fb ff 31 c0 5b 

			Pekka

