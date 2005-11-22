Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbVKVBuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVKVBuw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbVKVBuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:50:52 -0500
Received: from relay16-159.bu.edu ([128.197.159.83]:47292 "EHLO
	relay16-159.bu.edu") by vger.kernel.org with ESMTP id S964842AbVKVBuv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:50:51 -0500
From: Geoff Mishkin <gmishkin@acs.bu.edu>
Reply-To: gmishkin@bu.edu
To: linux-kernel@vger.kernel.org
Subject: 2.6.14.2 kernel oops, looks acpi-related
Date: Mon, 21 Nov 2005 20:50:03 -0500
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2044071.T2ifuzm5Bu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511212050.10671.gmishkin@acs.bu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2044071.T2ifuzm5Bu
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

About once a day, since upgrading from 2.6.12.5 to 2.6.14.2, I have a probl=
em=20
with the following symptoms.  This is on a ThinkPad T42, and I'm using=20
swsusp2 2.2-rc11.

 o Kicker (the KDE panel) becomes unresponsive.  The process is still there=
,=20
but I can't kill it (even with -9).
 o My screen session gets weirded out.  Every time I open a new window insi=
de=20
of screen, or close one, I get an error at the top of my xterm saying "can'=
t=20
write /var/run/utmp" or something like this

At this point, I check dmesg and find a bunch of errors looking like this:

    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed=20
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c20f9480), AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed=20
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c20f9480), AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed=20
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c20f9480), AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed=20
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c20f9480), AE_AML_METHOD_LIMIT

It's not always the exact same error condition, but the format is always li=
ke=20
this.

At this point I reboot to clear up these problems.  What will happen is tha=
t=20
laptop_mode won't shut down properly, but I am able to kill it from another=
=20
vt with just a SIGTERM.  Then shutdown continues.

After the reboot, sometimes my touchpad will be on another device=20
node /dev/input/event# and X won't start as a result.  The touchpad still=20
works if I swich the line in xorg.conf, BUT if I reboot again the touchpad=
=20
goes back to its normal node.  This happens about half the time that I've r=
un=20
into the overall problem.

Today, for the first time that I noticed at least, I also got an oops.  Her=
e=20
it is:

Unable to handle kernel paging request at virtual address 4b87ad6e
 printing eip:
c01f6b76
*pde =3D 00000000
Oops: 0000 [#1]
Modules linked in: uhci_hcd ehci_hcd vmnet parport_pc parport vmmon arc4=20
ieee80211_crypt_wep ieee80211_crypt nfs lockd sunrpc cisco_ipsec ipt_state=
=20
iptable_filter iptable_nat ip_nat ip_conntrack iptable_mangle ip_tables=20
pcmcia yenta_socket rsrc_nonstatic pcmcia_core snd_pcm_oss snd_mixer_oss=20
snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device=20
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore=20
snd_page_alloc nls_iso8859_1 ntfs nls_base nvram usbhid usb_storage usbcore=
=20
tun e1000 evdev fglrx intel_agp agpgart rtc speedstep_centrino freq_table=20
ibm_acpi
CPU:    0
EIP:    0060:[<c01f6b76>]    Tainted: P   M  VLI
EFLAGS: 00210202   (2.6.14.2)
EIP is at acpi_ut_update_object_reference+0x26/0x140
eax: c20d75c0   ebx: 4b87ad6e   ecx: d9ff5d78   edx: db6fad84
esi: db6fad84   edi: d9ff5d78   ebp: 00000000   esp: d9ff5d74
ds: 007b   es: 007b   ss: 0068
Process acpi (pid: 24336, threadinfo=3Dd9ff4000 task=3Dd9d2b030)
Stack: 00000000 db6fac64 c210818c c210818c 00000000 db64f1c0 c01f6ca8 c2108=
18c
       00000000 c210818c c01ecd39 c210818c c210818c db64f1c0 db64f000 00000=
001
       00000009 c01e8874 db64f1c0 db64f000 db64f1c0 db64f000 c01e43d8 db64f=
1c0
Call Trace:
 [<c01f6ca8>] acpi_ut_add_reference+0x18/0x1c
 [<c01ecd39>] acpi_ex_resolve_node_to_value+0xc1/0xdc
 [<c01e8874>] acpi_ex_resolve_to_value+0x40/0x4b
 [<c01e43d8>] acpi_ds_resolve_operands+0x1e/0x38
 [<c01e3694>] acpi_ds_exec_end_op+0x1aa/0x332
 [<c01f11c6>] acpi_ps_parse_loop+0x53e/0x844
 [<c01f0b01>] acpi_ps_parse_aml+0x4e/0x1d5
 [<c01f19b2>] acpi_ps_execute_pass+0x72/0x84
 [<c01f18e2>] acpi_ps_execute_method+0x4e/0x70
 [<c01eeffd>] acpi_ns_execute_control_method+0x3e/0x4b
 [<c01eefa8>] acpi_ns_evaluate_by_handle+0x76/0x8d
 [<c01eeea5>] acpi_ns_evaluate_relative+0xa9/0xc5
 [<c01ee77f>] acpi_evaluate_object+0x10b/0x1cc
 [<c01c0003>] digest+0x73/0x110
 [<c01f93cc>] acpi_battery_get_info+0x64/0x115
 [<c01f9746>] acpi_battery_read_info+0x41/0x1e0
 [<c017f372>] seq_read+0xf2/0x2e0
 [<c015f636>] vfs_read+0xb6/0x180
 [<c015f9e1>] sys_read+0x51/0x80
 [<c0102fef>] sysenter_past_esp+0x54/0x75
Code: fe ff ff 58 c3 55 57 56 53 51 51 8b 5c 24 1c 0f b7 6c 24 20 c7 44 24 =
04=20
00 00 00 00 85 db c7 04 24 00 00 00 00 0f 84 e6 00 00 00 <80> 3b 0f 0f 84 d=
d=20
00 00 00 0f b6 43 01 83 e8 04 83 f8 10 0f 87

As you can see, it looks like there some ACPI stuff going on there.  This=20
whole thing is more of an annoyance than anything else, but I figured since=
 I=20
got an oops this time I should report it.

			--Geoff Mishkin <gmishkin@bu.edu>

--nextPart2044071.T2ifuzm5Bu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDgnlSCByDbUAKi3URAvCAAKCT1oLFWVx9gGhr33EmttST8n6oPQCfRLHA
ne37n0MaHLrICPpi8q/5sTY=
=fLHF
-----END PGP SIGNATURE-----

--nextPart2044071.T2ifuzm5Bu--
