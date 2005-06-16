Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVFPHjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVFPHjo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 03:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVFPHjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 03:39:44 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:55526 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261190AbVFPHh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 03:37:29 -0400
Date: Thu, 16 Jun 2005 00:36:38 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       gregkh@suse.de, zaitcev@redhat.com, dbrownell@users.sourceforge.net
Subject: Re: USB flash "drive" is not working sometimes
Message-ID: <20050616073638.GA12478@one-eyed-alien.net>
Mail-Followup-To: Denis Vlasenko <vda@ilport.com.ua>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	gregkh@suse.de, zaitcev@redhat.com, dbrownell@users.sourceforge.net
References: <200506160933.01195.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <200506160933.01195.vda@ilport.com.ua>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2005 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm pretty sure that the failure mode here has little to do with
usb-storage.  It looks like the device fails to enumerate properly.

Matt

On Thu, Jun 16, 2005 at 09:33:01AM +0300, Denis Vlasenko wrote:
> Hi folks,
>=20
> I had a 128M flash stick and it worked just fine.
>=20
> Now I've got 256M one (Transcend JetFlash).
> This one sometimes fails to work.
> Symptom is a failure to mount /dev/sda1.
>=20
> This was observer on two different machines, one with USB1
> and one with USB2 controllers.
>=20
> Today I plugged in the stick before I powered box up,
> and it didn't mount. Replugging helped.
> (I do not think it happens on cold boot only.
> IIRC On other occasions it didn't not work when
> I plugged the stick into already running box)
>=20
> Linux 2.6.12-rc2, "grep ^CONFIG .config" is below sig.
>=20
> # lspci
> 00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory=
 Controller Hub (rev 04)
