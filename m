Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWE3W7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWE3W7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 18:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWE3W7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 18:59:34 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:58833 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964799AbWE3W7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 18:59:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A+lgiCEJnuNAZXFZRfEvzq3Sg4unVSa33VdWKUMFC9g9pJGE6rZsw1bGwXU2DXSeMUyKVwQNtD7+dBOJvnWhbzLaKGK8Ab753EmMlrv/aKByB+H0xIXKRg/TdaaAYT1dkShcoo7rer9RgMVIsHMiMfeYph0l9x9qbPcowaKDZyU=
Message-ID: <6bffcb0e0605301559y603a60bl685b7aca60069dfd@mail.gmail.com>
Date: Wed, 31 May 2006 00:59:32 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm1
Cc: "Arjan van de Ven" <arjan@linux.intel.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20060530220931.GA32759@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com>
	 <6bffcb0e0605301157o6b7c5f66q3c9f151cbb4537d5@mail.gmail.com>
	 <20060530194259.GB22742@elte.hu>
	 <6bffcb0e0605301457v9ba284bk75b8b6d14384489a@mail.gmail.com>
	 <20060530220931.GA32759@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> > >  http://redhat.com/~mingo/lockdep-patches/latency-tracing-lockdep.patch
> > >
> > >just apply it ontop of your current tree and accept all the new .config
> > >options as the kernel suggests them to you.
> >
> > I can't boot with that patch. I even don't see "Uncompressing
> > Linux..." - machine reboots.
> > I have 2.6.17-rc5-mm1 +
> > genirq-cleanup-remove-irq_descp-fix.patch
> > lock-validator-irqtrace-support-non-x86-architectures.patch
> > lock-validator-special-locking-sb-s_umount-2-fix.patch
> > from hot fixes
> > +
> > Arjan's net/ipv4/igmp.c patch.
>
> could you try to 1) disable PREEMPT, 2) apply the -V2 rollup of all
> fixes so far to 2.6.17-rc5-mm1:
>
>  http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm1.patch

I'll try to reproduce that bug now... but here is new one :)

BUG: key f7155db0 not in .data!
(        modprobe-485  |#0): new 15286092 us user-latency.
stopped custom tracer.
BUG: warning at /usr/src/linux-mm/kernel/lockdep.c:1985/lockdep_init_map()
 [<c0104208>] show_trace+0x1b/0x20
 [<c01042e6>] dump_stack+0x1f/0x24
 [<c0136e26>] lockdep_init_map+0x65/0xb0
 [<c0134a62>] __mutex_init+0x46/0x50
 [<f98b72a3>] find_driver+0xb7/0x115 [snd_seq_device]
 [<f98b776f>] snd_seq_device_register_driver+0x42/0xeb [snd_seq_device]
 [<f887012d>] alsa_seq_oss_init+0x12d/0x158 [snd_seq_oss]
 [<c013fdad>] sys_init_module+0x96/0x1d4
 [<c02eb442>] sysenter_past_esp+0x63/0xa1
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

Here is dmesg
http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/mm-dmesg3

Here is new config (without some debugging options)
http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/mm-config4

>
> ? I'll try your config meanwhile.
>
>         Ingo
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
