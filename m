Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUKAEoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUKAEoR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 23:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbUKAEoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 23:44:17 -0500
Received: from ctb-mesg1.saix.net ([196.25.240.73]:52644 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S261300AbUKAEml
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 23:42:41 -0500
Subject: XMMS (or some other audio player) 'hang' issues with intel8x0 and
	dmix plugin [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5bsxmWssO+p9xvgdFom9"
Date: Mon, 01 Nov 2004 06:42:21 +0200
Message-Id: <1099284142.11924.17.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5bsxmWssO+p9xvgdFom9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I have mailed below to alsa-user a time or two already, but no
response as of yet, so I am wondering if anybody here have had
similar issues.  Not much has changed, but I have also tried
BMP, and alsa-player, with similar results.

-----------

I have a Asus P4C800-E with a SoundMax 1985 audio chip on.
Alsa-lib-1.0.[56] and 2.6.[6789] kernel.  I have dmix setup (.asoundrc
below).

Now I mostly use XMMS for playing mp3's, and intermittently xmms
will just 'hang'.  It is not locked or anything, but the 'graph'
just stand still, and no audio.  If I press play again, it starts
to play for some time again.  This is especially easy to duplicate
if the box is under heavy load.  If I use the device directly,
without the dmix plugin, it works fine, or if I use oss emulation,
it works fine as well ...

If any more info is needed, let me know.  My .asoundrc and a strace
of XMMS pid follows.


My .asoundrc looks like this:

---
pcm.!default {
    type plug
    slave.pcm "asymed"
}

pcm.dsp0 {
    type plug
    slave.pcm "asymed"
}

ctl.mixer0 {
    type hw
    card 0
}

pcm.asymed {
    type asym
    playback.pcm "dmixer"
    capture.pcm "mixin"
}

pcm.dmixer  {
    type dmix
    ipc_key 1025
    slave {
        pcm "hw:0,0"
#        period_time 0
#        period_size 1024
#        buffer_size 4096
#        periods 128
#        rate 48000
    }
    bindings {
        0 0
        1 1
    }
}

pcm.mixin {
    type dsnoop
    ipc_key 1026
    ipc_key_add_uid yes
    slave {
        pcm "hw:0,0"
        channels 2
#        period_size 1024
#        buffer_size 4096
#        rate 48000
#        periods 0
#        period_time 0
    }
    bindings {
        0 0
        0 1
    }
}
---

And a strace of the xmms pid something like this (keeps looping,
and stops for a few seconds at every other poll):

---
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 0) =3D 0
gettimeofday({1090098067, 90349}, NULL) =3D 0
gettimeofday({1090098067, 90384}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0\240\2\0\0L\0\20"..., 116)=
 =3D 116
read(3, "\1\2\257\376\0\0\0\0\22\0\240\2\0\0\0\0\0\0\0\0\1\0\0\0"..., 32) =
=3D 32
gettimeofday({1090098067, 90817}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098067, 101150}, NULL) =3D 0
gettimeofday({1090098067, 101214}, NULL) =3D 0
gettimeofday({1090098067, 101275}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 8) =3D 0
gettimeofday({1090098067, 110151}, NULL) =3D 0
gettimeofday({1090098067, 110194}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 0) =3D 0
gettimeofday({1090098067, 110350}, NULL) =3D 0
gettimeofday({1090098067, 110387}, NULL) =3D 0
gettimeofday({1090098067, 110485}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0\0\2\20\0L\0\20"..., 40) =
=3D 40
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098067, 120150}, NULL) =3D 0
gettimeofday({1090098067, 120191}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 0) =3D 0
gettimeofday({1090098067, 120345}, NULL) =3D 0
write(3, ">\3\7\0\213\7\300\2\32\0\300\0029\0\300\2\253\0\0\0p\0"..., 76) =
=3D 76
read(3, "\1\2\264\376\0\0\0\0\22\0\240\2\0\0\0\0\0\0\0\0\1\0\0\0"..., 32) =
=3D 32
gettimeofday({1090098067, 120680}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098067, 130139}, NULL) =3D 0
gettimeofday({1090098067, 130176}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 0) =3D 0
gettimeofday({1090098067, 130319}, NULL) =3D 0
gettimeofday({1090098067, 130353}, NULL) =3D 0
gettimeofday({1090098067, 130438}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0P\2\20\0L\0\20\0"..., 40) =
=3D 40
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098071, 727050}, NULL) =3D 0
gettimeofday({1090098071, 727116}, NULL) =3D 0
gettimeofday({1090098071, 727154}, NULL) =3D 0
gettimeofday({1090098071, 727261}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0\240\2\20\0L\0\20"..., 40)=
 =3D 40
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098071, 738803}, NULL) =3D 0
gettimeofday({1090098071, 738864}, NULL) =3D 0
write(3, ">\3\7\0\213\7\300\2\32\0\300\0029\0\300\2\254\0\0\0p\0"..., 76) =
=3D 76
read(3, "\1\2\272\376\0\0\0\0\22\0\240\2\0\0\0\0\0\0\0\0\1\0\0\0"..., 32) =
=3D 32
gettimeofday({1090098071, 739165}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098071, 750043}, NULL) =3D 0
gettimeofday({1090098071, 750108}, NULL) =3D 0
gettimeofday({1090098071, 750145}, NULL) =3D 0
gettimeofday({1090098071, 750249}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0\0\2 \0L\0\20\0"..., 40) =
=3D 40
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 6) =3D 0
gettimeofday({1090098071, 758043}, NULL) =3D 0
gettimeofday({1090098071, 758090}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 1) =3D 0
gettimeofday({1090098071, 760033}, NULL) =3D 0
gettimeofday({1090098071, 760075}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 0) =3D 0
gettimeofday({1090098071, 760254}, NULL) =3D 0
write(3, ">\3\7\0\213\7\300\2\32\0\300\0029\0\300\2\255\0\0\0p\0"..., 76) =
=3D 76
read(3, "\1\2\277\376\0\0\0\0\22\0\240\2\0\0\0\0\0\0\0\0\1\0\0\0"..., 32) =
=3D 32
gettimeofday({1090098071, 760592}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098071, 776028}, NULL) =3D 0
gettimeofday({1090098071, 776093}, NULL) =3D 0
gettimeofday({1090098071, 776128}, NULL) =3D 0
gettimeofday({1090098071, 776232}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0P\2 \0L\0\20\0\30"..., 40)=
 =3D 40
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098071, 809155}, NULL) =3D 0
gettimeofday({1090098071, 809234}, NULL) =3D 0
gettimeofday({1090098071, 809273}, NULL) =3D 0
read(15, 0xbfffe850, 72)                =3D -1 EAGAIN (Resource temporarily=
 unavailable)
