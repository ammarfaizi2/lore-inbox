Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBAOGh>; Thu, 1 Feb 2001 09:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129040AbRBAOG2>; Thu, 1 Feb 2001 09:06:28 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:11279 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S129026AbRBAOGR>; Thu, 1 Feb 2001 09:06:17 -0500
Message-ID: <3A796D20.853374FB@idb.hist.no>
Date: Thu, 01 Feb 2001 15:05:20 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: Alan Chandler <alan@chandlerfamily.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: modules as drivers and the order of loading
In-Reply-To: <ptah7t4do0ts1cukrnqfs38ok1bd2rlnal@4ax.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Chandler wrote:
> 
> As I was building 2.4.1 afresh I took the opportunity to build some of
> the device drivers as modules.  In particular I have a SCSI cdrom
> device (it actually is a cd writer) and I had made that and its
> controller (Adaptec AIC-7xxx driver) modules.
> 
> However, during boot they fail to load because at the time they are
> brought up VFS had not mounted the root filesystem
> 
Is your root disk also connected to that adaptec controller?
If so, compile the adapter into the kernel and let the scsi-CD support
be a module.

> I am not sure why they can be built as modules if they then can't be
> loaded?

It is usually not worth the trouble making modules of something
you need before the root fs is mounted.  (There are special cases,
but generally - don't do it!) 
About the only thing you need to mount root is harddisk support
and a driver for whatever kind of adapter (scsi, ide,...) that the
root fs disk is connected to.  

If it isn't connected to the adaptec (perhaps you have an IDE disk?)
then something else is wrong.  Maybe the root device isn't set
right in the kernel image you are booting.  Check your lilo.conf
(or whatever kernel loader you use)

The general rules for modules:
Stuff you need almost all the time is compiled in.  Stuff you use
only occationally makes sense as modules.  Developers often
use modules for drivers they work on - so they can recompile
and reload without a reboot.  Modules also makes sense for
buggy drivers - you can force re-initialization by
unloading and reloading the module.

There are a couple of reasons for not modularizing everything.  First,
you get a complicated setup for loading the right modules.
Second, there is a memory overhead of half a page per module.  (But of
course you save memory for modules when they aren't loaded.)
Third, compiled-in stuff goes in the single big "kernel page" for
those systems that support big pages.  Pentiums do.  This
gives a performance enhancement as the cpu looks up less
page table entries.  That could be important if the driver is
a high-performance thing like a network or disk controller.

Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
