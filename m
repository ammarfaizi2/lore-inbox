Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129596AbQKGOB2>; Tue, 7 Nov 2000 09:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129649AbQKGOBT>; Tue, 7 Nov 2000 09:01:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129596AbQKGOBH>; Tue, 7 Nov 2000 09:01:07 -0500
Date: Tue, 7 Nov 2000 09:00:48 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Keith Owens <kaos@ocs.com.au>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.4.0-test9 
In-Reply-To: <Pine.LNX.3.95.1001107082650.13989A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.95.1001107085622.246A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Richard B. Johnson wrote:

> On Tue, 7 Nov 2000, Keith Owens wrote:
> 
> > On Mon, 6 Nov 2000 16:31:23 -0500 (EST), 
> > "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> > >However when running, the new kernel 2.4.0-test9, can't be used to
> > >make a usable initrd ram disk. The result being that 2.4.0-test9
> > >can't, itself, build an "initrd" bootable system.
> > >
> > >Before everybody screams that I don't know what I'm doing, let me
> > >assure you that I know that the two kernels put their modules in
> > >different directories and the new directory scheme seems to require
> > >the latest and greatest version of modutils.
> > 
> > You also need the latest version of mkinitrd to handle the modules
> > directory structure.
> > 
> No. I have my own script(s) that have been appropriately modified
> for both test floppies and boot from the hard disk.
> 
> I have found the problem. A patch will follow after I get some
> breakfast. It's an obviously-correct one too.
> 

Depending upon some name-space polution, inflate was executing junk
instead of its correct memzero().

Here's the patch....

--- /usr/src/linux-2.4.0/lib/inflate.c.orig	Tue Nov  7 08:52:59 2000
+++ /usr/src/linux-2.4.0/lib/inflate.c	Mon Nov  6 18:01:54 2000
@@ -147,6 +147,7 @@
 STATIC int inflate_dynamic OF((void));
 STATIC int inflate_block OF((int *));
 STATIC int inflate OF((void));
+STATIC void *memzero OF((char *, size_t));
 
 /* The inflate algorithm uses a sliding 32 K byte window on the uncompressed
    stream to find repeated byte strings.  This is implemented here as a




Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