gettimeofday({1090098071, 809426}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0\240\2 \0L\0\20"..., 40) =
=3D 40
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098071, 820034}, NULL) =3D 0
gettimeofday({1090098071, 820103}, NULL) =3D 0
write(3, ">\3\7\0\213\7\300\2\32\0\300\0029\0\300\2\256\0\0\0p\0"..., 76) =
=3D 76
read(3, "\1\2\305\376\0\0\0\0\22\0\240\2\0\0\0\0\0\0\0\0\1\0\0\0"..., 32) =
=3D 32
gettimeofday({1090098071, 820476}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098071, 831020}, NULL) =3D 0
gettimeofday({1090098071, 831083}, NULL) =3D 0
gettimeofday({1090098071, 831119}, NULL) =3D 0
gettimeofday({1090098071, 831223}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0\0\0020\0L\0\20"..., 40) =
=3D 40
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 7) =3D 0
gettimeofday({1090098071, 840020}, NULL) =3D 0
gettimeofday({1090098071, 840066}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 0) =3D 0
gettimeofday({1090098071, 840250}, NULL) =3D 0
write(3, ">\3\7\0\213\7\300\2\32\0\300\0029\0\300\2\257\0\0\0p\0"..., 76) =
=3D 76
read(3, "\1\2\312\376\0\0\0\0\22\0\240\2\0\0\0\0\0\0\0\0\1\0\0\0"..., 32) =
=3D 32
gettimeofday({1090098071, 840586}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098071, 852096}, NULL) =3D 0
gettimeofday({1090098071, 852161}, NULL) =3D 0
gettimeofday({1090098071, 852211}, NULL) =3D 0
gettimeofday({1090098071, 852306}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0P\0020\0L\0\20\0"..., 40) =
=3D 40
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098071, 864690}, NULL) =3D 0
gettimeofday({1090098071, 864754}, NULL) =3D 0
gettimeofday({1090098071, 864817}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 5) =3D 0
gettimeofday({1090098071, 871014}, NULL) =3D 0
gettimeofday({1090098071, 871057}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 3) =3D 0
gettimeofday({1090098071, 875023}, NULL) =3D 0
gettimeofday({1090098071, 875094}, NULL) =3D 0
gettimeofday({1090098071, 875135}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0\240\0020\0L\0\20"..., 88)=
 =3D 88
read(3, "\1\2\317\376\0\0\0\0\22\0\240\2\0\0\0\0\0\0\0\0\1\0\0\0"..., 32) =
=3D 32
gettimeofday({1090098071, 875567}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
select(4, [3], NULL, NULL, {0, 0})      =3D 0 (Timeout)
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098071, 904090}, NULL) =3D 0
gettimeofday({1090098071, 904151}, NULL) =3D 0
gettimeofday({1090098071, 904197}, NULL) =3D 0
gettimeofday({1090098071, 904288}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0\0\3\0\0L\0\20\0"..., 40) =
=3D 40
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098071, 915044}, NULL) =3D 0
gettimeofday({1090098071, 915135}, NULL) =3D 0
write(3, ">\3\7\0\213\7\300\2\32\0\300\0029\0\300\2\1\0\0\0p\0\31"..., 48) =
=3D 48
read(3, "\1\2\323\376\0\0\0\0\22\0\240\2\0\0\0\0\0\0\0\0\1\0\0\0"..., 32) =
=3D 32
gettimeofday({1090098071, 915546}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098071, 932763}, NULL) =3D 0
gettimeofday({1090098071, 932831}, NULL) =3D 0
gettimeofday({1090098071, 932869}, NULL) =3D 0
gettimeofday({1090098071, 932976}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0P\3\0\0L\0\20\0"..., 40) =
=3D 40
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 1) =3D 0
gettimeofday({1090098071, 935996}, NULL) =3D 0
gettimeofday({1090098071, 936049}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 6) =3D 0
gettimeofday({1090098071, 943001}, NULL) =3D 0
gettimeofday({1090098071, 943068}, NULL) =3D 0
write(3, ">\3\7\0\213\7\300\2\32\0\300\0029\0\300\2\2\0\0\0p\0\31"..., 48) =
=3D 48
read(3, "\1\2\327\376\0\0\0\0\22\0\240\2\0\0\0\0\0\0\0\0\1\0\0\0"..., 32) =
=3D 32
gettimeofday({1090098071, 943424}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098071, 954008}, NULL) =3D 0
gettimeofday({1090098071, 954069}, NULL) =3D 0
gettimeofday({1090098071, 954103}, NULL) =3D 0
read(15, 0xbfffe850, 72)                =3D -1 EAGAIN (Resource temporarily=
 unavailable)
