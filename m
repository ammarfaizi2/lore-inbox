Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314494AbSEBOYt>; Thu, 2 May 2002 10:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314495AbSEBOYs>; Thu, 2 May 2002 10:24:48 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:61896 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314494AbSEBOYs>; Thu, 2 May 2002 10:24:48 -0400
Date: Thu, 2 May 2002 09:24:39 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: <28926.1020342106@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0205020913390.32217-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002, Keith Owens wrote:

> kbuild 2.5 deliberately does not support modversions, you can turn it
> on but it does nothing.  The original implementation of modversions
> does not fit with the way that people build kernels now (apply patches,
> change configs, rebuild without make mrproper).  To do modversions
> right needs a new version of modutils as well, there is no chance of
> that work being started until kbuild 2.5 is in the kernel.

I would like to object here. Getting dependencies right for modversions is
very much possible in principle, after all modversions are generated in a
deterministic process. (It's also possible in practise, though it's quite
a bit of work).

You're right that modversions are not perfect. It's possible that the ABI 
changes, but the checksum doesn't, but that's very rare. It's also 
possible that the ABI does not change but the checksum does. That happens 
a lot, but it's not really a big problem because that (if done right) will 
just cause spurious rebuilds - correctness isn't affected.

Of course, for people who are patching their kernels a lot, modversions
(again if done right) are a pain in the a**, since they cause a lot of not
really necessary rebuilds. But people who do that supposedly think they
have some idea of how the kernel works and can turn it off - if they get
bitten by ABI changes then, it's their problem. 

Modversions is really essential for distributions, where it's badly needed
to keep users from causing hard to track down crashes by inserting
self-compiled or obtained from whereever else modules into a kernel which
was compiled with a different config.

--Kai


