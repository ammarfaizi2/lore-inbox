Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133033AbRA3XIS>; Tue, 30 Jan 2001 18:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132946AbRA3XII>; Tue, 30 Jan 2001 18:08:08 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6784 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S133031AbRA3XHz>; Tue, 30 Jan 2001 18:07:55 -0500
Date: Tue, 30 Jan 2001 18:07:32 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Keith Owens <kaos@ocs.com.au>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Version 2.4.1 cannot be built. 
In-Reply-To: <Pine.LNX.3.95.1010130175517.3672A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.95.1010130180303.4483A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, Richard B. Johnson wrote:

> On Wed, 31 Jan 2001, Keith Owens wrote:
> 
> > On Tue, 30 Jan 2001 16:45:16 -0500 (EST), 
> > "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> > >The subject says it all. `make dep` is now broken.
> > >make[4]: Entering directory `/usr/src/linux-2.4.1/drivers/acpi'
> > >Makefile:29: *** target pattern contains no `%'.  Stop.
> > 
> > Which version of make are you running?
> > 
> 	3.74
> 
> 
> y'a mean even make isn't make anymore?
> Temporary 'fix' was `make -i` for the dependencies. All files I
> need built okay.
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
> 

Bob Tracy found the problem: the second ':' really needs to be
escaped even though newer versions of make allow what was written.


> make[4]: Entering directory `/usr/src/linux-2.4.1/drivers/acpi'
> Makefile:29: *** target pattern contains no `%'.  Stop.

Try the following small patch.  Make version 3.77 works fine, but I
ran into the same problem you did with version 3.75.

====--CUT HERE--====
--- linux/drivers/acpi/Makefile.orig	Tue Jan 30 09:01:26 2001
+++ linux/drivers/acpi/Makefile	Tue Jan 30 09:00:10 2001
@@ -26,7 +26,7 @@
 # will hit everything, too risky in 2.4.0-prerelease.  Bandaid by tweaking
 # CFLAGS only for .ver targets.  Review after 2.4.0 release.  KAO
 
-$(MODINCL)/%.ver: CFLAGS := -I./include $(CFLAGS)
+$(MODINCL)/%.ver: CFLAGS \:= -I./include $(CFLAGS)
 
 acpi-subdirs := common dispatcher events hardware \
 		interpreter namespace parser resources tables
====--CUT HERE--====



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