gettimeofday({1090098071, 954256}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0\240\3\0\0L\0\20"..., 40) =
=3D 40
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098071, 968303}, NULL) =3D 0
gettimeofday({1090098071, 968368}, NULL) =3D 0
gettimeofday({1090098071, 968408}, NULL) =3D 0
gettimeofday({1090098071, 968516}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0\0\3\20\0L\0\20"..., 40) =
=3D 40
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098072, 2636}, NULL)  =3D 0
gettimeofday({1090098072, 2699}, NULL)  =3D 0
gettimeofday({1090098072, 2736}, NULL)  =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0P\3\20\0L\0\20\0"..., 88) =
=3D 88
read(3, "\1\2\335\376\0\0\0\0\22\0\240\2\0\0\0\0\0\0\0\0\1\0\0\0"..., 32) =
=3D 32
gettimeofday({1090098072, 3081}, NULL)  =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098072, 13986}, NULL) =3D 0
gettimeofday({1090098072, 14056}, NULL) =3D 0
write(3, ">\3\7\0\213\7\300\2\32\0\300\0029\0\300\2\4\0\0\0p\0\31"..., 48) =
=3D 48
read(3, "\1\2\340\376\0\0\0\0\22\0\240\2\0\0\0\0\0\0\0\0\1\0\0\0"..., 32) =
=3D 32
gettimeofday({1090098072, 14404}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098072, 25462}, NULL) =3D 0
gettimeofday({1090098072, 25524}, NULL) =3D 0
gettimeofday({1090098072, 25559}, NULL) =3D 0
gettimeofday({1090098072, 25649}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0\240\3\20\0L\0\20"..., 40)=
 =3D 40
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 6) =3D 0
gettimeofday({1090098072, 32981}, NULL) =3D 0
gettimeofday({1090098072, 33028}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 2) =3D 0
gettimeofday({1090098072, 36059}, NULL) =3D 0
gettimeofday({1090098072, 36129}, NULL) =3D 0
write(3, ">\3\7\0\213\7\300\2\32\0\300\0029\0\300\2\5\0\0\0p\0\31"..., 48) =
=3D 48
read(3, "\1\2\344\376\0\0\0\0\22\0\240\2\0\0\0\0\0\0\0\0\1\0\0\0"..., 32) =
=3D 32
gettimeofday({1090098072, 36464}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098072, 46970}, NULL) =3D 0
gettimeofday({1090098072, 47034}, NULL) =3D 0
gettimeofday({1090098072, 47070}, NULL) =3D 0
gettimeofday({1090098072, 47176}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0\0\3 \0L\0\20\0"..., 40) =
=3D 40
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098072, 58798}, NULL) =3D 0
gettimeofday({1090098072, 58861}, NULL) =3D 0
gettimeofday({1090098072, 58931}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 4) =3D 0
gettimeofday({1090098072, 64932}, NULL) =3D 0
gettimeofday({1090098072, 64976}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 3) =3D 0
gettimeofday({1090098072, 68955}, NULL) =3D 0
gettimeofday({1090098072, 69020}, NULL) =3D 0
gettimeofday({1090098072, 69058}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0P\3 \0L\0\20\0\30"..., 88)=
 =3D 88
read(3, "\1\2\351\376\0\0\0\0\22\0\240\2\0\0\0\0\0\0\0\0\1\0\0\0"..., 32) =
=3D 32
gettimeofday({1090098072, 69435}, NULL) =3D 0
ioctl(3, FIONREAD, [0])                 =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=
=3DPOLLIN}], 3, 9) =3D 0
gettimeofday({1090098072, 106582}, NULL) =3D 0
gettimeofday({1090098072, 106663}, NULL) =3D 0
gettimeofday({1090098072, 106709}, NULL) =3D 0
gettimeofday({1090098072, 106836}, NULL) =3D 0
write(3, "\226\3\n\0\34\0\300\0029\0\300\2\0\6@\0\240\3 \0L\0\20"..., 40) =
=3D 40
ioctl(3, FIONREAD, [0])                 =3D 0
poll(
---

--=20
Martin Schlemmer

--=-5bsxmWssO+p9xvgdFom9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBhb6tqburzKaJYLYRAjetAJ9Zl14CU/39Z95QSedEl4qyYiruQQCghNeC
icpbnTZIF8jqSGL5q5DGwsE=
=Jjoy
-----END PGP SIGNATURE-----

--=-5bsxmWssO+p9xvgdFom9--

