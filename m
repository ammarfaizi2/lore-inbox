Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUBAJ2t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 04:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265242AbUBAJ2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 04:28:48 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:39653 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S265238AbUBAJ2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 04:28:46 -0500
To: linux-kernel@vger.kernel.org
CC: rusty@rustcorp.com.au
Subject: Re: net-pf-10, 2.6.1
Message-Id: <E1AnDuR-0000Jj-00@toraigh>
From: Jim McCloskey <mcclosk@ucsc.edu>
Date: Sun, 01 Feb 2004 01:28:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--text follows this line--

* On Sat Jan 31 2004 - 21:36:58 EST, Steve Youngs wrote:

|>  > |> > install net-pf-10 /bin/true 
|>
|> This _is_ what you want in your modprobe.conf file. Or possibly
|> `install net-pf-10-* /bin/true', but I'm pretty sure that Rusty has
|> added some backward compatibility code so that either _should_ work.
|>
|> The other thing that you need to do once you have updated
|> modprobe.conf is to run `depmod' to regenerate the dependency
|> files.

I've tried the variations I can think of---putting the line:

   install net-pf-10 /bin/true

in /lib/modules/modprobe.conf via update-modules, or directly by hand-editing.
Then depmod; then reboot. Also:

   install net-pf-10-* /bin/true
   install net-pf-* /bin/true

All variations still lead to:

Jan 31 23:08:01 ohlone kernel: request_module: failed /sbin/modprobe -- net-pf-10. error = 256
Jan 31 23:23:01 ohlone kernel: request_module: failed /sbin/modprobe -- net-pf-10. error = 256

on each run of exim from cron (Debian exim has ipv6 support compiled
in). If I run modprobe manually, I get:

   ohlone#  modprobe net-pf-10
   FATAL: Module ipv6 not found.

indicating that modprobe knows about the alias, but is not running
/bin/true when requested to load the module.

However: if I manually edit /etc/modprobe.d/aliases (which you're not
supposed to do), so as to comment out:

  # alias net-pf-10 ipv6

and then add:

  install ipv6 /bin/true

(update-modules; depmod; reboot), `modprobe ipv6' from the
command-line completes silently and without error (but without loading
the module, of course, since it doesn't exist). Which I think is the
expected behaviour.

But even at that point, in the logs we still get:

Feb  1 00:53:01 ohlone /USR/SBIN/CRON[280]: (mail) CMD (  if [ -x /usr/lib/exim/exim3 -a -f /etc/exim/exim.conf ]; then /usr/lib/exim/exim3 -q ; fi)
Feb  1 00:53:01 ohlone kernel: request_module: failed /sbin/modprobe -- net-pf-10. error = 256

(because exim is trying to load the module under the name net-pf-10??)

Here are some pointers to what seems to be the same or a similar problem:

http://www.mail-archive.com/debian-user-german@lists.debian.org/msg66557.html
http://www.spinics.net/lists/kernel/msg236360.html
http://lkml.org/lkml/2004/1/13/72
http://forum.hardware.fr/hardwarefr/OSAlternatifs/citer-24424-387523-58.htm

Oh well, it is a very small problem (all it does is clutter the
log-files). Thanks very much to all who helped,

Jim
