Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272509AbTGaPPo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272518AbTGaPOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:14:03 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:34176 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272502AbTGaPMe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:12:34 -0400
Date: Thu, 31 Jul 2003 16:12:26 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Emulating i486 on i386 (was: TSCs are a no-no on i386)
Message-ID: <20030731151226.GG6410@mail.jlokier.co.uk>
References: <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk> <20030730203318.GH1873@lug-owl.de> <20030731002230.GE22991@fs.tum.de> <20030731062252.GM1873@lug-owl.de> <20030731071719.GA26249@alpha.home.local> <20030731113838.GU1873@lug-owl.de> <1059652268.16608.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059652268.16608.8.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2003-07-31 at 12:38, Jan-Benedict Glaw wrote:
> > Thanks for that. In the meantime, I've started to give a try to the
> > userspace version (using a LD_PRELOAD lib). My current Problem:
> > 
> > amtus:~/sigill_catcher# LD_PRELOAD=./libsigill.so ls
> > sigill.c:_init():69: sigill started, sigaction() = 0
> > build.sh  intercept.h  libsigill.so  run.sh  sigill.c  sigill.o
> > amtus:~/sigill_catcher# LD_PRELOAD=./libsigill.so apt-get update
> > Illegal instruction
> > 
> > See? It's loaded at the "ls" call, but it seems to be not loaded for
> > apt-get.
> 
> Remember you need to overload signal setting functions like sigaction.
> My guess is apt decided to disable your signal and you didnt stop it

An application might install its own SIGILL handler to emulate or trap
_other_ instructions.  To do it properly, you have to chain the handlers.

Not sure how to do this, when you get to the stage of two LD_PRELOAD
libraries each wanting to overload sigaction.

-- Jamie

