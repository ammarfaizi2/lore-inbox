Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270669AbTHAFlr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 01:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275037AbTHAFlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 01:41:47 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:10484 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S270669AbTHAFlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 01:41:45 -0400
Subject: Re: Emulating i486 on i386 (was: TSCs are a no-no on i386)
From: Martin Schlemmer <azarah@gentoo.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030731153337.GB1873@lug-owl.de>
References: <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk>
	 <20030730203318.GH1873@lug-owl.de> <20030731002230.GE22991@fs.tum.de>
	 <20030731062252.GM1873@lug-owl.de>
	 <20030731071719.GA26249@alpha.home.local>
	 <20030731113838.GU1873@lug-owl.de>
	 <1059652268.16608.8.camel@dhcp22.swansea.linux.org.uk>
	 <20030731121448.GW1873@lug-owl.de> <20030731130130.GY1873@lug-owl.de>
	 <1059664158.5031.26.camel@workshop.saharacpt.lan>
	 <20030731153337.GB1873@lug-owl.de>
Content-Type: text/plain
Message-Id: <1059716275.5032.31.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 01 Aug 2003 07:37:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-31 at 17:33, Jan-Benedict Glaw wrote:
> On Thu, 2003-07-31 17:09:19 +0200, Martin Schlemmer <azarah@gentoo.org>
> wrote in message <1059664158.5031.26.camel@workshop.saharacpt.lan>:
> > On Thu, 2003-07-31 at 15:01, Jan-Benedict Glaw wrote:
> > > On Thu, 2003-07-31 14:14:48 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de>
> > > wrote in message <20030731121448.GW1873@lug-owl.de>:
> > > > On Thu, 2003-07-31 12:51:09 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk>
> > > > wrote in message <1059652268.16608.8.camel@dhcp22.swansea.linux.org.uk>:
> > > > > On Iau, 2003-07-31 at 12:38, Jan-Benedict Glaw wrote:
> > > So there we are. Thanks to someone who pointed me to LD_DEBUG et al., I
> > > see that my _init() is called too late:
> > > 
> > > amtus:~/sigill_catcher# LD_DEBUG=all LD_VERBOSE=1
> > > LD_PRELOAD=./libsigill.so apt-get update 2> ld_infos                                 
> > > Illegal instruction
> > > amtus:~/sigill_catcher# grep 'calling init' ld_infos 
> > > 00691:  calling init: /lib/libc.so.6
> > > 00691:  calling init: /lib/libdl.so.2
> > > 00691:  calling init: /lib/libgcc_s.so.1
> > > 00691:  calling init: /lib/libm.so.6
> > > 00691:  calling init: /usr/lib/libstdc++.so.5
> > > 
> > > As I guessed, libstdc++5's _init() is called before mine (LD_PRELOADed)
> > > _init() function and thus, I cannot intercept this SIGILL, as it
> > > seems...
> > > 
> > 
> > You could do what we do with our path sandbox - basically you
> > use a wrapper that setup the environment (prob not needed in
> > your case), and then spawn bash with our sandbox lib preloaded,
> > which then calls whatever should be 'path sandboxed'.
> 
> Care to send some URL? I haven't found it ad hoc by Google...
> 

http://www.gentoo.org/cgi-bin/viewcvs.cgi/portage/src/sandbox-1.1/?cvsroot=gentoo-src


Cheers,

-- 
Martin Schlemmer
Gentoo Linux Developer, Desktop Team
Cape Town, South Africa

