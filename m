Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUGSI1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUGSI1c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 04:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUGSI1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 04:27:32 -0400
Received: from mail.eris.qinetiq.com ([128.98.1.1]:52817 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S264795AbUGSI10 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 04:27:26 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel oops while shutting down (2.6.8rc1)
Date: Mon, 19 Jul 2004 09:22:34 +0100
User-Agent: KMail/1.6.1
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>
References: <200407161011.36677.m.watts@eris.qinetiq.com> <Pine.LNX.4.58.0407161331090.26950@montezuma.fsmlabs.com> <200407190918.04053.m.watts@eris.qinetiq.com>
In-Reply-To: <200407190918.04053.m.watts@eris.qinetiq.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407190922.34480.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> > On Fri, 16 Jul 2004, Mark Watts wrote:
> > > Unable to handle kernel paging requested:
> > > at virtual address d0967287
> > > printing eip:
> > > *pde = 0fe43067
> > > *pte = 00000000
> > > Oops: 0000 [#1]
> > > PREEMPT
> > > Modules linked in: sg st sr_mod sd_mod scsi_mod ide_cd cdrom i830 ipv6
> > > i810_audio ac97_codec soundcore af_packet usbhid floppy airo_cs ds airo
> > > pcmcia_core d
> > > CPU:    0
> > > EIP:    0060:[<d0967287>]    Not tainted
> > > EFLAGS: 00010296   (2.6.8-rc1)
> > > EIP is at 0xd0967287
> > > eax: 00000000   ebx: 00375140   ecx: 00000008   edx: 00000001
> > > esi: c1265cf8   edi: 00374366   ebp: c1265c00   esp: c03adfb4
> > > ds: 007b   es: 007b   ss: 0068
> > > Process swapper (pid: 0, threadinfo=c03ac000 task=c032ca40)
> > > Stack: 00425007 d0967167 0000007b c03a007b 00000000 c03ac000 0009fb00
> > > c03da120 00425007 c01040dd 00000006 c03ae7cf c032ca40 00000000 c03d3774
> > > 00000018 c03ae380 c03db580 c010019f
> > > Call Trace:
> > >  [<c01040dd>] cpu_idle+0x2d/0x40
> > >  [<c03ae7cf>] start_kernel+0x18f/0x1d0
> > >  [<c03ae380>] unknown_bootoption+0x0/0x170
> > > Code:  Bad EIP value.
> > > <0>Kernel panic: Attempted to kill the idle task!
> > > In idle task - not syncing
> >
> > One of those driver modules probably has a function in the cleanup
> > routine path unloaded/unmapped. Doing a cat /proc/modules before shutting
> > down and taking copying the output would help speed up the search.
>
> $ /sbin/lsmod
> Module                  Size  Used by
> sg                     39648  0
> st                     41276  0
> sr_mod                 18788  0
> sd_mod                 22144  0
> scsi_mod              119372  4 sg,st,sr_mod,sd_mod
> ide_cd                 41984  0
> cdrom                  40252  2 sr_mod,ide_cd
> i830                   78724  3
> ipv6                  266692  16
> i810_audio             34132  1
> ac97_codec             18828  1 i810_audio
> soundcore              10272  2 i810_audio
> af_packet              22696  0
> usbhid                 45216  0
> floppy                 60816  0
> thermal                12264  0
> processor              17032  1 thermal
> fan                     3940  0
> button                  6224  0
> battery                 8836  0
> ac                      4708  0
> airo_cs                 7812  0
> ds                     18948  3 airo_cs
> airo                   75320  1 airo_cs
> 3c59x                  38280  0
> yenta_socket           21728  0
> pcmcia_core            64428  3 airo_cs,ds,yenta_socket
> intel_agp              19804  1
> agpgart                34440  4 intel_agp
> uhci_hcd               32592  0
> usbcore               116704  4 usbhid,uhci_hcd
> rtc                    12760  0
> ext3                  123688  2
> jbd                    61368  1 ext3

Sorry - read that as 'run lsmod'

$ cat /proc/modules
sg 39648 0 - Live 0xd0d51000
st 41276 0 - Live 0xd0d20000
sr_mod 18788 0 - Live 0xd0cef000
sd_mod 22144 0 - Live 0xd0d0c000
scsi_mod 119372 4 sg,st,sr_mod,sd_mod, Live 0xd0d32000
ide_cd 41984 0 - Live 0xd0d00000
cdrom 40252 2 sr_mod,ide_cd, Live 0xd0cf5000
i830 78724 3 - Live 0xd09fc000
ipv6 266692 16 - Live 0xd0a32000
i810_audio 34132 1 - Live 0xd09dc000
ac97_codec 18828 1 i810_audio, Live 0xd09a6000
soundcore 10272 2 i810_audio, Live 0xd0987000
af_packet 22696 0 - Live 0xd097a000
usbhid 45216 0 - Live 0xd09c4000
floppy 60816 0 - Live 0xd09b4000
thermal 12264 0 - Live 0xd0950000
processor 17032 1 thermal, Live 0xd0981000
fan 3940 0 - Live 0xd0978000
button 6224 0 - Live 0xd0960000
battery 8836 3 - Live 0xd0974000
ac 4708 0 - Live 0xd095d000
airo_cs 7812 0 - Live 0xd0954000
ds 18948 3 airo_cs, Live 0xd0957000
airo 75320 1 airo_cs, Live 0xd098b000
3c59x 38280 0 - Live 0xd0845000
yenta_socket 21728 0 - Live 0xd0832000
pcmcia_core 64428 3 airo_cs,ds,yenta_socket, Live 0xd0963000
intel_agp 19804 1 - Live 0xd0809000
agpgart 34440 4 intel_agp, Live 0xd0839000
uhci_hcd 32592 0 - Live 0xd0814000
usbcore 116704 4 usbhid,uhci_hcd, Live 0xd0871000
rtc 12760 0 - Live 0xd080f000
ext3 123688 2 - Live 0xd0851000
jbd 61368 1 ext3, Live 0xd081d000

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA+4TKBn4EFUVUIO0RAu47AJwKszjGgvJnWtJAxgaCWS/z9welzACgntTj
zHLlTY7CesO/SW9ty6bbtDo=
=FtVR
-----END PGP SIGNATURE-----