> 00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphic=
s Controller] (rev 04)
> 00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 05)
> 00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
> 00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05)
> 00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 05)
> 00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
> 00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 05)
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio =
(rev 05)
> 01:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet Cont=
roller (rev 03)
>=20
> # lsmod
> Module                  Size  Used by
> usb_storage            56768  0
> snd_pcm_oss            47776  0
> snd_mixer_oss          17920  1 snd_pcm_oss
> snd_intel8x0           30656  0
> snd_ac97_codec         69120  1 snd_intel8x0
> snd_pcm                82436  3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec
> snd_timer              24324  1 snd_pcm
> snd                    50532  6 snd_pcm_oss,snd_mixer_oss,snd_intel8x0,sn=
d_ac97_codec,snd_pcm,snd_timer
> soundcore              10464  1 snd
> snd_page_alloc         10628  2 snd_intel8x0,snd_pcm
> uhci_hcd               30604  0
> usbcore               115708  3 usb_storage,uhci_hcd
> i810fb                 30080  1
> vgastate                9088  1 i810fb
> nls_koi8_r              6144  1
> nls_cp866               6144  1
> autofs4                18948  1
> nfsd                  195712  5
> exportfs                7040  1 nfsd
> intel_agp              21788  1
> agpgart                33996  3 i810fb,intel_agp
>=20
> The log:
>=20
> At boot-time:
>=20
> 2005-06-16_05:23:09.25937 kern.info: usbcore: registered new driver usbfs
> 2005-06-16_05:23:09.28069 kern.info: usbcore: registered new driver hub
> 2005-06-16_05:23:09.33813 kern.info: USB Universal Host Controller Interf=
ace driver v2.2
> 2005-06-16_05:23:09.33839 kern.info: ACPI: PCI Interrupt 0000:00:1f.2[D] =
-> GSI 19 (level, low) -> IRQ 19
> 2005-06-16_05:23:09.33843 kern.debug: PCI: Setting latency timer of devic=
e 0000:00:1f.2 to 64
> 2005-06-16_05:23:09.33846 kern.info: uhci_hcd 0000:00:1f.2: Intel Corpora=
tion 82801BA/BAM USB (Hub #1)
> 2005-06-16_05:23:09.42972 kern.info: uhci_hcd 0000:00:1f.2: new USB bus r=
egistered, assigned bus number 1
> 2005-06-16_05:23:09.42986 kern.info: uhci_hcd 0000:00:1f.2: irq 19, io ba=
se 0x00001820
> 2005-06-16_05:23:09.42989 kern.info: uhci_hcd 0000:00:1f.2: detected 2 po=
rts
> 2005-06-16_05:23:09.42992 kern.debug: usb usb1: default language 0x0409
> 2005-06-16_05:23:09.42996 kern.debug: usb usb1: new device strings: Mfr=
=3D3, Product=3D2, SerialNumber=3D1
> 2005-06-16_05:23:09.42999 kern.info: usb usb1: Product: Intel Corporation=
 82801BA/BAM USB (Hub #1)
> 2005-06-16_05:23:09.43002 kern.info: usb usb1: Manufacturer: Linux 2.6.12=
-rc2 uhci_hcd
> 2005-06-16_05:23:09.43017 kern.info: usb usb1: SerialNumber: 0000:00:1f.2
> 2005-06-16_05:23:09.43020 kern.debug: usb usb1: hotplug
> 2005-06-16_05:23:09.44883 kern.debug: usb usb1: adding 1-0:1.0 (config #1=
, interface 0)
> 2005-06-16_05:23:09.44897 kern.debug: usb 1-0:1.0: hotplug
> 2005-06-16_05:23:09.44921 kern.debug: hub 1-0:1.0: usb_probe_interface
> 2005-06-16_05:23:09.44924 kern.debug: hub 1-0:1.0: usb_probe_interface - =
got id
> 2005-06-16_05:23:09.44927 kern.info: hub 1-0:1.0: USB hub found
> 2005-06-16_05:23:09.44930 kern.info: hub 1-0:1.0: 2 ports detected
> 2005-06-16_05:23:09.44932 kern.debug: hub 1-0:1.0: standalone hub
> 2005-06-16_05:23:09.44935 kern.debug: hub 1-0:1.0: no power switching (us=
b 1.0)
> 2005-06-16_05:23:09.44938 kern.debug: hub 1-0:1.0: individual port over-c=
urrent protection
> 2005-06-16_05:23:09.44941 kern.debug: hub 1-0:1.0: power on to power good=
 time: 2ms
> 2005-06-16_05:23:09.44944 kern.debug: hub 1-0:1.0: local power source is =
good
> 2005-06-16_05:23:09.46203 kern.info: ACPI: PCI Interrupt 0000:00:1f.4[C] =
-> GSI 23 (level, low) -> IRQ 23
> 2005-06-16_05:23:09.46217 kern.debug: PCI: Setting latency timer of devic=
e 0000:00:1f.4 to 64
> 2005-06-16_05:23:09.46220 kern.info: uhci_hcd 0000:00:1f.4: Intel Corpora=
tion 82801BA/BAM USB (Hub #2)
> 2005-06-16_05:23:09.46224 kern.debug: hub 1-0:1.0: state 5 ports 2 chg 00=
00 evt 0000
> 2005-06-16_05:23:09.58006 kern.info: uhci_hcd 0000:00:1f.4: new USB bus r=
egistered, assigned bus number 2
> 2005-06-16_05:23:09.58026 kern.info: uhci_hcd 0000:00:1f.4: irq 23, io ba=
se 0x00001840
> 2005-06-16_05:23:09.58030 kern.info: uhci_hcd 0000:00:1f.4: detected 2 po=
rts
> 2005-06-16_05:23:09.58033 kern.debug: usb usb2: default language 0x0409
> 2005-06-16_05:23:09.58037 kern.debug: usb usb2: new device strings: Mfr=
=3D3, Product=3D2, SerialNumber=3D1
> 2005-06-16_05:23:09.58041 kern.info: usb usb2: Product: Intel Corporation=
 82801BA/BAM USB (Hub #2)
> 2005-06-16_05:23:09.58045 kern.info: usb usb2: Manufacturer: Linux 2.6.12=
-rc2 uhci_hcd
> 2005-06-16_05:23:09.58048 kern.info: usb usb2: SerialNumber: 0000:00:1f.4
> 2005-06-16_05:23:09.58052 kern.debug: usb usb2: hotplug
> 2005-06-16_05:23:09.63640 kern.debug: usb usb2: adding 2-0:1.0 (config #1=
, interface 0)
> 2005-06-16_05:23:09.63659 kern.debug: usb 2-0:1.0: hotplug
> 2005-06-16_05:23:09.63737 kern.debug: hub 2-0:1.0: usb_probe_interface
> 2005-06-16_05:23:09.63746 kern.debug: hub 2-0:1.0: usb_probe_interface - =
got id
> 2005-06-16_05:23:09.63750 kern.info: hub 2-0:1.0: USB hub found
> 2005-06-16_05:23:09.63753 kern.info: hub 2-0:1.0: 2 ports detected
> 2005-06-16_05:23:09.63757 kern.debug: hub 2-0:1.0: standalone hub
> 2005-06-16_05:23:09.63760 kern.debug: hub 2-0:1.0: no power switching (us=
b 1.0)
> 2005-06-16_05:23:09.63763 kern.debug: hub 2-0:1.0: individual port over-c=
urrent protection
> 2005-06-16_05:23:09.63767 kern.debug: hub 2-0:1.0: power on to power good=
 time: 2ms
> 2005-06-16_05:23:09.63771 kern.debug: hub 2-0:1.0: local power source is =
good
> 2005-06-16_05:23:09.81155 kern.debug: hub 2-0:1.0: state 5 ports 2 chg 00=
00 evt 0000
> 2005-06-16_05:23:09.81176 kern.debug: uhci_hcd 0000:00:1f.4: port 1 ports=
c 0093,00
> 2005-06-16_05:23:09.81179 kern.debug: hub 2-0:1.0: port 1, status 0101, c=
hange 0001, 12 Mb/s
> 2005-06-16_05:23:09.91495 kern.debug: hub 2-0:1.0: debounce: port 1: tota=
l 100ms stable 100ms status 0x101
> 2005-06-16_05:23:09.99598 kern.info: usb 2-1: new full speed USB device u=
sing uhci_hcd and address 2
> 2005-06-16_05:23:09.99944 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_=
control: failed with status 440000
> 2005-06-16_05:23:09.99963 kern.debug: [ce4a7240] link (0e4a71b2) element =
(0ddbf040)
> 2005-06-16_05:23:09.99966 kern.debug:   0: [cddbf040] link (0ddbf080) e0 =
Stalled CRC/Timeo Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D0, PID=3D2d(SET=
UP) (buf=3D0e653b80)
> 2005-06-16_05:23:09.99972 kern.debug:   1: [cddbf080] link (0ddbf0c0) e3 =
SPD Active Length=3D0 MaxLen=3D3f DT1 EndPt=3D0 Dev=3D0, PID=3D69(IN) (buf=
=3D0e46c9a0)
> 2005-06-16_05:23:09.99976 kern.debug:   2: [cddbf0c0] link (00000001) e3 =
IOC Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D0, PID=3De1(OUT) (bu=
f=3D00000000)
> 2005-06-16_05:23:09.99981 kern.debug:=20
> 2005-06-16_05:23:10.00344 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_=
control: failed with status 440000
> 2005-06-16_05:23:10.00365 kern.debug: [ce4a7270] link (0e4a71b2) element =
(0ddbf100)
> 2005-06-16_05:23:10.00368 kern.debug:   0: [cddbf100] link (0ddbf140) e0 =
Stalled CRC/Timeo Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D0, PID=3D2d(SET=
UP) (buf=3D0e653b80)
> 2005-06-16_05:23:10.00374 kern.debug:   1: [cddbf140] link (0ddbf180) e3 =
SPD Active Length=3D0 MaxLen=3D3f DT1 EndPt=3D0 Dev=3D0, PID=3D69(IN) (buf=
=3D0e46c9a0)
> 2005-06-16_05:23:10.00379 kern.debug:   2: [cddbf180] link (00000001) e3 =
IOC Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D0, PID=3De1(OUT) (bu=
f=3D00000000)
> 2005-06-16_05:23:10.00385 kern.debug:=20
> 2005-06-16_05:23:10.17077 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_=
control: failed with status 440000
> 2005-06-16_05:23:10.17101 kern.debug: [ce4a7240] link (0e4a71b2) element =
(0ddbf040)
> 2005-06-16_05:23:10.17105 kern.debug:   0: [cddbf040] link (0ddbf080) e0 =
Stalled CRC/Timeo Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D0, PID=3D2d(SET=
UP) (buf=3D0e653b80)
> 2005-06-16_05:23:10.17110 kern.debug:   1: [cddbf080] link (0ddbf0c0) e3 =
SPD Active Length=3D0 MaxLen=3D3f DT1 EndPt=3D0 Dev=3D0, PID=3D69(IN) (buf=
=3D0e46c9a0)
> 2005-06-16_05:23:10.17115 kern.debug:   2: [cddbf0c0] link (00000001) e3 =
IOC Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D0, PID=3De1(OUT) (bu=
f=3D00000000)
> 2005-06-16_05:23:10.17120 kern.debug:=20
> 2005-06-16_05:23:10.17124 kern.err: usb 2-1: device descriptor read/64, e=
rror -71
> 2005-06-16_05:23:10.17336 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_=
control: failed with status 440000
> 2005-06-16_05:23:10.17343 kern.debug: [ce4a7240] link (0e4a71b2) element =
(0ddbf040)
> 2005-06-16_05:23:10.17347 kern.debug:   0: [cddbf040] link (0ddbf080) e0 =
Stalled CRC/Timeo Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D0, PID=3D2d(SET=
UP) (buf=3D0de012a0)
> 2005-06-16_05:23:10.17352 kern.debug:   1: [cddbf080] link (0ddbf0c0) e3 =
SPD Active Length=3D0 MaxLen=3D3f DT1 EndPt=3D0 Dev=3D0, PID=3D69(IN) (buf=
=3D0e46c9a0)
> 2005-06-16_05:23:10.17357 kern.debug:   2: [cddbf0c0] link (00000001) e3 =
IOC Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D0, PID=3De1(OUT) (bu=
f=3D00000000)
> 2005-06-16_05:23:10.17362 kern.debug:=20
> 2005-06-16_05:23:10.17730 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_=
control: failed with status 440000
> 2005-06-16_05:23:10.17737 kern.debug: [ce4a7270] link (0e4a71b2) element =
(0ddbf100)
> 2005-06-16_05:23:10.17741 kern.debug:   0: [cddbf100] link (0ddbf140) e0 =
Stalled CRC/Timeo Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D0, PID=3D2d(SET=
UP) (buf=3D0de012a0)
> 2005-06-16_05:23:10.17746 kern.debug:   1: [cddbf140] link (0ddbf180) e3 =
SPD Active Length=3D0 MaxLen=3D3f DT1 EndPt=3D0 Dev=3D0, PID=3D69(IN) (buf=
=3D0e46c9a0)
> 2005-06-16_05:23:10.17750 kern.debug:   2: [cddbf180] link (00000001) e3 =
IOC Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D0, PID=3De1(OUT) (bu=
f=3D00000000)
> 2005-06-16_05:23:10.17755 kern.debug:=20
> 2005-06-16_05:23:10.18129 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_=
control: failed with status 440000
> 2005-06-16_05:23:10.18134 kern.debug: [ce4a7240] link (0e4a71b2) element =
(0ddbf040)
> 2005-06-16_05:23:10.18138 kern.debug:   0: [cddbf040] link (0ddbf080) e0 =
Stalled CRC/Timeo Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D0, PID=3D2d(SET=
UP) (buf=3D0de012a0)
> 2005-06-16_05:23:10.18143 kern.debug:   1: [cddbf080] link (0ddbf0c0) e3 =
SPD Active Length=3D0 MaxLen=3D3f DT1 EndPt=3D0 Dev=3D0, PID=3D69(IN) (buf=
=3D0e46c9a0)
> 2005-06-16_05:23:10.18148 kern.debug:   2: [cddbf0c0] link (00000001) e3 =
IOC Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D0, PID=3De1(OUT) (bu=
f=3D00000000)
> 2005-06-16_05:23:10.18153 kern.debug:=20
> 2005-06-16_05:23:10.24285 kern.err: usb 2-1: device descriptor read/64, e=
rror -71
> 2005-06-16_05:23:10.41986 kern.info: usb 2-1: new full speed USB device u=
sing uhci_hcd and address 3
> 2005-06-16_05:23:10.42326 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_=
control: failed with status 440000
> 2005-06-16_05:23:10.42331 kern.debug: [ce4a7240] link (0e4a71b2) element =
(0ddbf040)
> 2005-06-16_05:23:10.42335 kern.debug:   0: [cddbf040] link (0ddbf080) e0 =
Stalled CRC/Timeo Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D0, PID=3D2d(SET=
UP) (buf=3D0e653200)
> 2005-06-16_05:23:10.42340 kern.debug:   1: [cddbf080] link (0ddbf0c0) e3 =
SPD Active Length=3D0 MaxLen=3D3f DT1 EndPt=3D0 Dev=3D0, PID=3D69(IN) (buf=
=3D0e46c9a0)
> 2005-06-16_05:23:10.42345 kern.debug:   2: [cddbf0c0] link (00000001) e3 =
IOC Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D0, PID=3De1(OUT) (bu=
f=3D00000000)
> 2005-06-16_05:23:10.42350 kern.debug:=20
> 2005-06-16_05:23:10.42724 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_=
control: failed with status 440000
> 2005-06-16_05:23:10.42729 kern.debug: [ce4a7270] link (0e4a71b2) element =
(0ddbf100)
> 2005-06-16_05:23:10.42733 kern.debug:   0: [cddbf100] link (0ddbf140) e0 =
Stalled CRC/Timeo Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D0, PID=3D2d(SET=
UP) (buf=3D0e653200)
> 2005-06-16_05:23:10.42738 kern.debug:   1: [cddbf140] link (0ddbf180) e3 =
SPD Active Length=3D0 MaxLen=3D3f DT1 EndPt=3D0 Dev=3D0, PID=3D69(IN) (buf=
=3D0e46c9a0)
> 2005-06-16_05:23:10.42752 kern.debug:   2: [cddbf180] link (00000001) e3 =
IOC Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D0, PID=3De1(OUT) (bu=
f=3D00000000)
> 2005-06-16_05:23:10.42757 kern.debug:=20
> 2005-06-16_05:23:10.43125 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_=
control: failed with status 440000
> 2005-06-16_05:23:10.43130 kern.debug: [ce4a7240] link (0e4a71b2) element =
(0ddbf040)
> 2005-06-16_05:23:10.43134 kern.debug:   0: [cddbf040] link (0ddbf080) e0 =
Stalled CRC/Timeo Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D0, PID=3D2d(SET=
UP) (buf=3D0e653200)
> 2005-06-16_05:23:10.43139 kern.debug:   1: [cddbf080] link (0ddbf0c0) e3 =
SPD Active Length=3D0 MaxLen=3D3f DT1 EndPt=3D0 Dev=3D0, PID=3D69(IN) (buf=
=3D0e46c9a0)
> 2005-06-16_05:23:10.43144 kern.debug:   2: [cddbf0c0] link (00000001) e3 =
IOC Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D0, PID=3De1(OUT) (bu=
f=3D00000000)
> 2005-06-16_05:23:10.43148 kern.debug:=20
> 2005-06-16_05:23:10.51041 kern.err: usb 2-1: device descriptor read/64, e=
rror -71
> 2005-06-16_05:23:10.61429 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_=
control: failed with status 440000
> 2005-06-16_05:23:10.61450 kern.debug: [ce4a7240] link (0e4a71b2) element =
(0ddbf040)
> 2005-06-16_05:23:10.61454 kern.debug:   0: [cddbf040] link (0ddbf080) e0 =
Stalled CRC/Timeo Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D0, PID=3D2d(SET=
UP) (buf=3D0de01fc0)
> 2005-06-16_05:23:10.61459 kern.debug:   1: [cddbf080] link (0ddbf0c0) e3 =
SPD Active Length=3D0 MaxLen=3D3f DT1 EndPt=3D0 Dev=3D0, PID=3D69(IN) (buf=
=3D0e46c8a0)
> 2005-06-16_05:23:10.61465 kern.debug:   2: [cddbf0c0] link (00000001) e3 =
IOC Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D0, PID=3De1(OUT) (bu=
f=3D00000000)
> 2005-06-16_05:23:10.61470 kern.debug:=20
> 2005-06-16_05:23:10.61834 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_=
control: failed with status 440000
> 2005-06-16_05:23:10.61850 kern.debug: [ce4a7270] link (0e4a71b2) element =
(0ddbf100)
> 2005-06-16_05:23:10.61854 kern.debug:   0: [cddbf100] link (0ddbf140) e0 =
Stalled CRC/Timeo Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D0, PID=3D2d(SET=
UP) (buf=3D0de01fc0)
> 2005-06-16_05:23:10.61860 kern.debug:   1: [cddbf140] link (0ddbf180) e3 =
SPD Active Length=3D0 MaxLen=3D3f DT1 EndPt=3D0 Dev=3D0, PID=3D69(IN) (buf=
=3D0e46c8a0)
> 2005-06-16_05:23:10.61865 kern.debug:   2: [cddbf180] link (00000001) e3 =
IOC Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D0, PID=3De1(OUT) (bu=
f=3D00000000)
> 2005-06-16_05:23:10.61872 kern.debug:=20
> 2005-06-16_05:23:10.64626 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_=
control: failed with status 440000
> 2005-06-16_05:23:10.64647 kern.debug: [ce4a7240] link (0e4a71b2) element =
(0ddbf040)
> 2005-06-16_05:23:10.64651 kern.debug:   0: [cddbf040] link (0ddbf080) e0 =
Stalled CRC/Timeo Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D0, PID=3D2d(SET=
UP) (buf=3D0de01fc0)
> 2005-06-16_05:23:10.64656 kern.debug:   1: [cddbf080] link (0ddbf0c0) e3 =
SPD Active Length=3D0 MaxLen=3D3f DT1 EndPt=3D0 Dev=3D0, PID=3D69(IN) (buf=
=3D0e46c8a0)
> 2005-06-16_05:23:10.64662 kern.debug:   2: [cddbf0c0] link (00000001) e3 =
IOC Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D0, PID=3De1(OUT) (bu=
f=3D00000000)
> 2005-06-16_05:23:10.64669 kern.debug:=20
> 2005-06-16_05:23:10.73199 kern.err: usb 2-1: device descriptor read/64, e=
rror -71
> 2005-06-16_05:23:10.75358 kern.info: ACPI: PCI Interrupt 0000:00:1f.5[B] =
-> GSI 17 (level, low) -> IRQ 17
> 2005-06-16_05:23:10.75381 kern.debug: PCI: Setting latency timer of devic=
e 0000:00:1f.5 to 64
> 2005-06-16_05:23:10.89467 kern.info: usb 2-1: new full speed USB device u=
sing uhci_hcd and address 4
> 2005-06-16_05:23:10.89813 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_=
control: failed with status 440000
> 2005-06-16_05:23:10.89818 kern.debug: [ce4a7240] link (0e4a71b2) element =
(0ddbf040)
> 2005-06-16_05:23:10.89822 kern.debug:   0: [cddbf040] link (0ddbf080) e0 =
Stalled CRC/Timeo Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D0, PID=3D2d(SET=
UP) (buf=3D0de01c40)
> 2005-06-16_05:23:10.89827 kern.debug:   1: [cddbf080] link (00000001) e3 =
IOC Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D0, PID=3D69(IN) (buf=
=3D00000000)
> 2005-06-16_05:23:10.89832 kern.debug:=20
> 2005-06-16_05:23:11.08424 kern.info: intel8x0_measure_ac97_clock: measure=
d 49730 usecs
> 2005-06-16_05:23:11.08459 kern.info: intel8x0: clocking to 48000
> 2005-06-16_05:23:11.12763 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_=
control: failed with status 440000
> 2005-06-16_05:23:11.12783 kern.debug: [ce4a7240] link (0e4a71b2) element =
(0ddbf040)
> 2005-06-16_05:23:11.12787 kern.debug:   0: [cddbf040] link (0ddbf080) e0 =
Stalled CRC/Timeo Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D0, PID=3D2d(SET=
UP) (buf=3D0df3d760)
> 2005-06-16_05:23:11.12792 kern.debug:   1: [cddbf080] link (00000001) e3 =
IOC Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D0, PID=3D69(IN) (buf=
=3D00000000)
> 2005-06-16_05:23:11.12797 kern.debug:=20
> 2005-06-16_05:23:11.32892 kern.err: usb 2-1: device not accepting address=
 4, error -71
> 2005-06-16_05:23:11.39301 kern.info: usb 2-1: new full speed USB device u=
sing uhci_hcd and address 5
> 2005-06-16_05:23:11.39611 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_=
control: failed with status 440000
> 2005-06-16_05:23:11.39624 kern.debug: [ce4a7240] link (0e4a71b2) element =
(0ddbf040)
> 2005-06-16_05:23:11.39628 kern.debug:   0: [cddbf040] link (0ddbf080) e0 =
Stalled CRC/Timeo Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D0, PID=3D2d(SET=
UP) (buf=3D0e653a00)
> 2005-06-16_05:23:11.39633 kern.debug:   1: [cddbf080] link (00000001) e3 =
IOC Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D0, PID=3D69(IN) (buf=
=3D00000000)
> 2005-06-16_05:23:11.39638 kern.debug:=20
> 2005-06-16_05:23:11.50957 kern.debug: uhci_hcd 0000:00:1f.2: suspend_hc
> 2005-06-16_05:23:11.88943 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_=
control: failed with status 440000
> 2005-06-16_05:23:12.75364 kern.debug: [ce4a7240] link (0e4a71b2) element =
(0ddbf040)
> 2005-06-16_05:23:12.75379 kern.debug:   0: [cddbf040] link (0ddbf080) e0 =
Stalled CRC/Timeo Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D0, PID=3D2d(SET=
UP) (buf=3D0e8b9d80)
> 2005-06-16_05:23:12.75384 kern.debug:   1: [cddbf080] link (00000001) e3 =
IOC Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D0, PID=3D69(IN) (buf=
=3D00000000)
> 2005-06-16_05:23:12.75389 kern.debug:=20
> 2005-06-16_05:23:12.75392 kern.err: usb 2-1: device not accepting address=
 5, error -71
>=20
> Mount does not work.
>=20
> I remove flash and reinsert:
>=20
> 2005-06-16_06:11:07.84944 kern.debug: hub 2-0:1.0: state 5 ports 2 chg 00=
00 evt 0002
> 2005-06-16_06:11:07.84976 kern.debug: uhci_hcd 0000:00:1f.4: port 1 ports=
c 0082,00
> 2005-06-16_06:11:07.84980 kern.debug: hub 2-0:1.0: port 1, status 0100, c=
hange 0001, 12 Mb/s
> 2005-06-16_06:11:07.94541 kern.debug: hub 2-0:1.0: debounce: port 1: tota=
l 100ms stable 100ms status 0x100
> 2005-06-16_06:11:08.67336 kern.debug: uhci_hcd 0000:00:1f.4: suspend_hc
> 2005-06-16_06:11:11.07275 kern.debug: uhci_hcd 0000:00:1f.4: wakeup_hc
> 2005-06-16_06:11:11.07478 kern.debug: hub 2-0:1.0: state 5 ports 2 chg 00=
00 evt 0002
> 2005-06-16_06:11:11.07483 kern.debug: uhci_hcd 0000:00:1f.4: port 1 ports=
c 0083,00
> 2005-06-16_06:11:11.07487 kern.debug: hub 2-0:1.0: port 1, status 0101, c=
hange 0001, 12 Mb/s
> 2005-06-16_06:11:11.17881 kern.debug: hub 2-0:1.0: debounce: port 1: tota=
l 100ms stable 100ms status 0x101
> 2005-06-16_06:11:11.24079 kern.info: usb 2-1: new full speed USB device u=
sing uhci_hcd and address 6
> 2005-06-16_06:11:11.35987 kern.debug: usb 2-1: default language 0x0409
> 2005-06-16_06:11:11.36661 kern.debug: usb 2-1: new device strings: Mfr=3D=
1, Product=3D2, SerialNumber=3D3
> 2005-06-16_06:11:11.36690 kern.info: usb 2-1: Product: Flash Disk     =20
> 2005-06-16_06:11:11.36695 kern.info: usb 2-1: Manufacturer: USB    =20
> 2005-06-16_06:11:11.36699 kern.info: usb 2-1: SerialNumber: 6110424CA8B40=
0D4
> 2005-06-16_06:11:11.36718 kern.debug: usb 2-1: hotplug
> 2005-06-16_06:11:11.44527 kern.debug: usb 2-1: adding 2-1:1.0 (config #1,=
 interface 0)
> 2005-06-16_06:11:11.44556 kern.debug: usb 2-1:1.0: hotplug
> 2005-06-16_06:11:11.45966 kern.debug: hub 2-0:1.0: state 5 ports 2 chg 00=
00 evt 0002
> 2005-06-16_06:11:12.62641 kern.info: Initializing USB Mass Storage driver=
...
> 2005-06-16_06:11:12.62674 kern.debug: usb-storage 2-1:1.0: usb_probe_inte=
rface
> 2005-06-16_06:11:12.62679 kern.debug: usb-storage 2-1:1.0: usb_probe_inte=
rface - got id
> 2005-06-16_06:11:12.62683 kern.info: scsi0 : SCSI emulation for USB Mass =
Storage devices
> 2005-06-16_06:11:12.62687 kern.debug: usb-storage: device found at 6
> 2005-06-16_06:11:12.62691 kern.debug: usb-storage: waiting for device to =
settle before scanning
> 2005-06-16_06:11:12.62695 kern.info: usbcore: registered new driver usb-s=
torage
> 2005-06-16_06:11:12.62699 kern.info: USB Mass Storage support registered.
> 2005-06-16_06:11:17.64236 kern.notice:   Vendor: JetFlash  Model: TS256MJ=
F2B/2L     Rev: 2.00
> 2005-06-16_06:11:17.64270 kern.notice:   Type:   Direct-Access           =
           ANSI SCSI revision: 02
> 2005-06-16_06:11:17.86446 kern.notice: sda: Unit Not Ready, sense:
> 2005-06-16_06:11:17.86478 kern.info: : Current: sense key=3D0x6
> 2005-06-16_06:11:17.86483 kern.info:     ASC=3D0x28 ASCQ=3D0x0
> 2005-06-16_06:11:18.02046 kern.notice: sda : READ CAPACITY failed.
> 2005-06-16_06:11:18.02076 kern.info: sda : status=3D1, message=3D00, host=
=3D0, driver=3D08=20
> 2005-06-16_06:11:18.02081 kern.info: sd: Current: sense key=3D0x6
> 2005-06-16_06:11:18.02085 kern.info:     ASC=3D0x28 ASCQ=3D0x0
> 2005-06-16_06:11:18.11284 kern.warn: sda: test WP failed, assume Write En=
abled
> 2005-06-16_06:11:18.11315 kern.err: sda: assuming drive cache: write thro=
ugh
> 2005-06-16_06:11:18.12740 kern.notice: SCSI device sda: 511232 512-byte h=
dwr sectors (262 MB)
> 2005-06-16_06:11:18.13162 kern.notice: sda: Write Protect is off
> 2005-06-16_06:11:18.13192 kern.debug: sda: Mode Sense: 03 00 00 00
> 2005-06-16_06:11:18.13197 kern.err: sda: assuming drive cache: write thro=
ugh
> 2005-06-16_06:11:18.13201 kern.info:  /dev/scsi/host0/bus0/target0/lun0: =
p1
> 2005-06-16_06:11:18.20334 kern.notice: Attached scsi removable disk sda a=
t scsi0, channel 0, id 0, lun 0
> 2005-06-16_06:11:18.21190 kern.debug: usb-storage: device scan complete
>=20
> Mount succeeds
> --
> vda
>=20
> CONFIG_X86=3Dy
> CONFIG_MMU=3Dy
> CONFIG_UID16=3Dy
> CONFIG_GENERIC_ISA_DMA=3Dy
> CONFIG_GENERIC_IOMAP=3Dy
> CONFIG_EXPERIMENTAL=3Dy
> CONFIG_CLEAN_COMPILE=3Dy
> CONFIG_LOCK_KERNEL=3Dy
> CONFIG_INIT_ENV_ARG_LIMIT=3D32
> CONFIG_LOCALVERSION=3D""
> CONFIG_SWAP=3Dy
> CONFIG_SYSVIPC=3Dy
> CONFIG_BSD_PROCESS_ACCT=3Dy
> CONFIG_SYSCTL=3Dy
> CONFIG_HOTPLUG=3Dy
> CONFIG_IKCONFIG=3Dy
> CONFIG_IKCONFIG_PROC=3Dy
> CONFIG_EMBEDDED=3Dy
> CONFIG_KALLSYMS=3Dy
> CONFIG_KALLSYMS_ALL=3Dy
> CONFIG_KALLSYMS_EXTRA_PASS=3Dy
> CONFIG_BASE_FULL=3Dy
> CONFIG_FUTEX=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
> CONFIG_SHMEM=3Dy
> CONFIG_CC_ALIGN_FUNCTIONS=3D1
> CONFIG_CC_ALIGN_LABELS=3D1
> CONFIG_CC_ALIGN_LOOPS=3D1
> CONFIG_CC_ALIGN_JUMPS=3D1
> CONFIG_BASE_SMALL=3D0
> CONFIG_MODULES=3Dy
> CONFIG_MODULE_UNLOAD=3Dy
> CONFIG_MODULE_FORCE_UNLOAD=3Dy
> CONFIG_OBSOLETE_MODPARM=3Dy
> CONFIG_MODVERSIONS=3Dy
> CONFIG_KMOD=3Dy
> CONFIG_STOP_MACHINE=3Dy
> CONFIG_X86_PC=3Dy
> CONFIG_M486=3Dy
> CONFIG_X86_GENERIC=3Dy
> CONFIG_X86_CMPXCHG=3Dy
> CONFIG_X86_XADD=3Dy
> CONFIG_X86_L1_CACHE_SHIFT=3D7
> CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> CONFIG_X86_PPRO_FENCE=3Dy
> CONFIG_X86_F00F_BUG=3Dy
> CONFIG_X86_WP_WORKS_OK=3Dy
> CONFIG_X86_INVLPG=3Dy
> CONFIG_X86_BSWAP=3Dy
> CONFIG_X86_POPAD_OK=3Dy
> CONFIG_X86_ALIGNMENT_16=3Dy
> CONFIG_X86_INTEL_USERCOPY=3Dy
> CONFIG_SMP=3Dy
> CONFIG_NR_CPUS=3D8
> CONFIG_SCHED_SMT=3Dy
> CONFIG_X86_LOCAL_APIC=3Dy
> CONFIG_X86_IO_APIC=3Dy
> CONFIG_X86_MCE=3Dy
> CONFIG_X86_MCE_NONFATAL=3Dy
> CONFIG_X86_MCE_P4THERMAL=3Dy
> CONFIG_MICROCODE=3Dm
> CONFIG_X86_MSR=3Dm
> CONFIG_X86_CPUID=3Dm
> CONFIG_NOHIGHMEM=3Dy
> CONFIG_MTRR=3Dy
> CONFIG_IRQBALANCE=3Dy
> CONFIG_HAVE_DEC_LOCK=3Dy
> CONFIG_ACPI=3Dy
> CONFIG_ACPI_BOOT=3Dy
> CONFIG_ACPI_INTERPRETER=3Dy
> CONFIG_ACPI_AC=3Dm
> CONFIG_ACPI_BATTERY=3Dm
> CONFIG_ACPI_BUTTON=3Dm
> CONFIG_ACPI_VIDEO=3Dm
> CONFIG_ACPI_FAN=3Dm
> CONFIG_ACPI_PROCESSOR=3Dm
> CONFIG_ACPI_THERMAL=3Dm
> CONFIG_ACPI_BLACKLIST_YEAR=3D0
> CONFIG_ACPI_BUS=3Dy
> CONFIG_ACPI_EC=3Dy
> CONFIG_ACPI_POWER=3Dy
> CONFIG_ACPI_PCI=3Dy
> CONFIG_ACPI_SYSTEM=3Dy
> CONFIG_PCI=3Dy
> CONFIG_PCI_GOANY=3Dy
> CONFIG_PCI_BIOS=3Dy
> CONFIG_PCI_DIRECT=3Dy
> CONFIG_PCI_MMCONFIG=3Dy
> CONFIG_PCI_NAMES=3Dy
> CONFIG_ISA=3Dy
> CONFIG_EISA=3Dy
> CONFIG_EISA_VLB_PRIMING=3Dy
> CONFIG_EISA_PCI_EISA=3Dy
> CONFIG_EISA_VIRTUAL_ROOT=3Dy
> CONFIG_EISA_NAMES=3Dy
> CONFIG_HOTPLUG_PCI=3Dy
> CONFIG_HOTPLUG_PCI_COMPAQ=3Dy
> CONFIG_HOTPLUG_PCI_CPCI=3Dy
> CONFIG_HOTPLUG_PCI_CPCI_ZT5550=3Dy
> CONFIG_HOTPLUG_PCI_CPCI_GENERIC=3Dy
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
> CONFIG_FW_LOADER=3Dm
> CONFIG_PARPORT=3Dm
> CONFIG_PARPORT_PC=3Dm
> CONFIG_PNP=3Dy
> CONFIG_ISAPNP=3Dy
> CONFIG_PNPBIOS=3Dy
> CONFIG_PNPACPI=3Dy
> CONFIG_BLK_DEV_FD=3Dy
> CONFIG_BLK_DEV_XD=3Dm
> CONFIG_PARIDE=3Dm
> CONFIG_PARIDE_PARPORT=3Dm
> CONFIG_BLK_DEV_LOOP=3Dy
> CONFIG_BLK_DEV_CRYPTOLOOP=3Dm
> CONFIG_BLK_DEV_NBD=3Dm
> CONFIG_BLK_DEV_RAM=3Dy
> CONFIG_BLK_DEV_RAM_COUNT=3D16
> CONFIG_BLK_DEV_RAM_SIZE=3D4096
> CONFIG_BLK_DEV_INITRD=3Dy
> CONFIG_INITRAMFS_SOURCE=3D""
> CONFIG_LBD=3Dy
> CONFIG_CDROM_PKTCDVD=3Dy
> CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
> CONFIG_IOSCHED_NOOP=3Dy
> CONFIG_IOSCHED_AS=3Dy
> CONFIG_IOSCHED_DEADLINE=3Dy
> CONFIG_IOSCHED_CFQ=3Dy
> CONFIG_IDE=3Dy
> CONFIG_BLK_DEV_IDE=3Dy
> CONFIG_BLK_DEV_IDEDISK=3Dy
> CONFIG_IDEDISK_MULTI_MODE=3Dy
> CONFIG_BLK_DEV_IDECD=3Dy
> CONFIG_BLK_DEV_IDETAPE=3Dm
> CONFIG_BLK_DEV_IDEFLOPPY=3Dm
> CONFIG_BLK_DEV_IDESCSI=3Dm
> CONFIG_IDE_TASK_IOCTL=3Dy
> CONFIG_IDE_GENERIC=3Dy
> CONFIG_BLK_DEV_CMD640=3Dy
> CONFIG_BLK_DEV_IDEPNP=3Dy
> CONFIG_BLK_DEV_IDEPCI=3Dy
> CONFIG_IDEPCI_SHARE_IRQ=3Dy
> CONFIG_BLK_DEV_GENERIC=3Dy
> CONFIG_BLK_DEV_RZ1000=3Dy
> CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
> CONFIG_IDEDMA_PCI_AUTO=3Dy
> CONFIG_BLK_DEV_ALI15X3=3Dy
> CONFIG_BLK_DEV_AMD74XX=3Dy
> CONFIG_BLK_DEV_CMD64X=3Dy
> CONFIG_BLK_DEV_CS5520=3Dy
> CONFIG_BLK_DEV_CS5530=3Dy
> CONFIG_BLK_DEV_HPT34X=3Dy
> CONFIG_BLK_DEV_HPT366=3Dy
> CONFIG_BLK_DEV_PIIX=3Dy
> CONFIG_BLK_DEV_SIS5513=3Dy
> CONFIG_BLK_DEV_VIA82CXXX=3Dy
> CONFIG_BLK_DEV_IDEDMA=3Dy
> CONFIG_IDEDMA_AUTO=3Dy
> CONFIG_SCSI=3Dy
> CONFIG_SCSI_PROC_FS=3Dy
> CONFIG_BLK_DEV_SD=3Dy
> CONFIG_CHR_DEV_ST=3Dm
> CONFIG_CHR_DEV_OSST=3Dm
> CONFIG_BLK_DEV_SR=3Dm
> CONFIG_BLK_DEV_SR_VENDOR=3Dy
> CONFIG_CHR_DEV_SG=3Dm
> CONFIG_SCSI_MULTI_LUN=3Dy
> CONFIG_SCSI_AIC7XXX=3Dy
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D8
> CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000
> CONFIG_AIC7XXX_PROBE_EISA_VL=3Dy
> CONFIG_AIC7XXX_DEBUG_MASK=3D0
> CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy
> CONFIG_SCSI_AIC79XX=3Dy
> CONFIG_AIC79XX_CMDS_PER_DEVICE=3D8
> CONFIG_AIC79XX_RESET_DELAY_MS=3D15000
> CONFIG_AIC79XX_DEBUG_MASK=3D0
> CONFIG_SCSI_SATA=3Dy
> CONFIG_SCSI_SATA_AHCI=3Dy
> CONFIG_SCSI_ATA_PIIX=3Dy
> CONFIG_SCSI_SATA_NV=3Dy
> CONFIG_SCSI_SATA_PROMISE=3Dy
> CONFIG_SCSI_SATA_SX4=3Dy
> CONFIG_SCSI_SATA_SIL=3Dy
> CONFIG_SCSI_SATA_SIS=3Dy
> CONFIG_SCSI_SATA_ULI=3Dy
> CONFIG_SCSI_SATA_VIA=3Dy
> CONFIG_SCSI_SATA_VITESSE=3Dy
> CONFIG_SCSI_QLA2XXX=3Dy
> CONFIG_MD=3Dy
> CONFIG_BLK_DEV_MD=3Dm
> CONFIG_MD_LINEAR=3Dm
> CONFIG_MD_RAID0=3Dm
> CONFIG_MD_RAID1=3Dm
> CONFIG_MD_RAID10=3Dm
> CONFIG_MD_RAID5=3Dm
> CONFIG_MD_RAID6=3Dm
> CONFIG_MD_MULTIPATH=3Dm
> CONFIG_MD_FAULTY=3Dm
> CONFIG_BLK_DEV_DM=3Dm
> CONFIG_DM_CRYPT=3Dm
> CONFIG_NET=3Dy
> CONFIG_PACKET=3Dy
> CONFIG_UNIX=3Dy
> CONFIG_NET_KEY=3Dy
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> CONFIG_IP_ADVANCED_ROUTER=3Dy
> CONFIG_IP_MULTIPLE_TABLES=3Dy
> CONFIG_IP_ROUTE_FWMARK=3Dy
> CONFIG_IP_ROUTE_MULTIPATH=3Dy
> CONFIG_IP_ROUTE_VERBOSE=3Dy
> CONFIG_IP_PNP=3Dy
> CONFIG_IP_PNP_DHCP=3Dy
> CONFIG_IP_PNP_BOOTP=3Dy
> CONFIG_IP_PNP_RARP=3Dy
> CONFIG_NET_IPIP=3Dm
> CONFIG_NET_IPGRE=3Dm
> CONFIG_NET_IPGRE_BROADCAST=3Dy
> CONFIG_SYN_COOKIES=3Dy
> CONFIG_INET_TUNNEL=3Dm
> CONFIG_IP_TCPDIAG=3Dy
> CONFIG_NETFILTER=3Dy
> CONFIG_BRIDGE_NETFILTER=3Dy
> CONFIG_IP_NF_CONNTRACK=3Dm
> CONFIG_IP_NF_CONNTRACK_MARK=3Dy
> CONFIG_IP_NF_CT_PROTO_SCTP=3Dm
> CONFIG_IP_NF_FTP=3Dm
> CONFIG_IP_NF_IRC=3Dm
> CONFIG_IP_NF_TFTP=3Dm
> CONFIG_IP_NF_AMANDA=3Dm
> CONFIG_IP_NF_QUEUE=3Dm
> CONFIG_IP_NF_IPTABLES=3Dm
> CONFIG_IP_NF_MATCH_LIMIT=3Dm
> CONFIG_IP_NF_MATCH_IPRANGE=3Dm
> CONFIG_IP_NF_MATCH_MAC=3Dm
> CONFIG_IP_NF_MATCH_PKTTYPE=3Dm
> CONFIG_IP_NF_MATCH_MARK=3Dm
> CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
> CONFIG_IP_NF_MATCH_TOS=3Dm
> CONFIG_IP_NF_MATCH_RECENT=3Dm
> CONFIG_IP_NF_MATCH_ECN=3Dm
> CONFIG_IP_NF_MATCH_DSCP=3Dm
> CONFIG_IP_NF_MATCH_AH_ESP=3Dm
> CONFIG_IP_NF_MATCH_LENGTH=3Dm
> CONFIG_IP_NF_MATCH_TTL=3Dm
> CONFIG_IP_NF_MATCH_TCPMSS=3Dm
> CONFIG_IP_NF_MATCH_HELPER=3Dm
> CONFIG_IP_NF_MATCH_STATE=3Dm
> CONFIG_IP_NF_MATCH_CONNTRACK=3Dm
> CONFIG_IP_NF_MATCH_OWNER=3Dm
> CONFIG_IP_NF_MATCH_PHYSDEV=3Dm
> CONFIG_IP_NF_MATCH_ADDRTYPE=3Dm
> CONFIG_IP_NF_MATCH_REALM=3Dm
> CONFIG_IP_NF_MATCH_SCTP=3Dm
> CONFIG_IP_NF_MATCH_COMMENT=3Dm
> CONFIG_IP_NF_MATCH_CONNMARK=3Dm
> CONFIG_IP_NF_MATCH_HASHLIMIT=3Dm
> CONFIG_IP_NF_FILTER=3Dm
> CONFIG_IP_NF_TARGET_REJECT=3Dm
> CONFIG_IP_NF_TARGET_LOG=3Dm
> CONFIG_IP_NF_TARGET_ULOG=3Dm
> CONFIG_IP_NF_TARGET_TCPMSS=3Dm
> CONFIG_IP_NF_NAT=3Dm
> CONFIG_IP_NF_NAT_NEEDED=3Dy
> CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
> CONFIG_IP_NF_TARGET_REDIRECT=3Dm
> CONFIG_IP_NF_TARGET_NETMAP=3Dm
> CONFIG_IP_NF_TARGET_SAME=3Dm
> CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm
> CONFIG_IP_NF_NAT_IRC=3Dm
> CONFIG_IP_NF_NAT_FTP=3Dm
> CONFIG_IP_NF_NAT_TFTP=3Dm
> CONFIG_IP_NF_NAT_AMANDA=3Dm
> CONFIG_IP_NF_MANGLE=3Dm
> CONFIG_IP_NF_TARGET_TOS=3Dm
> CONFIG_IP_NF_TARGET_ECN=3Dm
> CONFIG_IP_NF_TARGET_DSCP=3Dm
> CONFIG_IP_NF_TARGET_MARK=3Dm
> CONFIG_IP_NF_TARGET_CLASSIFY=3Dm
> CONFIG_IP_NF_TARGET_CONNMARK=3Dm
> CONFIG_IP_NF_TARGET_CLUSTERIP=3Dm
> CONFIG_IP_NF_RAW=3Dm
> CONFIG_IP_NF_TARGET_NOTRACK=3Dm
> CONFIG_IP_NF_ARPTABLES=3Dm
> CONFIG_IP_NF_ARPFILTER=3Dm
> CONFIG_IP_NF_ARP_MANGLE=3Dm
> CONFIG_BRIDGE_NF_EBTABLES=3Dm
> CONFIG_BRIDGE_EBT_BROUTE=3Dm
> CONFIG_BRIDGE_EBT_T_FILTER=3Dm
> CONFIG_BRIDGE_EBT_T_NAT=3Dm
> CONFIG_BRIDGE_EBT_802_3=3Dm
> CONFIG_BRIDGE_EBT_AMONG=3Dm
> CONFIG_BRIDGE_EBT_ARP=3Dm
> CONFIG_BRIDGE_EBT_IP=3Dm
> CONFIG_BRIDGE_EBT_LIMIT=3Dm
> CONFIG_BRIDGE_EBT_MARK=3Dm
> CONFIG_BRIDGE_EBT_PKTTYPE=3Dm
> CONFIG_BRIDGE_EBT_STP=3Dm
> CONFIG_BRIDGE_EBT_VLAN=3Dm
> CONFIG_BRIDGE_EBT_ARPREPLY=3Dm
> CONFIG_BRIDGE_EBT_DNAT=3Dm
> CONFIG_BRIDGE_EBT_MARK_T=3Dm
> CONFIG_BRIDGE_EBT_REDIRECT=3Dm
> CONFIG_BRIDGE_EBT_SNAT=3Dm
> CONFIG_BRIDGE_EBT_LOG=3Dm
> CONFIG_BRIDGE_EBT_ULOG=3Dm
> CONFIG_XFRM=3Dy
> CONFIG_XFRM_USER=3Dy
> CONFIG_BRIDGE=3Dy
> CONFIG_NET_SCHED=3Dy
> CONFIG_NET_SCH_CLK_JIFFIES=3Dy
> CONFIG_NET_SCH_CBQ=3Dm
> CONFIG_NET_SCH_HTB=3Dm
> CONFIG_NET_SCH_HFSC=3Dm
> CONFIG_NET_SCH_PRIO=3Dm
> CONFIG_NET_SCH_RED=3Dm
> CONFIG_NET_SCH_SFQ=3Dm
> CONFIG_NET_SCH_TEQL=3Dm
> CONFIG_NET_SCH_TBF=3Dm
> CONFIG_NET_SCH_GRED=3Dm
> CONFIG_NET_SCH_DSMARK=3Dm
> CONFIG_NET_SCH_INGRESS=3Dm
> CONFIG_NET_QOS=3Dy
> CONFIG_NET_ESTIMATOR=3Dy
> CONFIG_NET_CLS=3Dy
> CONFIG_NET_CLS_TCINDEX=3Dm
> CONFIG_NET_CLS_ROUTE4=3Dm
> CONFIG_NET_CLS_ROUTE=3Dy
> CONFIG_NET_CLS_FW=3Dm
> CONFIG_NET_CLS_U32=3Dm
> CONFIG_CLS_U32_PERF=3Dy
> CONFIG_CLS_U32_MARK=3Dy
> CONFIG_NET_CLS_RSVP=3Dm
> CONFIG_NET_CLS_RSVP6=3Dm
> CONFIG_NET_CLS_POLICE=3Dy
> CONFIG_NET_PKTGEN=3Dm
> CONFIG_NETPOLL=3Dy
> CONFIG_NET_POLL_CONTROLLER=3Dy
> CONFIG_NETDEVICES=3Dy
> CONFIG_DUMMY=3Dm
> CONFIG_BONDING=3Dm
> CONFIG_EQUALIZER=3Dm
> CONFIG_TUN=3Dm
> CONFIG_NET_ETHERNET=3Dy
> CONFIG_MII=3Dy
> CONFIG_HAPPYMEAL=3Dy
> CONFIG_SUNGEM=3Dy
> CONFIG_NET_VENDOR_3COM=3Dy
> CONFIG_EL1=3Dy
> CONFIG_EL2=3Dy
> CONFIG_ELPLUS=3Dy
> CONFIG_EL16=3Dy
> CONFIG_EL3=3Dy
> CONFIG_3C515=3Dy
> CONFIG_VORTEX=3Dy
> CONFIG_TYPHOON=3Dy
> CONFIG_LANCE=3Dy
> CONFIG_NET_VENDOR_SMC=3Dy
> CONFIG_WD80x3=3Dy
> CONFIG_ULTRA=3Dy
> CONFIG_ULTRA32=3Dy
> CONFIG_SMC9194=3Dy
> CONFIG_NET_VENDOR_RACAL=3Dy
> CONFIG_NI52=3Dy
> CONFIG_NI65=3Dy
> CONFIG_AT1700=3Dy
> CONFIG_DEPCA=3Dy
> CONFIG_HP100=3Dy
> CONFIG_NET_ISA=3Dy
> CONFIG_E2100=3Dy
> CONFIG_EWRK3=3Dy
> CONFIG_EEXPRESS=3Dy
> CONFIG_EEXPRESS_PRO=3Dy
> CONFIG_HPLAN_PLUS=3Dy
> CONFIG_HPLAN=3Dy
> CONFIG_LP486E=3Dy
> CONFIG_ETH16I=3Dy
> CONFIG_NE2000=3Dy
> CONFIG_NET_PCI=3Dy
> CONFIG_PCNET32=3Dy
> CONFIG_AMD8111_ETH=3Dy
> CONFIG_ADAPTEC_STARFIRE=3Dy
> CONFIG_AC3200=3Dy
> CONFIG_APRICOT=3Dy
> CONFIG_B44=3Dy
> CONFIG_FORCEDETH=3Dy
> CONFIG_CS89x0=3Dy
> CONFIG_DGRS=3Dy
> CONFIG_EEPRO100=3Dy
> CONFIG_LNE390=3Dy
> CONFIG_FEALNX=3Dy
> CONFIG_NATSEMI=3Dy
> CONFIG_NE2K_PCI=3Dy
> CONFIG_NE3210=3Dy
> CONFIG_ES3210=3Dy
> CONFIG_8139CP=3Dy
> CONFIG_8139TOO=3Dy
> CONFIG_SIS900=3Dy
> CONFIG_EPIC100=3Dy
> CONFIG_SUNDANCE=3Dy
> CONFIG_TLAN=3Dy
> CONFIG_VIA_RHINE=3Dy
> CONFIG_ACENIC=3Dy
> CONFIG_DL2K=3Dy
> CONFIG_E1000=3Dy
> CONFIG_NS83820=3Dy
> CONFIG_HAMACHI=3Dy
> CONFIG_YELLOWFIN=3Dy
> CONFIG_R8169=3Dy
> CONFIG_SK98LIN=3Dy
> CONFIG_VIA_VELOCITY=3Dy
> CONFIG_TIGON3=3Dy
> CONFIG_IXGB=3Dy
> CONFIG_NET_RADIO=3Dy
> CONFIG_ATMEL=3Dm
> CONFIG_PCI_ATMEL=3Dm
> CONFIG_PRISM54=3Dm
> CONFIG_NET_WIRELESS=3Dy
> CONFIG_PLIP=3Dm
> CONFIG_PPP=3Dm
> CONFIG_PPP_MULTILINK=3Dy
> CONFIG_PPP_FILTER=3Dy
> CONFIG_PPP_ASYNC=3Dm
> CONFIG_PPP_SYNC_TTY=3Dm
> CONFIG_PPP_DEFLATE=3Dm
> CONFIG_PPP_BSDCOMP=3Dm
> CONFIG_PPPOE=3Dm
> CONFIG_SLIP=3Dm
> CONFIG_SLIP_COMPRESSED=3Dy
> CONFIG_SLIP_SMART=3Dy
> CONFIG_SLIP_MODE_SLIP6=3Dy
> CONFIG_SHAPER=3Dm
> CONFIG_NETCONSOLE=3Dy
> CONFIG_INPUT=3Dy
> CONFIG_INPUT_MOUSEDEV=3Dy
> CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> CONFIG_INPUT_EVDEV=3Dm
> CONFIG_INPUT_KEYBOARD=3Dy
> CONFIG_KEYBOARD_ATKBD=3Dy
> CONFIG_INPUT_MOUSE=3Dy
> CONFIG_MOUSE_PS2=3Dy
> CONFIG_MOUSE_SERIAL=3Dy
> CONFIG_SERIO=3Dy
> CONFIG_SERIO_I8042=3Dy
> CONFIG_SERIO_SERPORT=3Dy
> CONFIG_SERIO_PCIPS2=3Dy
> CONFIG_SERIO_LIBPS2=3Dy
> CONFIG_GAMEPORT=3Dy
> CONFIG_GAMEPORT_NS558=3Dy
> CONFIG_SOUND_GAMEPORT=3Dy
> CONFIG_VT=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_HW_CONSOLE=3Dy
> CONFIG_SERIAL_NONSTANDARD=3Dy
> CONFIG_ROCKETPORT=3Dm
> CONFIG_MOXA_SMARTIO=3Dm
> CONFIG_SERIAL_8250=3Dy
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_SERIAL_8250_NR_UARTS=3D4
> CONFIG_SERIAL_8250_EXTENDED=3Dy
> CONFIG_SERIAL_8250_MANY_PORTS=3Dy
> CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
> CONFIG_SERIAL_8250_DETECT_IRQ=3Dy
> CONFIG_SERIAL_CORE=3Dy
> CONFIG_SERIAL_CORE_CONSOLE=3Dy
> CONFIG_UNIX98_PTYS=3Dy
> CONFIG_PRINTER=3Dm
> CONFIG_LP_CONSOLE=3Dy
> CONFIG_PPDEV=3Dm
> CONFIG_HW_RANDOM=3Dy
> CONFIG_NVRAM=3Dy
> CONFIG_RTC=3Dy
> CONFIG_AGP=3Dm
> CONFIG_AGP_INTEL=3Dm
> CONFIG_AGP_NVIDIA=3Dm
> CONFIG_AGP_VIA=3Dm
> CONFIG_AGP_EFFICEON=3Dm
> CONFIG_DRM=3Dm
> CONFIG_DRM_I810=3Dm
> CONFIG_DRM_I830=3Dm
> CONFIG_DRM_I915=3Dm
> CONFIG_DRM_MGA=3Dm
> CONFIG_RAW_DRIVER=3Dm
> CONFIG_MAX_RAW_DEVS=3D256
> CONFIG_HANGCHECK_TIMER=3Dy
> CONFIG_FB=3Dy
> CONFIG_FB_CFB_FILLRECT=3Dy
> CONFIG_FB_CFB_COPYAREA=3Dy
> CONFIG_FB_CFB_IMAGEBLIT=3Dy
> CONFIG_FB_SOFT_CURSOR=3Dy
> CONFIG_FB_MODE_HELPERS=3Dy
> CONFIG_FB_TILEBLITTING=3Dy
> CONFIG_FB_VESA=3Dy
> CONFIG_VIDEO_SELECT=3Dy
> CONFIG_FB_HGA=3Dm
> CONFIG_FB_RIVA=3Dm
> CONFIG_FB_I810=3Dm
> CONFIG_FB_I810_GTF=3Dy
> CONFIG_FB_INTEL=3Dm
> CONFIG_FB_MATROX=3Dm
> CONFIG_FB_MATROX_MILLENIUM=3Dy
> CONFIG_FB_MATROX_MYSTIQUE=3Dy
> CONFIG_FB_MATROX_G=3Dy
> CONFIG_FB_MATROX_MULTIHEAD=3Dy
> CONFIG_FB_SAVAGE=3Dm
> CONFIG_FB_SIS=3Dm
> CONFIG_FB_SIS_300=3Dy
> CONFIG_FB_SIS_315=3Dy
> CONFIG_VGA_CONSOLE=3Dy
> CONFIG_MDA_CONSOLE=3Dm
> CONFIG_DUMMY_CONSOLE=3Dy
> CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> CONFIG_FONT_8x8=3Dy
> CONFIG_FONT_8x16=3Dy
> CONFIG_SOUND=3Dm
> CONFIG_SND=3Dm
> CONFIG_SND_TIMER=3Dm
> CONFIG_SND_PCM=3Dm
> CONFIG_SND_RAWMIDI=3Dm
> CONFIG_SND_SEQUENCER=3Dm
> CONFIG_SND_OSSEMUL=3Dy
> CONFIG_SND_MIXER_OSS=3Dm
> CONFIG_SND_PCM_OSS=3Dm
> CONFIG_SND_SEQUENCER_OSS=3Dy
> CONFIG_SND_RTCTIMER=3Dm
> CONFIG_SND_MPU401_UART=3Dm
> CONFIG_SND_AC97_CODEC=3Dm
> CONFIG_SND_INTEL8X0=3Dm
> CONFIG_SND_INTEL8X0M=3Dm
> CONFIG_SND_VIA82XX=3Dm
> CONFIG_USB_ARCH_HAS_HCD=3Dy
> CONFIG_USB_ARCH_HAS_OHCI=3Dy
> CONFIG_USB=3Dm
> CONFIG_USB_DEBUG=3Dy
> CONFIG_USB_DEVICEFS=3Dy
> CONFIG_USB_EHCI_HCD=3Dm
> CONFIG_USB_OHCI_HCD=3Dm
> CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
> CONFIG_USB_UHCI_HCD=3Dm
> CONFIG_USB_STORAGE=3Dm
> CONFIG_USB_STORAGE_DATAFAB=3Dy
> CONFIG_USB_STORAGE_FREECOM=3Dy
> CONFIG_USB_STORAGE_ISD200=3Dy
> CONFIG_USB_STORAGE_DPCM=3Dy
> CONFIG_USB_STORAGE_SDDR09=3Dy
> CONFIG_USB_STORAGE_SDDR55=3Dy
> CONFIG_USB_STORAGE_JUMPSHOT=3Dy
> CONFIG_USB_HID=3Dm
> CONFIG_USB_HIDINPUT=3Dy
> CONFIG_USB_MON=3Dm
> CONFIG_EXT2_FS=3Dy
> CONFIG_EXT2_FS_XATTR=3Dy
> CONFIG_EXT2_FS_POSIX_ACL=3Dy
> CONFIG_EXT2_FS_SECURITY=3Dy
> CONFIG_EXT3_FS=3Dy
> CONFIG_EXT3_FS_XATTR=3Dy
> CONFIG_EXT3_FS_POSIX_ACL=3Dy
> CONFIG_EXT3_FS_SECURITY=3Dy
> CONFIG_JBD=3Dy
> CONFIG_FS_MBCACHE=3Dy
> CONFIG_REISERFS_FS=3Dy
> CONFIG_REISERFS_PROC_INFO=3Dy
> CONFIG_FS_POSIX_ACL=3Dy
> CONFIG_MINIX_FS=3Dy
> CONFIG_ROMFS_FS=3Dy
> CONFIG_DNOTIFY=3Dy
> CONFIG_AUTOFS_FS=3Dm
> CONFIG_AUTOFS4_FS=3Dm
> CONFIG_ISO9660_FS=3Dy
> CONFIG_JOLIET=3Dy
> CONFIG_ZISOFS=3Dy
> CONFIG_ZISOFS_FS=3Dy
> CONFIG_UDF_FS=3Dm
> CONFIG_UDF_NLS=3Dy
> CONFIG_FAT_FS=3Dy
> CONFIG_MSDOS_FS=3Dy
> CONFIG_VFAT_FS=3Dy
> CONFIG_FAT_DEFAULT_CODEPAGE=3D437
> CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
> CONFIG_NTFS_FS=3Dm
> CONFIG_NTFS_RW=3Dy
> CONFIG_PROC_FS=3Dy
> CONFIG_PROC_KCORE=3Dy
> CONFIG_SYSFS=3Dy
> CONFIG_DEVFS_FS=3Dy
> CONFIG_TMPFS=3Dy
> CONFIG_TMPFS_XATTR=3Dy
> CONFIG_TMPFS_SECURITY=3Dy
> CONFIG_HUGETLBFS=3Dy
> CONFIG_HUGETLB_PAGE=3Dy
> CONFIG_RAMFS=3Dy
> CONFIG_CRAMFS=3Dy
> CONFIG_UFS_FS=3Dm
> CONFIG_NFS_FS=3Dy
> CONFIG_NFS_V3=3Dy
> CONFIG_NFS_V4=3Dy
> CONFIG_NFSD=3Dm
> CONFIG_NFSD_V3=3Dy
> CONFIG_NFSD_V4=3Dy
> CONFIG_NFSD_TCP=3Dy
> CONFIG_ROOT_NFS=3Dy
> CONFIG_LOCKD=3Dy
> CONFIG_LOCKD_V4=3Dy
> CONFIG_EXPORTFS=3Dm
> CONFIG_SUNRPC=3Dy
> CONFIG_SUNRPC_GSS=3Dy
> CONFIG_RPCSEC_GSS_KRB5=3Dy
> CONFIG_SMB_FS=3Dm
> CONFIG_CIFS=3Dy
> CONFIG_CIFS_STATS=3Dy
> CONFIG_MSDOS_PARTITION=3Dy
> CONFIG_NLS=3Dy
> CONFIG_NLS_DEFAULT=3D"iso8859-1"
> CONFIG_NLS_CODEPAGE_437=3Dm
> CONFIG_NLS_CODEPAGE_737=3Dm
> CONFIG_NLS_CODEPAGE_775=3Dm
> CONFIG_NLS_CODEPAGE_850=3Dm
> CONFIG_NLS_CODEPAGE_852=3Dm
> CONFIG_NLS_CODEPAGE_855=3Dm
> CONFIG_NLS_CODEPAGE_857=3Dm
> CONFIG_NLS_CODEPAGE_860=3Dm
> CONFIG_NLS_CODEPAGE_861=3Dm
> CONFIG_NLS_CODEPAGE_862=3Dm
> CONFIG_NLS_CODEPAGE_863=3Dm
> CONFIG_NLS_CODEPAGE_864=3Dm
> CONFIG_NLS_CODEPAGE_865=3Dm
> CONFIG_NLS_CODEPAGE_866=3Dm
> CONFIG_NLS_CODEPAGE_869=3Dm
> CONFIG_NLS_CODEPAGE_936=3Dm
> CONFIG_NLS_CODEPAGE_950=3Dm
> CONFIG_NLS_CODEPAGE_932=3Dm
> CONFIG_NLS_CODEPAGE_949=3Dm
> CONFIG_NLS_CODEPAGE_874=3Dm
> CONFIG_NLS_ISO8859_8=3Dm
> CONFIG_NLS_CODEPAGE_1250=3Dm
> CONFIG_NLS_CODEPAGE_1251=3Dm
> CONFIG_NLS_ASCII=3Dm
> CONFIG_NLS_ISO8859_1=3Dm
> CONFIG_NLS_ISO8859_2=3Dm
> CONFIG_NLS_ISO8859_3=3Dm
> CONFIG_NLS_ISO8859_4=3Dm
> CONFIG_NLS_ISO8859_5=3Dm
> CONFIG_NLS_ISO8859_6=3Dm
> CONFIG_NLS_ISO8859_7=3Dm
> CONFIG_NLS_ISO8859_9=3Dm
> CONFIG_NLS_ISO8859_13=3Dm
> CONFIG_NLS_ISO8859_14=3Dm
> CONFIG_NLS_ISO8859_15=3Dm
> CONFIG_NLS_KOI8_R=3Dm
> CONFIG_NLS_KOI8_U=3Dm
> CONFIG_NLS_UTF8=3Dm
> CONFIG_PROFILING=3Dy
> CONFIG_OPROFILE=3Dm
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_MAGIC_SYSRQ=3Dy
> CONFIG_LOG_BUF_SHIFT=3D15
> CONFIG_SCHEDSTATS=3Dy
> CONFIG_DEBUG_SPINLOCK_SLEEP=3Dy
> CONFIG_DEBUG_FS=3Dy
> CONFIG_FRAME_POINTER=3Dy
> CONFIG_EARLY_PRINTK=3Dy
> CONFIG_DEBUG_STACKOVERFLOW=3Dy
> CONFIG_KPROBES=3Dy
> CONFIG_DEBUG_STACK_USAGE=3Dy
> CONFIG_X86_FIND_SMP_CONFIG=3Dy
> CONFIG_X86_MPPARSE=3Dy
> CONFIG_CRYPTO=3Dy
> CONFIG_CRYPTO_HMAC=3Dy
> CONFIG_CRYPTO_NULL=3Dm
> CONFIG_CRYPTO_MD4=3Dm
> CONFIG_CRYPTO_MD5=3Dy
> CONFIG_CRYPTO_SHA1=3Dm
> CONFIG_CRYPTO_SHA256=3Dm
> CONFIG_CRYPTO_SHA512=3Dm
> CONFIG_CRYPTO_WP512=3Dm
> CONFIG_CRYPTO_TGR192=3Dm
> CONFIG_CRYPTO_DES=3Dy
> CONFIG_CRYPTO_BLOWFISH=3Dm
> CONFIG_CRYPTO_TWOFISH=3Dm
> CONFIG_CRYPTO_SERPENT=3Dm
> CONFIG_CRYPTO_AES_586=3Dm
> CONFIG_CRYPTO_CAST5=3Dm
> CONFIG_CRYPTO_CAST6=3Dm
> CONFIG_CRYPTO_TEA=3Dm
> CONFIG_CRYPTO_ARC4=3Dm
> CONFIG_CRYPTO_KHAZAD=3Dm
> CONFIG_CRYPTO_ANUBIS=3Dm
> CONFIG_CRYPTO_DEFLATE=3Dm
> CONFIG_CRYPTO_MICHAEL_MIC=3Dm
> CONFIG_CRYPTO_CRC32C=3Dm
> CONFIG_CRYPTO_TEST=3Dm
> CONFIG_CRYPTO_DEV_PADLOCK=3Dm
> CONFIG_CRYPTO_DEV_PADLOCK_AES=3Dy
> CONFIG_CRC_CCITT=3Dy
> CONFIG_CRC32=3Dy
> CONFIG_LIBCRC32C=3Dm
> CONFIG_ZLIB_INFLATE=3Dy
> CONFIG_ZLIB_DEFLATE=3Dm
> CONFIG_GENERIC_HARDIRQS=3Dy
> CONFIG_GENERIC_IRQ_PROBE=3Dy
> CONFIG_X86_SMP=3Dy
> CONFIG_X86_HT=3Dy
> CONFIG_X86_BIOS_REBOOT=3Dy
> CONFIG_X86_TRAMPOLINE=3Dy

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

God, root, what is difference?
					-- Pitr
User Friendly, 11/11/1999

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCsSwGHL9iwnUZqnkRAti0AKCu4kMfh/D9WDjn1p0N4OZ/8gTlLACgh69g
Y2y6izoGXXpKZlmig91ex0A=
=ecuS
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
