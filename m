Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272505AbTHAVpQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 17:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274957AbTHAVpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 17:45:16 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:49161 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S272505AbTHAVpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 17:45:01 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] 2.6: races between modprobe and depmod in rc.sysinit
Date: Sat, 2 Aug 2003 01:22:55 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20030801064916.46F842C2B9@lists.samba.org>
In-Reply-To: <20030801064916.46F842C2B9@lists.samba.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_votK/+LqUjB7uHm"
Message-Id: <200308020122.55169.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_votK/+LqUjB7uHm
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 01 August 2003 10:34, Rusty Russell wrote:
> In message <200307312145.01711.arvidjaar@mail.ru> you write:
> > the only reason I can imagine is that it hits depmod -A that runs in
> > rc.sysinit and does
> >
> > truncate /lib/modules/`uname -r`/modules.*
> > scan modules
> > write files
> >
> > So, quesitons
> >
> > - would anybody (Rusty?) object if I change depmod to do
> >   build temp name
> >   move temp name into original
>
> No, that's definitely my preferred method anyway: please send patch.
> Although I double this causes your problem here.
>

this does :) I have seen even more incredible races during boot recently. It 
affects other modules as well, like input loaded by hotplug triggered by USB 
load. depmod on current 2.6 takes some not negligible time.

anyway here is patch against 0.9.13-pre that makes depmod output in temp file 
and rename it after. It fixed the problem for sure for me (like commenting 
out depmod in rc.sysinit did but most people seem to object to it).

> > - Chmouel, Fred - is depmod on every boot really neccessary? When people
> > install modules they are expected to run it actually ...
>
> People get it wrong, and you still want them to boot.  Increasingly we
> can live without depmod though: I might fix this in a near-future
> version to live without it.
>

would be nice.

-andrey
--Boundary-00=_votK/+LqUjB7uHm
Content-Type: application/x-bzip2;
  name="module-init-tools-0.9.13-tempfile.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="module-init-tools-0.9.13-tempfile.patch.bz2"

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
Jgdfm1TwBdahJVQwYDEwoX+LuSKcKEhk6EqSgA==

--Boundary-00=_votK/+LqUjB7uHm--

