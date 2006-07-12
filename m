Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWGLLfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWGLLfw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 07:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWGLLfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 07:35:52 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:8789 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751276AbWGLLfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 07:35:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uJYerZsBc/FjMiagID5p42sJt94WtLu1at0CbviWrCcUJ6akcMjzt8qgGKM3iAHo0RZjPIn34yA6mSsdRYyL/j/MahpmAToD0ErE0dr3cVagmrKE1iMIy6v58atoiw6HZ98gHydS0KLKYKzoj215Zj5eZIY2AzkGFHivuO1en7k=
Message-ID: <6bffcb0e0607120435x31eceab7r3fdb055a7bee6da2@mail.gmail.com>
Date: Wed, 12 Jul 2006 13:35:50 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0607111454l1f9919eahbb3b683492a651e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <b0943d9e0607110628w60a436f7t449714eb4a3200ca@mail.gmail.com>
	 <6bffcb0e0607110649s464840a9sf04c7537809436b1@mail.gmail.com>
	 <b0943d9e0607110702p60f5bf3fg910304bfe06ec168@mail.gmail.com>
	 <6bffcb0e0607110802w4f423854rb340227331084596@mail.gmail.com>
	 <b0943d9e0607110844m6278da6crdc03bccce420da1d@mail.gmail.com>
	 <6bffcb0e0607110902u4e24a4f2jc6acf2eb4c3bae93@mail.gmail.com>
	 <b0943d9e0607110931n4ce1c569x83aa134e2889926c@mail.gmail.com>
	 <6bffcb0e0607111000q228673a9kcbc6c91f76331885@mail.gmail.com>
	 <b0943d9e0607111454l1f9919eahbb3b683492a651e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 11/07/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> Michal,
>
> On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > On 11/07/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > > It looks like there are some reports in __alloc_skb. Please try the
> > > attached patch.
> >
> > Here is the result
> > http://www.stardust.webpages.pl/files/o_bugs/kml/ml4.txt
>
> Some of the __alloc_skb disappeared but there are still a lot of
> context_struct_to_string (812). Could you let it running for a bit to
> get more reported leaks (few thousands) and send me the contents of
> the /proc/slabinfo file (together with the memleak file)? I want to
> make sure whether it is a kmemleak problem or not.

Ok.

BTW I have _very_ annoying soft lockup. Can you fix that?

Jul 12 13:15:47 ltg01-fedora kernel: printk: 1527 messages suppressed.
Jul 12 13:15:47 ltg01-fedora kernel: ipt_hook: happy cracking.
Jul 12 13:15:56 ltg01-fedora kernel: printk: 1631 messages suppressed.
Jul 12 13:15:56 ltg01-fedora kernel: Neighbour table overflow.

I don't know why, but clock goes mad.

