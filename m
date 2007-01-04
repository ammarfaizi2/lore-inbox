Return-Path: <linux-kernel-owner+w=401wt.eu-S932210AbXADAc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbXADAc6 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 19:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbXADAc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 19:32:58 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:41189 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932210AbXADAc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 19:32:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oogDGHBhEESrEXNtTu+a9Pb1ukZNS/FHRn4Cimg+d23pFTcq5ox2HCKrQxJtEKSQK0DWsUkv4nNBPdxEEd1pT+MM/e8y9CcWIPs6cHGqckO3pZqglGyqukheJwFmUlvPtGgrFxVEfqPKL5sXs0yIzccnR7t+nhLJOwURJuq/PwM=
Message-ID: <5a4c581d0701031632i3305f02dx9213dc2f593c37d2@mail.gmail.com>
Date: Thu, 4 Jan 2007 01:32:56 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: bjdouma@xs4all.nl
Subject: Re: qconf: reproducible segfault
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <459C1966.7040209@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <459C1966.7040209@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/07, Bauke Jan Douma <bjdouma@xs4all.nl> wrote:
>
> Not a big deal (I just discovered 'make gconfig'), but I'm experiencing
> a reproducible segfault in 'make xconfig', i.e. qconf.
>
> I was wondering if anyone else can reproduce this:
>
> 1. QTDIR=/usr/local/lib/qt make xconfig
>     mine by default has all qconf options OFF ('Show Name', 'Show Range',
>     'Show Data', 'Show All Options', 'Show Debug Info')
>
> 2. from the kernel options, select:
>     Networking / Networking options / Network packet filtering (replaces ipchains)
>
> 3. from the qconf options, now select 'Show Debug Info'
>     voila -> segfault
>
>
> This is with qt-3.3.3:

I can't reproduce it with FC6's current qt-devel in 2.6.20-rc3-git3...
 but point 2 is in my tree

Networking / Networking options / Network packet filtering framework (Netfilter)

 hmm, curious - let me download 2.6.19.1 and apply it... ok, now I see
 your point 2, but I still can't reproduce the problem (Show Debug Info
 does indeed show, well, debug information).

[root@sandman ~]# rpm -q qt-devel
qt-devel-3.3.7-0.1.fc6

> ldd /usr/src/linux-2.6.19.1/scripts/kconfig/qconf
>         linux-gate.so.1 =>  (0xffffe000)
>         libqt-mt.so.3 => /usr/local/lib/qt/lib/libqt-mt.so.3 (0xb76c2000)
>         libdl.so.2 => /lib/libdl.so.2 (0xb76ad000)
>         libstdc++.so.6 => /usr/lib/libstdc++.so.6 (0xb75c9000)
>         libm.so.6 => /lib/libm.so.6 (0xb75a4000)
>         libgcc_s.so.1 => /usr/lib/libgcc_s.so.1 (0xb7598000)
>         libc.so.6 => /lib/libc.so.6 (0xb746f000)
>         libpng.so.3 => /usr/local/lib/libpng.so.3 (0xb7449000)
>         libz.so.1 => /lib/libz.so.1 (0xb7435000)
>         libGL.so.1 => /usr/lib/libGL.so.1 (0xb73a9000)
>         libXmu.so.6 => /usr/X11R6/lib/libXmu.so.6 (0xb7393000)
>         libXrender.so.1 => /usr/X11R6/lib/libXrender.so.1 (0xb738b000)
>         libXrandr.so.2 => /usr/X11R6/lib/libXrandr.so.2 (0xb7387000)
>         libXcursor.so.1 => /usr/X11R6/lib/libXcursor.so.1 (0xb737e000)
>         libXinerama.so.1 => /usr/X11R6/lib/libXinerama.so.1 (0xb737b000)
>         libXft.so.2 => /usr/X11R6/lib/libXft.so.2 (0xb7369000)
>         libfreetype.so.6 => /usr/local/lib/libfreetype.so.6 (0xb72e4000)
>         libfontconfig.so.1 => /usr/local/lib/libfontconfig.so.1 (0xb72a6000)
>         libXext.so.6 => /usr/X11R6/lib/libXext.so.6 (0xb7298000)
>         libX11.so.6 => /usr/X11R6/lib/libX11.so.6 (0xb71cb000)
>         libSM.so.6 => /usr/X11R6/lib/libSM.so.6 (0xb71c2000)
>         libICE.so.6 => /usr/X11R6/lib/libICE.so.6 (0xb71aa000)
>         libpthread.so.0 => /lib/libpthread.so.0 (0xb7192000)
>         /lib/ld-linux.so.2 (0xb7f1b000)
>         libGLcore.so.1 => /usr/lib/libGLcore.so.1 (0xb690c000)
>         libnvidia-tls.so.1 => /usr/lib/tls/libnvidia-tls.so.1 (0xb690a000)
>         libXt.so.6 => /usr/X11R6/lib/libXt.so.6 (0xb68b8000)
>         libexpat.so.0 => /usr/local/lib/libexpat.so.0 (0xb688c000)
>         libiconv.so.2 => /lib/libiconv.so.2 (0xb67b1000)
>
> First I thought qconf window geometry and maybe font would make a
> telling difference here, but I can resize the window all I want and
> change fonts any which way I can, but the segfault persists.

I guess you'll have to try a more recent qt-devel version :)

> FWIW, my initial geometry is 957x843, font is usually LuciduxSans 7.
>
> Strace output didn't provide much of an apparent clue, just the
> SIGSEGV.
>
> Oh, kernel is 2.6.19.1 -- not important I'd say.
>
> Thanks for your time.

Ciao,

--alessandro

 "but I thought that I should let you know
  the things that I don't always show
  might not be worth the time it took"

     (Steve Wynn, 'If My Life Was An Open Book')
