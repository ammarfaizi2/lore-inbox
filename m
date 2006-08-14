Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWHNVNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWHNVNQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbWHNVNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:13:16 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:21891 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932416AbWHNVNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:13:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GlH9iZ/6easCV8C0nC/kuUIPlSwAEB7gI8IYvTqzsxCGojSryBGAacL60aZH782GIFz4jUVg7f3LS53La4tSz23xe0D/65S30t1n4XG+7t6Zkfq3iFT6vpa7YcwghwRwUza41sYjR8mt63c3cSr/KTrt9fNLGgdKFgIiuscEmB0=
Message-ID: <6bffcb0e0608141413u122c2a31scb3e170a776cec2b@mail.gmail.com>
Date: Mon, 14 Aug 2006 23:13:14 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Dave Jones" <davej@redhat.com>,
       "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       "john stultz" <johnstul@us.ibm.com>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>,
       "Ingo Molnar" <mingo@elte.hu>, "Dinakar Guniguntala" <dino@in.ibm.com>
Subject: Re: 2.6.18-rc4-mm1
In-Reply-To: <20060814205637.GA30814@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060813012454.f1d52189.akpm@osdl.org>
	 <6bffcb0e0608140702i70fb82ffr99a3ad6fdfbfd55e@mail.gmail.com>
	 <20060814111914.b50f9b30.akpm@osdl.org> <44E0C889.3020706@gmail.com>
	 <1155583256.5413.42.camel@localhost.localdomain>
	 <6bffcb0e0608141227i2c4c48b6w8e18165ac406862@mail.gmail.com>
	 <1155584697.5413.51.camel@localhost.localdomain>
	 <44E0E1BA.3000204@gmail.com> <20060814205637.GA30814@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/06, Dave Jones <davej@redhat.com> wrote:
> On Mon, Aug 14, 2006 at 10:48:58PM +0200, Michal Piotrowski wrote:
>  >
>  > Hmmm... It looks a bit different without futex_handle_fault-always-fails.patch
>  >
>  > Aug 14 22:30:09 ltg01-fedora kernel: general protection fault: 0000 [#1]
>  > Aug 14 22:30:09 ltg01-fedora kernel: 4K_STACKS PREEMPT SMP
>  > Aug 14 22:30:09 ltg01-fedora kernel: last sysfs file: /devices/platform/i2c-9191/9191-0290/temp2_input
>  > Aug 14 22:30:09 ltg01-fedora kernel: Modules linked in: ipv6 w83627hf hwmon_vid hwmon i2c_isa af_packet ip_conntrack_netbios
>  > _ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp iptable_filter ip_tables x_tables cpufreq_userspace p4_clockmod spe
>  > edstep_lib binfmt_misc thermal processor fan container evdev snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_
>  > oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm sk98lin skge snd_timer snd soundcore snd_pag
>  > e_alloc ide_cd i2c_i801 intel_agp agpgart cdrom rtc unix
>  > Aug 14 22:30:09 ltg01-fedora kernel: CPU:    0
>  > Aug 14 22:30:09 ltg01-fedora kernel: EIP:    0060:[<c0205249>]    Not tainted VLI
>  > Aug 14 22:30:09 ltg01-fedora kernel: EFLAGS: 00010246   (2.6.18-rc4-mm1 #101)
>  > Aug 14 22:30:09 ltg01-fedora kernel: EIP is at __list_add+0x3d/0x7a
>
>  ...
>
>  > 0xc0205249 is in __list_add (/usr/src/linux-mm/lib/list_debug.c:28).
>  > 23              if (unlikely(next->prev != prev)) {
>  > 24                      printk("list_add corruption. next->prev should be %p, but was %p\n",
>  > 25                              prev, next->prev);
>  > 26                      BUG();
>  > 27              }
>  > 28              if (unlikely(prev->next != next)) {
>  > 29                      printk("list_add corruption. prev->next should be %p, but was %p\n",
>  > 30                              next, prev->next);
>  > 31                      BUG();
>  > 32              }
>  >
>  > I'll revert debug-variants-of-linked-list-macros.patch
>
> __list_add will still be dereferencing prev->next, so you should see exactly
> the same gpf. Note that you're not triggering the BUG()'s here, you're hitting
> some other fault just walking the list.

How can I debug this?

>
>                 Dave
>
> --
> http://www.codemonkey.org.uk
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