Jul 12 14:08:21 ltg01-fedora kernel: BUG: soft lockup detected on CPU#0!
Jul 12 14:08:19 ltg01-fedora kernel:  [<c0106e09>] show_trace_log_lvl+0x54/0xff
Jul 12 14:08:20 ltg01-fedora kernel:  [<c0106ec1>] show_trace+0xd/0xf
Jul 12 14:08:19 ltg01-fedora kernel:  [<c0106f93>] dump_stack+0x17/0x19
Jul 12 14:08:21 ltg01-fedora kernel:  [<c0156793>] softlockup_tick+0x9a/0xae
Jul 12 14:08:21 ltg01-fedora kernel:  [<c01332ce>] run_local_timers+0x12/0x14
Jul 12 14:08:21 ltg01-fedora kernel:  [<c0133126>]
update_process_times+0x40/0x65
Jul 12 14:08:20 ltg01-fedora kernel:  [<c011a100>]
smp_apic_timer_interrupt+0x64/0x6c
Jul 12 14:08:21 ltg01-fedora kernel:  [<c0106a1e>]
apic_timer_interrupt+0x2a/0x30
Jul 12 14:08:18 ltg01-fedora kernel:  [<c0116b71>] smp_call_function+0xcc/0xf9
Jul 12 14:08:20 ltg01-fedora kernel:  [<c012f6b6>] on_each_cpu+0x24/0x5e
Jul 12 14:08:21 ltg01-fedora kernel:  [<c017a63f>] invalidate_bh_lrus+0x16/0x18
Jul 12 14:08:21 ltg01-fedora kernel:  [<c017978c>] invalidate_bdev+0xb/0x1c
Jul 12 14:08:19 ltg01-fedora smartd[1736]: Device: /dev/hda, 1 Offline
uncorrectable sectors
Jul 12 14:08:21 ltg01-fedora kernel:  [<c017e81d>] kill_bdev+0x10/0x25
Jul 12 14:08:20 ltg01-fedora kernel:  [<c017fa7f>] __blkdev_put+0x43/0x157
Jul 12 14:08:21 ltg01-fedora kernel:  [<c017fb9d>] blkdev_put+0xa/0xc
Jul 12 14:08:20 ltg01-fedora kernel:  [<c017fbd6>] blkdev_close+0x28/0x2b
Jul 12 14:08:20 ltg01-fedora kernel:  [<c0178e20>] __fput+0xb2/0x18c
Jul 12 14:08:20 ltg01-fedora kernel:  [<c0178d6c>] fput+0x17/0x19
Jul 12 14:08:20 ltg01-fedora kernel:  [<c01778c5>] filp_close+0x4e/0x58
Jul 12 14:08:22 ltg01-fedora kernel:  [<c0177931>] sys_close+0x62/0x7a
Jul 12 14:08:21 ltg01-fedora kernel:  [<c0105ef1>] sysenter_past_esp+0x56/0x8d
Jul 12 14:08:22 ltg01-fedora kernel:  [<b7fc1410>] 0xb7fc1410
Jul 12 14:08:22 ltg01-fedora kernel: BUG: soft lockup detected on CPU#1!
Jul 12 14:08:21 ltg01-fedora kernel:  [<c0106e09>] show_trace_log_lvl+0x54/0xff
Jul 12 14:08:21 ltg01-fedora kernel:  [<c0106ec1>] show_trace+0xd/0xf
Jul 12 14:08:21 ltg01-fedora kernel:  [<c0106f93>] dump_stack+0x17/0x19
Jul 12 14:08:21 ltg01-fedora kernel:  [<c0156793>] softlockup_tick+0x9a/0xae
Jul 12 14:08:20 ltg01-fedora kernel:  [<c01332ce>] run_local_timers+0x12/0x14
Jul 12 14:08:20 ltg01-fedora kernel:  [<c0133126>]
update_process_times+0x40/0x65
Jul 12 14:08:20 ltg01-fedora kernel:  [<c011a100>]
smp_apic_timer_interrupt+0x64/0x6c
Jul 12 14:08:22 ltg01-fedora kernel:  [<c0106a1e>]
apic_timer_interrupt+0x2a/0x30
Jul 12 14:08:20 ltg01-fedora kernel:  [<c02f3dd1>] _spin_unlock_irq+0x28/0x43
Jul 12 14:08:20 ltg01-fedora kernel:  [<c012dcb2>] do_setitimer+0x145/0x4ce
Jul 12 14:08:20 ltg01-fedora kernel:  [<c012e070>] alarm_setitimer+0x35/0x54
Jul 12 14:08:22 ltg01-fedora kernel:  [<c0133371>] sys_alarm+0xb/0xd
Jul 12 14:08:21 ltg01-fedora kernel:  [<c0105ef1>] sysenter_past_esp+0x56/0x8d
Jul 12 14:08:21 ltg01-fedora kernel:  [<b7f83410>] 0xb7f83410
Jul 12 14:08:21 ltg01-fedora kernel: printk: 309 messages suppressed.
Jul 12 14:08:22 ltg01-fedora kernel: ipt_hook: happy cracking.

Here is actual config file
http://www.stardust.webpages.pl/files/o_bugs/kml/kml-config5

>
> Thanks.
>
> --
> Catalin
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
