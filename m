Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTJXQtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 12:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbTJXQtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 12:49:16 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:15556 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262400AbTJXQtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 12:49:14 -0400
Message-ID: <3F9957B3.8000801@pacbell.net>
Date: Fri, 24 Oct 2003 09:47:47 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.4.23-pre8: link error with multiple USB Gadget drivers
References: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet> <20031023195945.GJ11807@fs.tum.de>
In-Reply-To: <20031023195945.GJ11807@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> I'm getting the following link error when trying to compile multiple 
> Gadget drivers statically into the kernel:

... which is not a reasonable configuration, since only one
of them could be active ...

> ...
> IIRC this issue was fixed many months ago in 2.6, and a similar fix 
> (disallowing multiple Gadget drivers) is also needed in 2.4 .

Do you know a good way to do that?  This is an example of something
where the 2.4 "Config.in" commands don't seem to offer even a vaguely
sensible way to constrain the configuration.  Or maybe you need to
be more expert in it than I am.

The rules for the moment should -- but AFAICT can't -- enforce:

   - Only one gadget controller driver, linked statically or as
     a module.  (Example:  net2280 or goku_udc, both on PCI.)
   - If controller driver is statically linked, either:
        * at most one gadget driver statically linked
        * any number of gadget drivers, linked as modules
   - Else if controller driver is linked as a module:
        * any number of gadget drivers, linked as modules

The 2.6 Kconfig is closest to supporting those rules, though I
don't know how to restrict it to "only one controller driver"
regardless of how it's linked.

I'd be open to a better solution than relying on the person
configuring the system to not make mistakes.

- Dave

