Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317647AbSGUGyl>; Sun, 21 Jul 2002 02:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317649AbSGUGyk>; Sun, 21 Jul 2002 02:54:40 -0400
Received: from ns.suse.de ([213.95.15.193]:61448 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317647AbSGUGyk>;
	Sun, 21 Jul 2002 02:54:40 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
References: <OF918E6F71.637B1CBC-ON85256BFB.004CDDD0@pok.ibm.com.suse.lists.linux.kernel> <1027199147.16819.39.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 Jul 2002 08:57:45 +0200
In-Reply-To: Alan Cox's message of "20 Jul 2002 21:58:23 +0200"
Message-ID: <p731y9xva8m.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > o EVMS (Enterprise Volume Management System)      (EVMS team)
> 
> or LVM2, which already appears to be scrubbed down and clean

Is there any reason why not both can go in? As far as I know neither
of them needs much of core changes, they are more like independent "drivers"
of the generic block layer stacking interface. There are already multiple
drivers of this - LVM and the various MD personalities.

One disadvantage of the LVM2 concept is that it relies a lot on compatible
user space and there is unlikely to be a stable API. While I'm normally
all for putting things in user space where it makes sense I think the
mounting of your root file system is a bit of exception. 

I used LVM1 for some brief period and managing the different incompatible
user space tools if you wanted to boot different kernels with different
incompatible user space tool versions in parallel for development was
just hell. I don't see LVM2 being much better here - as soon as you want
to run more than a single kernel version you will likely run into problems
with the user space tool versioning.

With EVMS' concept of having more stuff in kernel space (especially the
initial recovery) it looks much more likely that one can keep using it
over multiple kernel versions with minimal hazzle.
Of course LVM2 is still the much elegant design, but at least for some
use cases (like mine) I see space for EVMS.

But then they are essentially device drivers anyways. No reason why not
both can be merged. 

-Andi
