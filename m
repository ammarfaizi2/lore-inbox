Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266948AbTAZRxe>; Sun, 26 Jan 2003 12:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266959AbTAZRxe>; Sun, 26 Jan 2003 12:53:34 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:50376 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S266948AbTAZRxe>; Sun, 26 Jan 2003 12:53:34 -0500
Date: Sun, 26 Jan 2003 12:02:42 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Keith Owens <kaos@ocs.com.au>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: no version magic, tainting kernel. 
In-Reply-To: <31273.1043588007@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0301261151580.15538-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003, Keith Owens wrote:

> Christian Zander <zander@minion.de> wrote:
> >The new module
> >is thus built using gcc 3.0, but init/vermagic.o still indicates gcc
> >2.95; the module loader will erroneously believe everything is fine.
> 
> Congratulations, you have put your finger on a major design flaw in
> modversions that has been there since 2.0 kernel days.  The modversion
> data is generated once and everything else blindly uses it, with _NO_
> checks on whether it is still valid or not.  Rusty knows damn well that
> this is broken, but appears to be ignoring that fact (Rusty, see my
> mail to you and Alan Cox on Wed, 24 Oct 2001 14:14:18 +1000).

First of all, "modversions" has been used to designate the process of 
module symbols versioning in the past years, which the above is not. The 
version magic string is supposed to be a simple check against obvious 
errors like kernel version mismatch between kernel and module and also to 
protect against incompatibilities which the ABI checksums (which 
modversions is about) cannot detect, like incompatible compiler versions.

As such, the information is known beforehand and now complicated 
bookkeeping needed here. (Also, as I just pointed out in a another mail, 
the above scenario is not possible).

Now your comments seem to rather apply to the actual module symbol 
versioning process, which I just posted a patch for. Things are handled 
very much differently now, if you have technical comments on that patch, 
they'd be much appreciated.

--Kai


