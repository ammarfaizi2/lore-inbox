Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbQKTSIn>; Mon, 20 Nov 2000 13:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129230AbQKTSIY>; Mon, 20 Nov 2000 13:08:24 -0500
Received: from 213-123-73-80.btconnect.com ([213.123.73.80]:18180 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129166AbQKTSIQ>;
	Mon, 20 Nov 2000 13:08:16 -0500
Date: Mon, 20 Nov 2000 17:18:42 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Bernhard Rosenkraenzer <bero@redhat.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Defective Red Hat Distribution poorly represents Linux
In-Reply-To: <Pine.LNX.4.30.0011201649060.16038-100000@bochum.redhat.de>
Message-ID: <Pine.LNX.4.21.0011201700580.1059-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2000, Bernhard Rosenkraenzer wrote:

> On Mon, 20 Nov 2000, Tigran Aivazian wrote:
> 
> > Try Red Hat 7.0 -- it is certainly better. True, no distribution is
> > perfect but over the years I've developed my own CD image upgrade.iso
> > which goes directly after installing latest Red Hat distribution. It is
> > full of things like BRS, dict(1), 'alias md="mkdir -p"' or "set
> > editing-mode vi" which should be installed by default but for some reason
> > aren't.
> 
> Is this thing available for download somewhere? I'd definitely like to see
> what we should be doing differently.

I can put it somewhere, but it won't contain things which are hard to turn
into files, e.g.:

1) after install go through the /etc/rc.d/rc3.d and turn S -> s, for
these:

s05kudzu     s08ipchains  s18autofs  s35identd  s45pcmcia  s60lpd
s85httpd  s99linuxconf
s06reconfig  s16apmd      s25netfs   s40atd     s55sshd    s80isdn
s97rhnsd

2) edit /etc/sysctl.conf to _allow_ sysrq!

3) edit /etc/ftpusers to allow root ftp

4) edit /etc/pam.d/login and /etc/pam.d/rlogin to comment out securetty
PAM module (so we can telnet as root on _any_ tty)

5) edit /etc/inittab to have --noclear in front of the first getty
(actually, either SuSE or Mandrake, can't remember which, guessed that it
is the sane thing to do)

6) edit /etc/inittab to get rid of update, it is not needed (on 2.4)

7) edit /etc/rc.d/init.d/halt to get rid of acct and and quotaoff lines
(who uses accounting and quota on a desktop/laptop, yes, I know I am very
subjective :) but, seriously, those who need them know how to turn them on

8) edit /etc/rc.d/init.d/nfs and allow NFS v3 (also make a symlink in
/etc/rc.d/rc3.d -- there is one for nfslock but not for nfs)

9) edit /etc/rc.d/init.d/nfslock and get rid of the obsolete rpc.lockd
thingy -- it's a 2.2.x monster, not needed anymore.

10) edit /etc/rc.d/rc.local and (that's an important one, I always forget
to mail you about it!) make sure that each terminal shows which tty it is,
i.e. /etc/issue.net should be generated into something like this:

Red Hat Linux 7.0 (Guinness)
Kernel %r %m (%t on %h)

and /etc/issue into something like this:

Red Hat Linux 7.0 (Guinness)
Kernel \r \m (\l)

(yes, I know it is not perfect for a serial console but whoever knows of
an /etc/issue that can satisfy both, let me know). Also, note that my
version is so much more compact than yours (think of those network packets
over telnet!) and yet conveys more information (apart from how many CPU-s
but I can enhance it to do it, I _know_ how many cpus each of my machines
has, but I do _not_ know what tty I am on, unless it shows me).

11) edit /etc/rc.d/rc.local to add setterm -blank 0. It is so annoying to
have a kernel panic and you can't even unblank the console to see what it
was.

12) edit /etc/rc.d/rc.sysinit to get rid of all those unneeded lines (like
swaping to files, if people swap to files they can uncomment them, also
forcing SCSI tape module -- are you sure it's still needed, etc.) my
/etc/rc.d/rc.sysinit is tiny and yet has all I ever needed.

13) add packages: a2ps, acroread, bonnie, brs, ddd, cscope, dictd, dictdb
(last two I have in rpm form, if you need them, the rest are from your
powertools cd). psutils, timidity, xv, xanim, bvi, libdes (I don't care
about laws -- I use that which I know and is comfortable and des(1) fits
both), xruskb (ok, not many people need russian stuff so you can drop this
one :)

14) install from source: util-linux (because the way it is compiled in
redhat by default is wrong), memtest86, unixbench, modutils.

these are just from memory, there must be lots of other things.

regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
