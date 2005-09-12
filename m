Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVILRmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVILRmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVILRmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:42:14 -0400
Received: from cantor2.suse.de ([195.135.220.15]:35040 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751095AbVILRmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:42:13 -0400
Date: Mon, 12 Sep 2005 19:42:09 +0200
From: Olaf Hering <olh@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Olaf Hering <olh@suse.de>
Subject: Re: 2.6.13: Crash in Yenta initialization
Message-ID: <20050912174209.GA3965@suse.de>
References: <200509030138.11905.koch@esa.informatik.tu-darmstadt.de> <200509030245.12610.koch@esa.informatik.tu-darmstadt.de> <20050903223401.A7470@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050903223401.A7470@jurassic.park.msu.ru>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Sep 03, Ivan Kokshaysky wrote:

> On Sat, Sep 03, 2005 at 02:45:08AM +0200, Andreas Koch wrote:
> > crucial part seem to be the different bridge initialization sections:
> 
> Indeed.
> 
> > 2.6.12-rc6 + Ivan's patches:
> ...
> >           PCI: Bus 7, cardbus bridge: 0000:06:09.0
> >             IO window: 00006000-00006fff
> >             IO window: 00007000-00007fff
> >             PREFETCH window: 82000000-83ffffff
> >             MEM window: 8c000000-8dffffff
> >           PCI: Bus 11, cardbus bridge: 0000:06:09.1
> >             IO window: 00008000-00008fff
> >             IO window: 00009000-00009fff
> >             PREFETCH window: 84000000-85ffffff
> >             MEM window: 8e000000-8fffffff
> >           PCI: Bus 15, cardbus bridge: 0000:06:09.3
> ...
> > ... Versus the much shorter output from 2.6.13
> ...
> >           PCI: Bus 7, cardbus bridge: 0000:06:09.0
> >             IO window: 00004000-000040ff
> >             IO window: 00004400-000044ff
> >             PREFETCH window: 82000000-83ffffff
> >             MEM window: 88000000-89ffffff
> >           PCI: Bridge: 0000:00:1e.0
> 
> It's mysterious.
> So 2.6.13 doesn't see cardbus bridge functions 06:09.1 and 06:09.3,
> which means that these devices are not on the per-bus device list.
> OTOH, they are still visible on the global device list, since yenta
> driver found them. No surprise that it crashes with some uninitialized
> pointer.

Did you find the reason for this already?
We have a similar report:
https://bugzilla.novell.com/show_bug.cgi?id=113778
...
It dies in yenta_config_init because dev->subordinate is NULL.  
...
