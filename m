Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264819AbUGSIXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbUGSIXD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 04:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264826AbUGSIXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 04:23:03 -0400
Received: from mail.eris.qinetiq.com ([128.98.1.1]:63145 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S264819AbUGSIW4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 04:22:56 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: Kernel oops while shutting down (2.6.8rc1)
Date: Mon, 19 Jul 2004 09:18:03 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200407161011.36677.m.watts@eris.qinetiq.com> <Pine.LNX.4.58.0407161331090.26950@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0407161331090.26950@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407190918.04053.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> On Fri, 16 Jul 2004, Mark Watts wrote:
> > Unable to handle kernel paging requested:
> > at virtual address d0967287
> > printing eip:
> > *pde = 0fe43067
> > *pte = 00000000
> > Oops: 0000 [#1]
> > PREEMPT
> > Modules linked in: sg st sr_mod sd_mod scsi_mod ide_cd cdrom i830 ipv6
> > i810_audio ac97_codec soundcore af_packet usbhid floppy airo_cs ds airo
> > pcmcia_core d
> > CPU:    0
> > EIP:    0060:[<d0967287>]    Not tainted
> > EFLAGS: 00010296   (2.6.8-rc1)
> > EIP is at 0xd0967287
> > eax: 00000000   ebx: 00375140   ecx: 00000008   edx: 00000001
> > esi: c1265cf8   edi: 00374366   ebp: c1265c00   esp: c03adfb4
> > ds: 007b   es: 007b   ss: 0068
> > Process swapper (pid: 0, threadinfo=c03ac000 task=c032ca40)
> > Stack: 00425007 d0967167 0000007b c03a007b 00000000 c03ac000 0009fb00
> > c03da120 00425007 c01040dd 00000006 c03ae7cf c032ca40 00000000 c03d3774
> > 00000018 c03ae380 c03db580 c010019f
> > Call Trace:
> >  [<c01040dd>] cpu_idle+0x2d/0x40
> >  [<c03ae7cf>] start_kernel+0x18f/0x1d0
> >  [<c03ae380>] unknown_bootoption+0x0/0x170
> > Code:  Bad EIP value.
> > <0>Kernel panic: Attempted to kill the idle task!
> > In idle task - not syncing
>
> One of those driver modules probably has a function in the cleanup routine
> path unloaded/unmapped. Doing a cat /proc/modules before shutting down and
> taking copying the output would help speed up the search.

$ /sbin/lsmod
Module                  Size  Used by
sg                     39648  0
st                     41276  0
sr_mod                 18788  0
sd_mod                 22144  0
scsi_mod              119372  4 sg,st,sr_mod,sd_mod
ide_cd                 41984  0
cdrom                  40252  2 sr_mod,ide_cd
i830                   78724  3
ipv6                  266692  16
i810_audio             34132  1
ac97_codec             18828  1 i810_audio
soundcore              10272  2 i810_audio
af_packet              22696  0
usbhid                 45216  0
floppy                 60816  0
thermal                12264  0
processor              17032  1 thermal
fan                     3940  0
button                  6224  0
battery                 8836  0
ac                      4708  0
airo_cs                 7812  0
ds                     18948  3 airo_cs
airo                   75320  1 airo_cs
3c59x                  38280  0
yenta_socket           21728  0
pcmcia_core            64428  3 airo_cs,ds,yenta_socket
intel_agp              19804  1
agpgart                34440  4 intel_agp
uhci_hcd               32592  0
usbcore               116704  4 usbhid,uhci_hcd
rtc                    12760  0
ext3                  123688  2
jbd                    61368  1 ext3



- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA+4O8Bn4EFUVUIO0RAvjMAJ4uOa+j59soc7ksu8qimNVFKEFCdACfZFMm
AJMrFXQMS7ORTRi7Cf0Taq0=
=P0Mv
-----END PGP SIGNATURE-----
