Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUC3WzZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbUC3Wx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:53:29 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:42426 "HELO
	trinity-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S261677AbUC3WtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:49:20 -0500
X-qfilter-stat: ok
X-Analyze: Velop Mail Shield v0.0.4
X-Inova-Extscan: attachments authorized
Date: Tue, 30 Mar 2004 19:49:11 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: linux-kernel@vger.kernel.org
cc: linux-hotplug-devel@lists.sourceforge.net
Subject: udev related ? (Was Re: rmmod deadlocks with 2.6.5-rc[2,3])
In-Reply-To: <Pine.LNX.4.58.0403301606180.352@pervalidus.dyndns.org>
Message-ID: <Pine.LNX.4.58.0403301938450.1237@pervalidus.dyndns.org>
References: <Pine.LNX.4.58.0403301529590.1233@pervalidus.dyndns.org>
 <406996C2.4030204@reactivated.net> <Pine.LNX.4.58.0403301606180.352@pervalidus.dyndns.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1225865561-1080686951=:1237"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-1225865561-1080686951=:1237
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

OK, I gave 2.6.3-rc3-mm1 a try and could reproduce it.

I still compile with CONFIG_DEVFS_FS=3Dy and
CONFIG_DEVFS_MOUNT=3Dy, but to use udev boot with devfs=3Dnomount.

I then booted with devfs=3Dmount acpi=3Doff noapic. Guess what ? I
was able to unmount all offending modules.

What next ? Boot with devfs=3Dmount to see if ACPI was to blame.
No, it wasn't.

My /etc/rc.d/rc.S is very simple:

[ -e /dev/.devfsd -a -x /sbin/devfsd ] && devfsd /dev

(only run devfsd if devfs is mounted)

mount -vn -t proc proc /proc # Needed for LABEL=3D in /etc/fstab

mount -vn -t sysfs sysfs /sys

[ ! -e /dev/.devfsd -a -d /sys/block ] && /etc/rc.d/start_udev

(only run start_udev if devfs isn't mounted and sysfs is
mounted)

Since 2.6.4 works fine for me using devfs=3Dnomount, something is
broken. I'm using the latest udev and hotplug.

I'm attaching a strace of a rmmod that failed.

On Tue, 30 Mar 2004, Fr=E9d=E9ric L. W. Meunier wrote:

> On Tue, 30 Mar 2004, Daniel Drake wrote:
>
> > Fr=E9d=E9ric L. W. Meunier wrote:
> > > If I boot with 2.6.5-rc[2,3] and use rmmod snd_via82xx or rmmod
> > > ohci_hcd (it doesn't happen with all modules), rmmod deadlocks.
> > > 2.6.4 works fine.
> >
> > The ohci_hcd problem should be temporarily fixed by a recent
> > patch to this list, from Greg KH (subject: [PATCH] USB:
> > Eliminate wait following interface unregistration). This
> > worked for me.
>
> I forgot to report that I don't need OHCI. It's hotplug which
> loads it for some reason under 2.6, but not under 2.4.
>
> > As for the snd_ modules, this is a different problem, which I
> > am still experiencing. I have had it with both snd_emu10k1
> > and snd_intel8x0 - but it does not happen every time. I have
> > experienced it on 2.6.5-rc2 and -rc3 (plus their -mm
> > patches). rmmod hangs and doesnt respond to kill -9.
>
> I used ALSA from CVS.
>
> > Is there any output I can capture to diagnose this?
>
> Here nothing gets printed. Maybe strace can help. But I'll
> wait.
>
> It also happened removing i2c_isa when I went through removing
> all modules. Nothing wrong with joydev, adi, gameport, it87...

--=20
http://www.pervalidus.net/contact.html
--0-1225865561-1080686951=:1237
Content-Type: APPLICATION/octet-stream; name="rmmod.txt.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0403301949110.1237@pervalidus.dyndns.org>
Content-Description: 
Content-Disposition: attachment; filename="rmmod.txt.bz2"

QlpoOTFBWSZTWW2rs0IABIf/gFY8IQVYd//3L6ff7r9v/39QA946qXVu4Uo6
sJJFTanpNB6mnpNHqeo00GTQwQ0Bo0GTQGmQaCSkaNAJPBTIAABoAAAAAAAJ
TSFJpk9TBGgANNNAAaA0yZAAAAcwmgNAaNGEaDEaYmTE0GEaBkAyYCKQhMmm
mRpTapsppo2UeiaAPUDNTBpA9qIxPReB15cQccPTyE5o0AnLbMJWAASUOJ8f
49APDu86NYEAwsCQ+eRJ9XNKbCHdjSBfCPKj3+9Uo7gbvSD1Sp/mCMg5usHf
MO3oz/4zJ2yYpiEe7wq7DDZFeioJBDthUCbQHSEnQeTepm11DircjQ21hANC
nsB/oDvboN7D4oaB2JzTd0Gomt4tAtWmU08SjlJCi1svypl14IQnuxCcDTSo
MTxjX+kRK91oGoJkkknKpwQ4iadzl5wPDacwTzRYgm1aknTuJ0KUZRAsOwYt
YEyQIQkhU09lqrQYjZ4ZzEEAUcStj88daTxUXSkmJwIaO4HZ40hrqDgLt1uR
BBEQkQH2I0hkGt4APXZlOFbBQwSx7MsQD4O0Hawsu9HCEEUTL/smqaZEmGpl
hBs0F5JYLCsMVK7IKRFdWmyTJIdRaoLCp0Wm2HMQdDzI2DR9HkBFBlJTzlbG
ImVxpI56WFGoxjNFmjIFYpUpqNxHKXLkAvK7ecL4kmbAYE4h8JtmNBR5RYl6
JHyJ554aYJ70e2EWYKumVPTQ9YN9YdciHyfVe0DyXCYF1gV+oMAf2q6EgfQ6
0bAb9jJHAKMA2o4AwGAObcDaOmSwFyn0AUEMX1h6xDbjscfwDWDpKwgKAzCG
Y3B94G2ZuBrerI4ZfWkQ9ERH5duk43SaNl0YKClYzwc4U8E4R2qyG6XnBvrp
OaDsvwmh++X2BLStXSh0kIdLh1B1IWF9nHBk+Xz/+DBaGrGEbSkQS9xaUSv5
gZOOVYO72TnsYzz3v89gQHaJEzApjnvzZAUOk587Htj58kerELYU4FAo0J0p
nMxEXKFgNLOfZsB+ln2gzC/SbweQ3Rx0RxgNk7HkN40pmOlsdEFbgMrr7Goe
S0GlQbTwUp4AclOLC5xha53gxcDuBsbNVWFuQGNQOVPkrl7pZGgOQrgDSgsw
AVt4KqJGupesqZOCbgvz/E6kc5hmpoA94awwDjb5o0lVo2e8CeK0zVrZztch
QwlbAWKuGjVwxtYDiWW7TbRBGUMC+hFMQKKEJoRZV1cnWyZGujH/i7kinChI
NtXZoQA=

--0-1225865561-1080686951=:1237--
