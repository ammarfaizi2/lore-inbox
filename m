Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbTH2VQh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 17:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTH2VQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 17:16:37 -0400
Received: from codepoet.org ([166.70.99.138]:59020 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S262278AbTH2VQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 17:16:35 -0400
Date: Fri, 29 Aug 2003 15:14:40 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nick Urbanik <nicku@vtc.edu.hk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Single P4, many IDE PCI cards == trouble??
Message-ID: <20030829211440.GB3150@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Nick Urbanik <nicku@vtc.edu.hk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3F4EA30C.CEA49F2F@vtc.edu.hk> <1062150643.26753.4.camel@dhcp23.swansea.linux.org.uk> <3F4F5C9A.5BAA1542@vtc.edu.hk> <1062167896.27561.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062167896.27561.4.camel@dhcp23.swansea.linux.org.uk>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 29, 2003 at 03:38:17PM +0100, Alan Cox wrote:
> On Gwe, 2003-08-29 at 15:00, Nick Urbanik wrote:
> > Is there _anyone_ who is using a number of ATA133 IDE disks (>=6), each on
> > its own IDE channel, on a number of PCI IDE cards, and doing so
> 
> The most I know of is 8, and that was one of the people who found the
> shared IRQ/IDE race cases that 2.4.21 or so fixed.

I have a ton of drives plugged into some promise IDE cards and my
motherboard's builtin ICH5 that I use for testing things.

I have not been seeing IRQ problems.  However, when I have both
the promise and the intel IDE drivers built into the kernel,
there _is_ some sortof a race condition present, such that
stat("/", &statbuf) returns the wrong value for statbuf.st_rdev
about 50% of the time when booting.  Instead of returning the
major/minor with the correct values (/dev/hda2 on the ICH5), it
instead returns some value from one of the drives on the promise
card such as /dev/hdh or some such.  I've tried tracking that
down, but havn't been able to squash it thus far.  Grrrr.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
