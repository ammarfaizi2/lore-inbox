Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270980AbTHQUPF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270929AbTHQUPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:15:04 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:40397
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S271091AbTHQUMh (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:12:37 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Date: Sun, 17 Aug 2003 05:39:44 -0400
User-Agent: KMail/1.5
Cc: Linux-Kernel@vger.kernel.org
References: <Pine.LNX.3.96.1030813165635.12417K-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1030813165635.12417K-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308170539.45145.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 August 2003 17:06, Bill Davidsen wrote:

> It would be nice if there were some neat 3-D shreadsheet type thing
> listing all drivers, all architectures, UP vs. SMP, and a status such as
> WORKS, DOESN'T COMPILE, REPORTED PROBLEMS (SLOW|ERRORS|PANICS) and the
> like. I don't even know where to find a good open source 3-D spreadsheet,
> and the data certainly is scattered enough to be a project in itself,
> chasing a moving target.

You are aware that this would probably take more effort to keep up to date 
than the code itself, right?  And that one spreadsheet couldn't 
simultaneously be accurate for 2.4, 2.6, -ac, -mm, -redhat, -suse...

And how would you keep track of weird "there's a good driver for that, but you 
have to apply this patch" cases?  (Isn't this sort of thing what the various 
bug database efforts are for?)

Will you be tracking cases that only show up on big-endian 64 bit platforms 
that have more than one PCI bus?  How about situations where the driver works 
fine except when you use it in a system with a certain type of USB controller 
and do not have a PS/2 mouse plugged into the system.  (Yes, really.)  How 
about if it works but doesn't come back after an APM suspend?  Do you tag it 
as broken if it works on 95% of the systems out there, but not all of them, 
based on stuff the Bios did before the Linux kernel even got loaded?

I'm currently trying to figure out why APM doesn't work on my new thinkpad.  
Is APM broken?  It freezes my thinkpad solid.  The exact same Red Hat 9 
kernel worked fine on the toshiba that got rained on...

I'm now playing with software suspend in 2.6-test.  You not only have to 
enable software suspend in the power management menu, and you have to go into 
ACPI and enable ACPI support, but you also have to enable ACPI sleep state 
support.  Right.  Documentation/swsusp.txt didn't mention that, and there's a 
kconfig dependency missing here somewhere.  I'm much more interested in 
getting it to work than marking it broken for posterity...

Rob


