Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936678AbWLCI3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936678AbWLCI3d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 03:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936679AbWLCI3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 03:29:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:21182 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S936678AbWLCI3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 03:29:32 -0500
Date: Sun, 3 Dec 2006 01:24:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] FW_LOADER should select HOTPLUG
Message-Id: <20061203012401.3cc30232.akpm@osdl.org>
In-Reply-To: <20061203081552.GC11084@stusta.de>
References: <20061202194022.GY11084@stusta.de>
	<20061203071637.GA11084@stusta.de>
	<20061203005824.37bd8e0f.akpm@osdl.org>
	<20061203081552.GC11084@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2006 09:15:52 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> On Sun, Dec 03, 2006 at 12:58:24AM -0800, Andrew Morton wrote:
> > On Sun, 3 Dec 2006 08:16:37 +0100
> > Adrian Bunk <bunk@stusta.de> wrote:
> > 
> > > Since FW_LOADER is an option that is always select'ed by the code using 
> > > it, it mustn't depend on HOTPLUG.
> > > 
> > > It's only relevant in the EMBEDDED=y case, but this might have resulted 
> > > in illegal FW_LOADER=, HOTPLUG=n configurations.
> > > 
> > > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > > 
> > > --- linux-2.6.19-rc6-mm2/drivers/base/Kconfig.old	2006-12-02 20:36:49.000000000 +0100
> > > +++ linux-2.6.19-rc6-mm2/drivers/base/Kconfig	2006-12-02 20:37:03.000000000 +0100
> > > @@ -19,8 +19,8 @@
> > >  	  If unsure say Y here.
> > >  
> > >  config FW_LOADER
> > > -	tristate "Userspace firmware loading support"
> > > -	depends on HOTPLUG
> > > +	tristate
> > > +	select HOTPLUG
> > 
> > It would be a retrograde step to start selecting HOTPLUG - we've managed to
> > avoid it thus far.
> 
> $ grep -r "select HOTPLUG" * | wc -l
> 4
> $ 
> 
> > It'd be better to make those drivers which select FW_LOADER dependent upon
> > HOTPLUG.
> 
> $ grep -r "select FW_LOADER" * | wc -l
> 71

46 actually.  And it's immaterial.

> 
> And since the only case where depends<->select makes a difference is 
> CONFIG_EMBEDDED=y, people will always continue to forget the dependency 
> on HOTPLUG when select'ing FW_LOADER.

I realise that.  But having HOTPLUG magically and mysteriously turn itself
back on again is a pita.

