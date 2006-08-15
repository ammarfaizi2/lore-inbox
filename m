Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWHOPhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWHOPhj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWHOPhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:37:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:7203 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030354AbWHOPhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:37:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=BxD9UjIz2j4GKmGm8B+g9Yzvuc3K6Zs9MusT4yjhCgAi96C0COylZuLV4ZrHFZ2+Jptn7DqWB/gsGI07i9XLdUiD+6BsQMiZMqQI5CZCQOy0Y6ik8RXXQPKrRl3cgFqh82gFrwLutupZ7jiZy1AFsm81d0/eMS/HXLBNsOMGICM=
Date: Tue, 15 Aug 2006 17:37:26 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, airlied@linux.ie,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>
Subject: Re: 2.6.18-rc4-mm1 BUG, drm related
Message-ID: <20060815173726.GA2533@slug>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060815130345.GA3817@slug> <20060815071632.b10d3a03.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815071632.b10d3a03.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 07:16:32AM -0700, Andrew Morton wrote:
> On Tue, 15 Aug 2006 13:25:56 +0000
> Frederik Deweerdt <deweerdt@free.fr> wrote:
> 
> > On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> > > 
> > Hi,
> > 
> > There are two BUGs with 2.6.18-rc4-mm1 that seem related to (I did the
> > bisection[1]):
> > git-drm.patch
> > drm-build-fix.patch
> > drm-build-fixes-2.patch
> > allow-drm-detection-of-new-via-chipsets.patch
> > git-drm-build-fix.patch
> > 
> > Here's one of the BUGs (the second one is on the web site below).
> > [   40.276000] [drm:drm_unlock] *ERROR* Process 8914 using kernel context 0
> 
> I guess the above is a non-fatal DRM warning.
> 
> The below is an ALSA oops.
Hmm, that's what I thought at first, but consider the second BUG (as I
said, both BUGs, the ALSA one and that one appear alternatively):
[   35.600000] [drm:drm_unlock] *ERROR* Process 8835 using kernel context 0
[   36.328000] BUG: unable to handle kernel paging request at virtual address 746c6139
[   36.328000]  printing eip:
[   36.328000] c01fcf39
[   36.328000] *pde = 00000000
[   36.328000] Oops: 0000 [#1]
[   36.328000] PREEMPT 
[   36.328000] last sysfs file: /devices/pci0000:00/0000:00:1d.7/usb5/5-0:1.0/bInterfaceProtocol
[   36.328000] Modules linked in: snd_seq snd_seq_device ohci_hcd parport_pc parport pcspkr ipw2200 yenta_socket rsrc_nonstatic pcmcia_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd uhci_hcd usbcore cpufreq_stats cpufreq_powersave cpufreq_ondemand cpufreq_conservative speedstep_centrino freq_table processor ac battery i915 drm tg3 tsdev joydev
[   36.328000] CPU:    0
[   36.328000] EIP:    0060:[<c01fcf39>]    Not tainted VLI
[   36.328000] EFLAGS: 00010297   (2.6.18-rc4-def01 #12) 
[   36.328000] EIP is at vsnprintf+0x2da/0x4f9
[   36.328000] eax: 746c6139   ebx: 0000000a   ecx: 746c6139   edx: fffffffe
[   36.328000] esi: f75fa28c   edi: 00000000   ebp: f3701ebc   esp: f3701e80
[   36.328000] ds: 007b   es: 007b   ss: 0068
[   36.328000] Process modprobe (pid: 8872, ti=f3700000 task=f7189540 task.ti=f3700000)
[   36.328000] Stack: f75fa283 f75fb000 00000002 00000000 0000000a fffffffb 00000000 00000000 
[   36.328000]        ffffffff ffffffff ffffffff f75fb000 f7129240 f8a1f980 f7129240 f3701ed8 
[   36.328000]        c01948a4 f75fa28c 00000d74 c039b84c f3701eec c039ad97 f3701efc c013fd08 
[   36.328000] Call Trace:
[   36.328000]  [<c01948a4>] seq_printf+0x32/0x55
[   36.328000]  [<c013fd08>] print_unload_info+0x6f/0xe9
[   36.328000]  [<c0142073>] m_show+0x4b/0xb5
[   36.328000]  [<c019440f>] seq_read+0x248/0x2ee
[   36.328000]  [<c0171bef>] vfs_read+0x1c1/0x1c6
[   36.328000]  [<c0171f0a>] sys_read+0x4b/0x75
[   36.328000]  [<c0103139>] sysenter_past_esp+0x56/0x8d
[   36.328000]  [<b7fb7410>] 0xb7fb7410
[   36.328000]  [<c0104205>] show_stack_log_lvl+0x98/0xb2
[   36.328000]  [<c0104434>] show_registers+0x1b7/0x22f
[   36.328000]  [<c010460a>] die+0x11e/0x226
[   36.328000]  [<c0379dc2>] do_page_fault+0x38c/0x616
[   36.328000]  [<c0103cad>] error_code+0x39/0x40
[   36.328000]  [<c01948a4>] seq_printf+0x32/0x55
[   36.328000]  [<c013fd08>] print_unload_info+0x6f/0xe9
[   36.328000]  [<c0142073>] m_show+0x4b/0xb5
[   36.328000]  [<c019440f>] seq_read+0x248/0x2ee
[   36.328000]  [<c0171bef>] vfs_read+0x1c1/0x1c6
[   36.328000]  [<c0171f0a>] sys_read+0x4b/0x75
[   36.328000]  [<c0103139>] sysenter_past_esp+0x56/0x8d
[   36.328000] Code: fd ff ff 83 cf 40 bb 10 00 00 00 eb 88 8b 45 14 83 45 14 04 8b 55 e8 8b 08 b8 e4 81 3a c0 81 f9 ff 0f 00 00 0f 46 c8 89 c8 eb 06 <80> 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 0f 85 
[   36.328000] EIP: [<c01fcf39>] vsnprintf+0x2da/0x4f9 SS:ESP 0068:f3701e80

Please notice how the BUG comes right after the drm warning.

Regards,
Frederik
