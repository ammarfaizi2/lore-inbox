Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTEQPCv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 11:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbTEQPCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 11:02:51 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:56471 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S261566AbTEQPCu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 11:02:50 -0400
Date: Sat, 17 May 2003 17:15:30 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030517151530.GB10314@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030515200324.GB12949@ranty.ddts.net> <20030516223624.GA16759@kroah.com> <20030517152129.F626@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030517152129.F626@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 03:21:29PM +0200, Ingo Oeser wrote:
> On Fri, May 16, 2003 at 03:36:24PM -0700, Greg KH wrote:
> > Other than those very minor tweaks, I like this interface, it's looking
> > very good.  I wouldn't worry about any "checksum" calcuation crud, it's
> > up to the userspace tool dumping the firmware to the kernel to make sure
> 
> Ok, if that is true, then we could also have this tool enforce a
> size. Otherwise we are reading and reading without ever ending
> and allocating a lot of kernel resources while we are at it.

 A privileged script will be able to kill the system anyway it wants, I
 don't think that this is needed.

 However, forcing an standard header on firmware images including the
 size would allow size checks without the need for an specialized tool.

 Or to prevent memory reallocation every PAGE_SIZE bytes, a tentative
 size could be written to 'loading' so its meaning would become:

 loading > 1:
 	Start/restart a load of the specified size.
 loading = 1:
 	Start/restart a load of unknown size.
 loading = 0:
 	Finish load.
 loading = -1:
 	Cancel load.
 	
 
> If we know the size, then we also now start and end. So the
> "loading" attribute can certainly go.
 
 I personally like to have explicit start/end, which also allows
 cancellation and restart of the firmware load.

 Regards

 	Manuel
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
