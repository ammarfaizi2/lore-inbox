Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbTGAWLo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 18:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbTGAWLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 18:11:44 -0400
Received: from enterprise.dogan.ch ([213.144.137.42]:20641 "EHLO
	enterprise.dogan.ch") by vger.kernel.org with ESMTP id S264060AbTGAWLl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 18:11:41 -0400
Date: Wed, 2 Jul 2003 00:25:58 +0200
From: Attila Kinali <kinali@gmx.net>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cdrom blocksize reset bug with 2.4.x kernels
Message-Id: <20030702002558.7faf6c88.kinali@gmx.net>
Organization: NERV
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__2_Jul_2003_00:25:58_+0200_08bb4dc8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Wed__2_Jul_2003_00:25:58_+0200_08bb4dc8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

After some discussion on the mplayer-users mailinglist about
that for some scsi drives it's impossible to read a data cd
after reading a vcd/scvd until the next reboot.
(see http://mplayerhq.hu/pipermail/mplayer-users/2002-December/025696.html)

I found that there is a reset of the cdrom block size needed
for those drives which doesnt restet it themselfs if a new
cd is put in (looks like only a few scsi cdroms are affected)

Attached is a small patch for drivers/cdrom/cdrom.c that fixes=20
this for the 2.4.20 kernel (and also for 2.4.21 as the code didn't
change). It's reseting the blocksize when a cdrom is opened for
the first time (meaning that a umount/mount cycle can reset
the blocksize).

I run this code now for about half a year and didnt have any problems.
But, as i didnt get any feadback from other people, i'm not sure if
everything is correct.

Greetings
			Attila Kinali

--=20
Emacs ist f=FCr mich kein Editor. F=FCr mich ist das genau das gleiche, als=
 wenn
ich nach einem Fahrrad (f=FCr die Sonntagbr=F6tchen) frage und einen pangal=
aktischen
Raumkreuzer mit 10 km Gesamtl=E4nge bekomme. Ich wei=DF nicht, was ich dami=
t soll.
		-- Frank Klemm, de.comp.os.unix.discussion

--Multipart_Wed__2_Jul_2003_00:25:58_+0200_08bb4dc8
Content-Type: application/octet-stream;
 name="cdrom-blocksize.patch"
Content-Disposition: attachment;
 filename="cdrom-blocksize.patch"
Content-Transfer-Encoding: base64

LS0tIGNkcm9tLmMub3JpZwkyMDAzLTAxLTA1IDE1OjAyOjUzLjAwMDAwMDAwMCArMDEwMAorKysg
Y2Ryb20uYwkyMDAzLTAxLTA1IDE1OjA1OjQ0LjAwMDAwMDAwMCArMDEwMApAQCAtNDc1LDcgKzQ3
NSwxNSBAQAogCWVsc2UKIAkJcmV0ID0gb3Blbl9mb3JfZGF0YShjZGkpOwogCi0JaWYgKCFyZXQp
IGNkaS0+dXNlX2NvdW50Kys7CisJaWYgKCFyZXQpCisJeworCQljZGktPnVzZV9jb3VudCsrOwor
CQlpZihjZGktPnVzZV9jb3VudCA9PSAxKQorCQl7CisJCQkvKiByZXNldCBibG9ja3NpemUgaW4g
Y2FzZSBpdCdzIHdyb25nICovCisJCQljZHJvbV9zd2l0Y2hfYmxvY2tzaXplKGNkaSxDRF9GUkFN
RVNJWkUpOworCQl9CisJfQogCiAJY2RpbmZvKENEX09QRU4sICJVc2UgY291bnQgZm9yIFwiL2Rl
di8lc1wiIG5vdyAlZFxuIiwgY2RpLT5uYW1lLCBjZGktPnVzZV9jb3VudCk7CiAJLyogRG8gdGhp
cyBvbiBvcGVuLiAgRG9uJ3Qgd2FpdCBmb3IgbW91bnQsIGJlY2F1c2UgdGhleSBtaWdodAo=

--Multipart_Wed__2_Jul_2003_00:25:58_+0200_08bb4dc8--
