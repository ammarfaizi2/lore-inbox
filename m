Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268268AbUHXCZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268268AbUHXCZR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 22:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268323AbUHXCZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 22:25:12 -0400
Received: from [82.154.233.25] ([82.154.233.25]:46721 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S268268AbUHXCWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 22:22:09 -0400
Message-ID: <412AA656.7030607@vgertech.com>
Date: Tue, 24 Aug 2004 03:22:14 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040528 Thunderbird/0.6 Mnenhy/0.6.0.103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <m37jrr40zi.fsf@zoo.weinigel.se><m37jrr40zi.fsf@zoo.weinigel.se> <20040822192646.GH19768@thundrix.ch> <cgdjek$klh$1@gatekeeper.tmr.com>
In-Reply-To: <cgdjek$klh$1@gatekeeper.tmr.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Bill Davidsen wrote:
| Tonnerre wrote:
|
|> Well, for that it might be  a nice feature to register and delete such
|> filters  online, using  a  register/remove_scsi_filter interface,  but
|> well, otoh that might be undesirable security-wise.
|
|
| Let me throw out two ideas to see if anyone find them useful.
|
| 1 - loadable command filters in the kernel.
|
| Each device could have a filter set, which could be empty to require
| RAWIO capability, or set to a kernel default. Access could be made to
| modify a filter via proc, sysfs, or ioctl. The set method is not
| relevant to the idea.
|
| 2 - a filter program.
|
| This one can be done right now, no kernel mod needed. A program with
| appropriate permissions can be started, and will create a command/status
| fifo pair with permissions which allow only programs with group
| permission to open. This allows the admin to put in any filter desired,
| know about vendor commands, etc. It also allows various security setups,
| the group can be on the user (trusted users) or on a setgid program
| (which limits the security issues).
|
| Note that the permissions on individual devices need not be the same; I
| can have one group for disk, another for CD/DVD. You caould even be anal
| and have the filter time sensitive, etc.
|
| A 'standard" place for the fifos helps portability, /var/sgio/dev/hda
| might be a directory, with fifos command and status.
|
|
| Okay, did I miss something, or can this be solved without any additional
| kernel hacks?

Sorry for jumping in this (hot) thread, but I just want to say something:

This is, IMHO, the way to go. Keeping static white-lists in the kernel
is bad and goes against the 2.6 moto: "do it in userspace".

Anyway, I can imagine that the distros are thinking about the problem
very hard. They can't just delete the cd-burn feature as non-root :-)

Also, many things can be affected by this, right? Scanners, jukeboxes,
ip-over-scsi, etc... A programmable kernel interface or a userspace
helper is the only way. To keep things _fast_, I'd be happy with a simple
# echo 1 > /sys/block/hdd/rawio/enable_rawio_if_user_can_write
brw-rw----  1 root disk 22, 64 Mar 14  2002 /dev/hdd
Now every member of @disk can trash your data and your cdrom's firmware.

If the admin sets this flag it's his responsability[*].

Peace,
Nuno Silva

[*] Once you start refusing to let root shoot himself in the foot
there's no way back. You must "fix" 60% of Linux! :-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBKqZVOPig54MP17wRAgE0AJ9LjIKpK+S1nqBYYbOZywVontBdggCdGbF6
Uf2Ok3aFvCbXp6k4Wq7Pn2A=
=cEo2
-----END PGP SIGNATURE-----
