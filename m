Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVICSe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVICSe3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 14:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVICSe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 14:34:29 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:11726 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1751177AbVICSe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 14:34:28 -0400
Date: Sat, 3 Sep 2005 22:34:01 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.13: Crash in Yenta initialization
Message-ID: <20050903223401.A7470@jurassic.park.msu.ru>
References: <200509030138.11905.koch@esa.informatik.tu-darmstadt.de> <200509030245.12610.koch@esa.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200509030245.12610.koch@esa.informatik.tu-darmstadt.de>; from koch@esa.informatik.tu-darmstadt.de on Sat, Sep 03, 2005 at 02:45:08AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 02:45:08AM +0200, Andreas Koch wrote:
> crucial part seem to be the different bridge initialization sections:

Indeed.

> 2.6.12-rc6 + Ivan's patches:
...
>           PCI: Bus 7, cardbus bridge: 0000:06:09.0
>             IO window: 00006000-00006fff
>             IO window: 00007000-00007fff
>             PREFETCH window: 82000000-83ffffff
>             MEM window: 8c000000-8dffffff
>           PCI: Bus 11, cardbus bridge: 0000:06:09.1
>             IO window: 00008000-00008fff
>             IO window: 00009000-00009fff
>             PREFETCH window: 84000000-85ffffff
>             MEM window: 8e000000-8fffffff
>           PCI: Bus 15, cardbus bridge: 0000:06:09.3
...
> ... Versus the much shorter output from 2.6.13
...
>           PCI: Bus 7, cardbus bridge: 0000:06:09.0
>             IO window: 00004000-000040ff
>             IO window: 00004400-000044ff
>             PREFETCH window: 82000000-83ffffff
>             MEM window: 88000000-89ffffff
>           PCI: Bridge: 0000:00:1e.0

It's mysterious.
So 2.6.13 doesn't see cardbus bridge functions 06:09.1 and 06:09.3,
which means that these devices are not on the per-bus device list.
OTOH, they are still visible on the global device list, since yenta
driver found them. No surprise that it crashes with some uninitialized
pointer.

I'd suspect some change in PCI probing code between 2.6.12-rc6 and
2.6.13, but so far I'm unable to find what it was...

Maybe you could try 2.6.12 release and 2.6.13-rc kernels to see where
it breaks?
(Note that the PCI setup patches that you're using went into 2.6.13-rc2.)

Ivan.
