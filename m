Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWDNQuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWDNQuE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 12:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWDNQuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 12:50:04 -0400
Received: from sccimhc91.asp.att.net ([63.240.76.165]:8700 "EHLO
	sccimhc91.asp.att.net") by vger.kernel.org with ESMTP
	id S1751280AbWDNQuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 12:50:02 -0400
From: Steve Snyder <swsnyder@insightbb.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Where to call L2 cache enabling code from?
Date: Fri, 14 Apr 2006 12:49:49 -0400
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200604141105.43216.swsnyder@insightbb.com> <1145029574.17531.26.camel@localhost.localdomain>
In-Reply-To: <1145029574.17531.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604141249.49366.swsnyder@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 April 2006 11:46 am, Alan Cox wrote:
> On Gwe, 2006-04-14 at 11:05 -0400, Steve Snyder wrote:
> > I have a machine in which the BIOS does not enable the Pentium3's L2
> > cache at boot time.  At what point in the kernel init process
> > can/should I call the code to enable the cache?
>
> What part of the cache setup is not done correctly ? The mtrr registers
> or other things ?

It's not that the kernel is failing in any respect.  The BIOS simply does 
not enable the on-CPU L2 cache at power-on.  (The machine originally 
shipped with a Pentium2, and doesn't know how to enable the L2 cache on 
the Pentium3 that is now running in it.)

I've got a small device driver that enables the L2 cache.  It works fine 
when build as a module and loaded after booting has completed.  My goal 
is to move the code into the kernel so that it is run early in the kernel 
init process.  I expect that having the L2 cache go from "0KB" to 256KB 
will improve boot time greatly, as well as informing the kernel from the 
get-go of the true capabilities of this processor.

Getting the code into the kernel image is a no-brainer.  But once it is 
built into the kernel, at what point should I call it?

Thanks for the response.
