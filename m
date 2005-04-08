Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262713AbVDHHBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbVDHHBe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 03:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVDHHBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:01:34 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:10041 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262713AbVDHHAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:00:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=LEF5uhuHcsC9jOo4L2VFV2kmpa5UcKMaUopqAOgccEIQC84qOzldMnb/qQZ+86/15Sd2KFgtWbvygnNqtwNRFMMkrdOXS2Ewn+j0YZ5hq2NAHNKBCUWY66WhUYYd2/AClkoRXYhfnJzpLr12UrgofhDQRYVb+Vl3RZq19+c6RTk=
Message-ID: <54b5dbf5050408000016e02601@mail.gmail.com>
Date: Fri, 8 Apr 2005 12:30:42 +0530
From: AsterixTheGaul <asterixthegaul@gmail.com>
Reply-To: AsterixTheGaul <asterixthegaul@gmail.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: Linux 2.6.12-rc2
Cc: Moritz Muehlenhoff <jmm@inutil.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <54b5dbf505040723392f29b18c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
	 <E1DJE6t-0001T5-UD@localhost.localdomain>
	 <1112827342.9567.189.camel@gaston>
	 <20050407175026.GA5872@informatik.uni-bremen.de>
	 <29495f1d05040711544695ce89@mail.gmail.com>
	 <54b5dbf5050407232810f7a20d@mail.gmail.com>
	 <54b5dbf505040723392f29b18c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok this time I did with radeontool and it works good :)) (2.6.12-rc2 on T41).

1. I have "radeontool regs" before susp to ram (presusp)
2. turn off LCD with "radeontool light off"
3. Suspend to RAM and wake up. (same backtrace)
4. LCD is back on (no problem)
5. regs in postsusp

only diff is 

< RADEON_CRTC_GEN_CNTL=03200600
---
> RADEON_CRTC_GEN_CNTL=03000600


presusp
---------------
RADEON_DAC_CNTL=ff002102
RADEON_DAC_CNTL2=00000000
RADEON_TV_DAC_CNTL=07680142
RADEON_DISP_OUTPUT_CNTL=10000002
RADEON_CONFIG_MEMSIZE=02000000
RADEON_AUX_SC_CNTL=00000000
RADEON_CRTC_EXT_CNTL=00008048
RADEON_CRTC_GEN_CNTL=03200600
RADEON_CRTC2_GEN_CNTL=00800000
RADEON_DEVICE_ID=00004c66
RADEON_DISP_MISC_CNTL=5b300600
RADEON_GPIO_MONID=00000000
RADEON_GPIO_MONIDB=00000300
RADEON_GPIO_CRT2_DDC=00000300
RADEON_GPIO_DVI_DDC=00130000
RADEON_GPIO_VGA_DDC=00030000
RADEON_LVDS_GEN_CNTL=003dffa1

postsusp
---------------
RADEON_DAC_CNTL=ff002102
RADEON_DAC_CNTL2=00000000
RADEON_TV_DAC_CNTL=07680142
RADEON_DISP_OUTPUT_CNTL=10000002
RADEON_CONFIG_MEMSIZE=02000000
RADEON_AUX_SC_CNTL=00000000
RADEON_CRTC_EXT_CNTL=00008048
RADEON_CRTC_GEN_CNTL=03000600
RADEON_CRTC2_GEN_CNTL=00800000
RADEON_DEVICE_ID=00004c66
RADEON_DISP_MISC_CNTL=5b300600
RADEON_GPIO_MONID=00000000
RADEON_GPIO_MONIDB=00000300
RADEON_GPIO_CRT2_DDC=00000300
RADEON_GPIO_DVI_DDC=00130000
RADEON_GPIO_VGA_DDC=00030000
RADEON_LVDS_GEN_CNTL=003dffa1


On Apr 8, 2005 12:09 PM, AsterixTheGaul <asterixthegaul@gmail.com> wrote:
> Err... never mind... I was not doing any radeon control.
> 
> On Apr 8, 2005 11:58 AM, AsterixTheGaul <asterixthegaul@gmail.com> wrote:
> > > FWIW, I have the same problem on a T41p with 2.6.11 and 2.6.12-rc2,
> > > except that neither returns from suspend-to-ram with video restored on
> > > the LCD. I believe I was able to get video restored on an external CRT
> > > in either 2.6.12-rc2 or 2.6.12-rc2-mm1, but the LCD still didn't
> > > restore (can verify later today, if you'd like). I had dumped out the
> > > radeontool regs values before & after the sleep, in case they help.
> > > They are attached.
> >
> > Hmm... I have 2.6.12-rc2 on a T41 and "suspend to ram" works good (well
> > except for a backtrace complaining about __might_sleep but otherwise ok).
> >
> > Apr  7 23:17:10 localhost kernel: Debug: sleeping function called from
> > invalid context at mm/slab.c:2090
> > Apr  7 23:17:10 localhost kernel: in_atomic():0, irqs_disabled():1
> > Apr  7 23:17:10 localhost kernel:  [<c011d9e3>] __might_sleep+0xa3/0xc0
> > Apr  7 23:17:10 localhost kernel:  [<c015beb0>] kmem_cache_alloc+0x50/0x60
> > Apr  7 23:17:10 localhost kernel:  [<c0269750>] acpi_pci_link_set+0x4a/0x1a2
> > Apr  7 23:17:10 localhost kernel:  [<c0269bc9>] irqrouter_resume+0x1c/0x24
> > Apr  7 23:17:10 localhost kernel:  [<c02b70f6>] sysdev_resume+0x66/0xc4
> > Apr  7 23:17:10 localhost kernel:  [<c02bbcc5>] device_power_up+0x5/0xa
> > Apr  7 23:17:10 localhost kernel:  [<c014a426>] suspend_enter+0x36/0x60
> > Apr  7 23:17:10 localhost kernel:  [<c014a3a3>] suspend_prepare+0x63/0xb0
> > Apr  7 23:17:10 localhost kernel:  [<c014a4ec>] enter_state+0x5c/0x70
> > Apr  7 23:17:10 localhost kernel:  [<c014a639>] state_store+0xa9/0xbc
> > Apr  7 23:17:10 localhost kernel:  [<c014a590>] state_store+0x0/0xbc
> > Apr  7 23:17:10 localhost kernel:  [<c01d27c6>] subsys_attr_store+0x36/0x50
> > Apr  7 23:17:10 localhost kernel:  [<c01d2a6e>] flush_write_buffer+0x2e/0x40
> > Apr  7 23:17:10 localhost kernel:  [<c01d2ace>] sysfs_write_file+0x4e/0x80
> > Apr  7 23:17:10 localhost kernel:  [<c017bdee>] vfs_write+0x12e/0x130
> > Apr  7 23:17:10 localhost kernel:  [<c017bea1>] sys_write+0x41/0x70
> > Apr  7 23:17:10 localhost kernel:  [<c01039ff>] sysenter_past_esp+0x54/0x75
> >
> >
> > >
> > > I posted these problems in the "Call for help S3" thread, but no one responded.
> > >
> > > Thanks,
> > > Nish
> > >
> > >
> > >
> >
>
