Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbTENIPH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 04:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbTENIPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 04:15:07 -0400
Received: from sophia.inria.fr ([138.96.64.20]:55182 "EHLO sophia.inria.fr")
	by vger.kernel.org with ESMTP id S261185AbTENIPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 04:15:05 -0400
Subject: Re: FW: am-utils or kernel bug ? Seems to be kernel or glibc bug...
From: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
To: Ion Badulescu <ionut@badula.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0305132214120.2091-100000@moisil.badula.org>
References: <Pine.LNX.4.44.0305132214120.2091-100000@moisil.badula.org>
Content-Type: text/plain
Organization: INRIA
Message-Id: <1052900861.24411.121.camel@atlas.inria.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 May 2003 10:27:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-14 at 04:23, Ion Badulescu wrote:
> > > i am running Redhat 9.0 ( kernel 2.4.20 )
> > > and am-utils (am-utils-6.0.9-2)  (because i need the browsing
feature
> > > that automount doen't support).
> > > 
> > > Unfortunatelly, amd sometimes hangs at boot time during its
> > > initialization (/etc/rc.d/init.d/amd ).
> > > I can reproduce this bug with /etc/rc.d/init.d/amd start / stop
> > > sequences, sometimes the start hangs sometimes it works.
> > > This bug occurs on ALL RedHat 9.0 boxes we have (7 PC with totally
> > > different hardware).

...

> > > [root@redhat-serv root]# strace -p 2454
> > > futex(0x4212e1c8, FUTEX_WAIT, -2, NULL <unfinished ...>
> > > 
> > > 
> > > [root@redhat-serv root]# strace -p 2455
> > > select(1024, [4 5 6 7], NULL, NULL, {932, 980000} <unfinished ...>
> 
> I'll be damned if I understand what the futex is used for here. But since 
> that's the parent amd, presumably it's waiting for the child to complete 
> something, probably a mount.
> 
> As for the second trace, we need to know what the four filedescriptors are 
> for. 'lsof -p 2455' should shed some light...
> 
> I suspect either a bug in glibc (likely), or a bug in the way amd uses
> some Unix primitives and which just happen to work on older glibc's (less
> likely). It's going to be rather hard to debug, however, if we can't
> reproduce it locally.
> 
> Another suggestion I have is this: boot into an older kernel without futex
> support (2.4.18-27.7.x should do just fine, ignore the missing
> dependencies because they are not fatal). Glibc will adjust to the older
> kernel and use other mechanisms, and we'll see if the hang still occurs.
> Basically, since futexes were back-ported by Red Hat from 2.5 kernels, I
> suspect there might be some bugs or races in there, and this test would
> help to clear it out.

You were right, Ion,
switching to a RH8 kernel ( 2.4.18-14 ) , solved the issue. I cannot
reproduce this futex bug on the father process...

Who should i contact in order to correct things ?

-- 
Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
INRIA

