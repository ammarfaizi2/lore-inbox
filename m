Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbVCJWUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbVCJWUz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbVCJWM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:12:58 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:7828 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262878AbVCJWHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:07:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HbLFIjsHpaOQJ4mdXRVG7ukTynMWzz2TxgO3hhlRap6wmpAYLeF0nDRgPP2amRVmjYsKVmmfXVHUbK9IWWXeJLJ7wYdjdtk6vrhjF4KzhOABdCvqLkK/VPf4LrCFeLQ8zertbyEndZoX3ioK5TuJnrBRqucGPnNrh7A0IbJ7DAE=
Message-ID: <493984f0503101407389b802@mail.gmail.com>
Date: Thu, 10 Mar 2005 23:07:36 +0100
From: Christian Henz <christian.henz@gmail.com>
Reply-To: Christian Henz <christian.henz@gmail.com>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-mm2 + Radeon crash
In-Reply-To: <493984f05031000148904e84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <493984f050309121212541d8@mail.gmail.com>
	 <1110440942.32525.218.camel@gaston>
	 <493984f05031000148904e84@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005 09:14:53 +0100, Christian Henz
<christian.henz@gmail.com> wrote:
> On Thu, 10 Mar 2005 18:49:02 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Wed, 2005-03-09 at 21:12 +0100, Christian Henz wrote:
> [...]
> > > Everything works nicely on 2.6.10 and earlier kernels. I'm in the
> > > process of building 2.6.11.2 to see if the crash occurs there.
> >
> > So ?
> >
> 
> 2.6.11.2 works fine, too. I'll probably try some older versions of the
> -mm tree later today.
> 

I've tried 2.6.11-mm1 and it doesn't reboot, I always (4/4 times I've
tried) get the behaviour I reported before where the video mode is set
and after that the screen just keeps displaying the garbled
framebuffer and nothing happens. The system doesn't hang though, as
I've found out by running "sleep 90; reboot" before starting X - after
the timeout my machine properly shut down. I inserted a "ps ax >
foo.txt" before the "reboot", and it showed that the X server was not
running. Then I found this in /var/log/messages:


Mar 10 22:26:21 homer kernel: [drm] Initialized drm 1.0.0 20040925
Mar 10 22:26:21 homer kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
Mar 10 22:26:21 homer kernel: PCI: setting IRQ 5 as level-triggered
Mar 10 22:26:21 homer kernel: ACPI: PCI interrupt 0000:01:00.0[A] ->
GSI 5 (level, low) -> IRQ 5
Mar 10 22:26:21 homer kernel: [drm] Initialized radeon 1.14.0 20050125
on minor 0: ATI Technologies Inc Radeon R100 QD [Radeon 7200]
Mar 10 22:26:21 homer kernel: agpgart: Found an AGP 2.0 compliant
device at 0000:00:00.0.
Mar 10 22:26:21 homer kernel: agpgart: Putting AGP V2 device at
0000:00:00.0 into 1x mode
Mar 10 22:26:21 homer kernel: agpgart: Putting AGP V2 device at
0000:01:00.0 into 1x mode
Mar 10 22:26:21 homer kernel: 34244c89
Mar 10 22:26:21 homer kernel: PREEMPT
Mar 10 22:26:21 homer kernel: Modules linked in: radeon drm lp autofs4
ipt_limit ipt_state ipt_LOG ipt_REJECT ip_conntrack_irc ip_conntrack
_ftp ip_conntrack iptable_filter ip_tables 8139too via_rhine mii
nls_iso8859_1 nls_cp437 vfat fat floppy parport_pc parport grip
gameport j
oydev psmouse mousedev via_agp agpgart genrtc unix
Mar 10 22:26:21 homer kernel: CPU:    0
Mar 10 22:26:21 homer kernel: EIP:    0060:[<34244c89>]    Not tainted VLI
Mar 10 22:26:21 homer kernel: EFLAGS: 00013296   (2.6.11-mm1)
Mar 10 22:26:21 homer kernel: EIP is at 0x34244c89
Mar 10 22:26:21 homer kernel: eax: dcc9dde8   ebx: dcc9b400   ecx:
0000007b   edx: 00000000
Mar 10 22:26:21 homer kernel: esi: 00000000   edi: 34244c89   ebp:
dcc9deb4   esp: dcc9dde4
Mar 10 22:26:21 homer kernel: ds: 007b   es: 007b   ss: 0068
Mar 10 22:26:21 homer kernel: Process XFree86 (pid: 2008,
threadinfo=dcc9c000 task=de62c080)
Mar 10 22:26:21 homer kernel: Stack: c0103cfb dcc9b400 dea10460
00002710 00000000 00000000 dcc9deb4 e09a0000
Mar 10 22:26:21 homer kernel: 0000007b 0000007b ffffffff e09e5a4b
00000060 00003287 00000040 dcc9b400
Mar 10 22:26:21 homer kernel: dcc9b400 e09e534d dc1db800 dcc9b400
00000000 e09e6340 dc1db800 dcc9b400
Mar 10 22:26:21 homer kernel: Call Trace:
Mar 10 22:26:21 homer kernel: [<c0103cfb>] error_code+0x2b/0x30
Mar 10 22:26:21 homer kernel: [<e09e5a4b>]
radeon_cp_init_ring_buffer+0x14b/0x320 [radeon]
Mar 10 22:26:21 homer kernel: [<e09e534d>]
radeon_cp_load_microcode+0x1d/0x130 [radeon]
Mar 10 22:26:21 homer kernel: [<e09e6340>]
radeon_do_init_cp+0x690/0xc30 [radeon]
Mar 10 22:26:21 homer kernel: [<c0140590>] __alloc_pages+0x300/0x480
Mar 10 22:26:21 homer kernel: [<e09e6da0>] radeon_cp_init+0x0/0xb0 [radeon]
Mar 10 22:26:21 homer kernel: [<e09e6e3a>] radeon_cp_init+0x9a/0xb0 [radeon]
Mar 10 22:26:21 homer kernel: [<c01f8b53>] capable+0x23/0x50
Mar 10 22:26:21 homer kernel: [<e09ff205>] drm_ioctl+0xd5/0x1ae [drm]
Mar 10 22:26:21 homer kernel: [<c016f8ef>] do_ioctl+0x6f/0xa0
Mar 10 22:26:21 homer kernel: [<c016fad5>] vfs_ioctl+0x65/0x1d0
Mar 10 22:26:21 homer kernel: [<c016fca7>] sys_ioctl+0x67/0xc0
Mar 10 22:26:21 homer kernel: [<c010324d>] syscall_call+0x7/0xb
Mar 10 22:26:21 homer kernel: Code:  Bad EIP value.
Mar 10 22:26:21 homer kernel: <3>[drm:drm_release] *ERROR* Device busy: 1 0


tail /var/log/XFree86.0.log.old says: 

(II) RADEON(0): Acceleration enabled
(==) RADEON(0): Backing store disabled
(==) RADEON(0): Silken mouse enabled
(II) RADEON(0): Using hardware cursor (scanline 866)
(II) RADEON(0): Largest offscreen area available: 1152 x 7317
(**) Option "dpms"
(**) RADEON(0): DPMS enabled
(II) RADEON(0): X context handle = 0x00000001
(II) RADEON(0): [drm] installed DRM signal handler
(II) RADEON(0): [DRI] installation complete



cheers,
Christian
 
PS: If you reply, please CC me as I'm not subscribed.
