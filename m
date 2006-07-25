Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751522AbWGYJRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbWGYJRj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 05:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWGYJRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 05:17:39 -0400
Received: from mailgate1.uni-kl.de ([131.246.120.5]:396 "EHLO
	mailgate1.uni-kl.de") by vger.kernel.org with ESMTP
	id S1751514AbWGYJRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 05:17:38 -0400
Date: Tue, 25 Jul 2006 11:17:33 +0200
From: Eduard Bloch <edi@gmx.de>
To: 374986@bugs.debian.org
Subject: DRM deadlooping(?) with Radeon X800 GTO and X.org 7.0
Message-ID: <20060725091733.GA17107@rotes76.wohnheim.uni-kl.de>
References: <20060704181217.GA6389@khazad.dyndns.org> <1153137981.19740.34.camel@thor.lorrainebruecke.local> <20060720201234.GA28115@rotes76.wohnheim.uni-kl.de> <20060720203317.GA12426@khazad.dyndns.org> <20060721130502.GA21859@rotes76.wohnheim.uni-kl.de> <1153492606.18808.9.camel@thor.lorrainebruecke.local> <20060721150455.GA5522@rotes76.wohnheim.uni-kl.de> <1153496417.18808.16.camel@thor.lorrainebruecke.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1153496417.18808.16.camel@thor.lorrainebruecke.local>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Michel Dänzer [Fri, Jul 21 2006, 05:40:17PM]:

I am Cc'ing to LKML now. See below about xf86-video-ati git.

Summary: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=374986
since 2.6.17-rcSomething X seems to fail at startup, hangs in a kind of
loop while doing
4582  rt_sigaction(SIGCHLD, {SIG_DFL}, {0x2b6d039cdd30, [INT RT_25], SA_RESTORER|SA_INTERRUPT|SA_ONESHOT|0x31f25d8, 0x2b6d039cd9e8}, 8) = ? ERESTARTNOINTR (To be restarted)

>From what I can see, previous versions did not support my card at all
while in the current, /dev/dri* seems to be opened successfully before
the problem occurs:

4555  write(0, "drmOpenByBusid: Searching for Bu"..., 53) = 53
4555  geteuid()                         = 0
4555  write(0, "drmOpenDevice: node name is /dev"..., 43) = 43
4555  stat("/dev/dri", {st_mode=S_IFDIR|0755, st_size=40, ...}) = 0
4555  stat("/dev/dri/card0", 0x7fff6e5857f0) = -1 ENOENT (No such file or directory)
4555  unlink("/dev/dri/card0")          = -1 ENOENT (No such file or directory)
4555  mknod("/dev/dri/card0", S_IFCHR|0666, makedev(226, 0)) = 0
4555  chown("/dev/dri/card0", 0, 0)     = 0
4555  chmod("/dev/dri/card0", 0666)     = 0
4555  open("/dev/dri/card0", O_RDWR)    = 7

It does not fail if dri X module is not loaded.

> > Ok, tried that. Compiled, packages created, installed, uncommented dri
> > module in xorg, restarted X -> got deadloop as usual :-(
> 
> I'm afraid there's been a misunderstanding; Mesa is only involved when
> starting a 3D application, so it's not relevant to your original
> problem. As I pointed out before, Robert is seeing a different problem.
> One thing you have in common though is that you should report your
> problems upstream. :)
> 
> Eduard, if you still feel adventurous, you could try current
> xf86-video-ati git as well. Maybe there have been other changes that
> helped r300 DRI stability.

I fetched this one: git clone
git://anongit.freedesktop.org/git/mesa/drm.git/ mesa 

and installed compiled libs over the libs from the Debian package. Has
not changed anything, unfortunately.

Eduard.

-- 
<Myon> TV ist Zeitverschwendung
* micsch muss auch nochmal seine TV-Karte einbauen
