Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUGDGG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUGDGG0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 02:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbUGDGG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 02:06:26 -0400
Received: from marc2.theaimsgroup.com ([63.238.77.172]:20382 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id S265395AbUGDGGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 02:06:24 -0400
Date: Sun, 4 Jul 2004 02:06:03 -0400 (EDT)
From: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
cc: Paul Rolland <rol@as2917.net>
Message-ID: <010407040202350.28954@timmy.spinoli.org>
X-Marks-The: Spot
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2004-07-04, "Paul Rolland" <rol@as2917.net> wrote:

> Configuration is quite simple : at the LILO prompt, I key in :
> LILO: linux console=ttyS0 -s
>
> This is supposed to start Linux, and have the console on ttyS0.
>
> The problem is that the bash prompt ends on the monitor, not on the
> serial port.

The lilo console redirection means boot messages, etc will go to the
serial port.  But they don't necessarily mean a login prompt will be
spawned on the console.  For that, you also want an entry in
/etc/inittab (depending on distro, there's probably one there already,
commented out):

s1:12345:respawn:/sbin/agetty -L 9600 ttyS0 vt100

...Change the speed if necessary.  Make sure that runlevel 1 is
included--that's single user mode.  You should probably also make sure
that ttyS0 is uncommented in /etc/securetty (or root logins on the
serial console won't be allowed).


If you've got no physical access to the box other than the serial
console, you can't very well boot it and log in at the keyboard in order
to edit /etc/inittab.  In that case, boot with:

LILO: linux console=ttyS0 init=/bin/sh

That will boot the system in a *very* minimal state, and will (probably ;)
give you a text console on the serial port, from which you can remount /
read-write ('mount -n -o remount,rw /') and mount any other local
filesystems ('mount -a -v -t nonfs,nosmbfs').  From there, you can vi
/etc/inittab and /etc/securetty.  Save, remount / readonly
('mount -o remount,ro /') and reboot--probably with '/sbin/reboot -f',
since init isn't there to run shutdown scripts, and you can't feed a
ctl-alt-del down the serial port.

HTH,

Hank Leininger <hlein@progressive-comp.com>
E407 AEF4 761E D39C D401  D4F4 22F8 EF11 861A A6F1
-----BEGIN PGP SIGNATURE-----

iD8DBQFA555LIvjvEYYapvERAk3XAJ9JdBWRL6fSIlZafeugeT9Yufp+qgCghCsG
QS3ZV9/9G3NbJ2jMFPRwydY=
=KWwJ
-----END PGP SIGNATURE-----
