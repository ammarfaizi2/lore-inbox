Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269536AbUJFVtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269536AbUJFVtv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269506AbUJFVrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 17:47:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27411 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269500AbUJFVpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 17:45:47 -0400
Date: Wed, 6 Oct 2004 22:45:38 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041006224538.A17342@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Greg KH <greg@kroah.com>, J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041005212712.I6910@flint.arm.linux.org.uk> <20041005210659.GA5276@kroah.com> <20041005221333.L6910@flint.arm.linux.org.uk> <1097074822.29251.51.camel@localhost.localdomain> <20041006174108.GA26797@kroah.com> <1097090333.29706.4.camel@localhost.localdomain> <20041006205417.GA25437@kroah.com> <1097094582.29866.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1097094582.29866.15.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Wed, Oct 06, 2004 at 09:29:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 09:29:44PM +0100, Alan Cox wrote:
> On Mer, 2004-10-06 at 21:54, Greg KH wrote:
> > Ok, then anyone with some serious bash-foo care to send me a patch for
> > the existing /sbin/hotplug file that causes it to handle this properly?
> 
> Something like
> 
> #!/bin/sh
> (
> Everything you had before
> ) <>/dev/console 2>&1

What about:

#!/bin/sh
exec </dev/null >/dev/console 2>&1 || exec </dev/null >/dev/null 2>&1
... original stuff ...

?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
