Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVHAUM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVHAUM2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVHAUM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:12:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:30877 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261216AbVHAUMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:12:14 -0400
Subject: Re: Calling suspend() in halt/restart/shutdown -> not a good idea
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050801203728.2012f058.Ballarin.Marc@gmx.de>
References: <1122908972.18835.153.camel@gaston>
	 <20050801203728.2012f058.Ballarin.Marc@gmx.de>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 22:08:04 +0200
Message-Id: <1122926885.30257.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 20:37 +0200, Marc Ballarin wrote:
> On Mon, 01 Aug 2005 17:09:31 +0200
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Hi !
> > 
> > Why are we calling driver suspend routines in these ? This is _not_ a
> > good idea ! On various machines, the mecanisms for shutting down are
> > quite different from suspend/resume, and current drivers have too many
> > bugs to make that safe. I keep getting all sort of reports of machines
> > not shutting down anymore.
> 
> For example, my Centrino laptop will restart instead of power down with
> -mm kernels.
> 
> To "fix" this I can either:
> - unplug power. Shutdown works when on battery power.
> - attach an external USB hard disk => power down always works.
> - remove device_suspend(PMSG_SUSPEND) => power down always works.-

Yes, this is just one of the gazillion setup that got broken by this
change. Drivers already have a shutdown() callback anyway, and if we
want to re-use the suspend one, then we need to define some sane
parameter, not "fake" a system suspend.

Ben.


