Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275110AbRJFKAW>; Sat, 6 Oct 2001 06:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274806AbRJFKAN>; Sat, 6 Oct 2001 06:00:13 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:16659 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S275097AbRJFKAC>; Sat, 6 Oct 2001 06:00:02 -0400
Date: Sat, 6 Oct 2001 12:00:15 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Russell King <rmk@arm.linux.org.uk>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, jamey.hicks@compaq.com,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.11-pre4/drivers/mtd/bootldr.c does not compile
Message-ID: <20011006120015.A12624@arthur.ubicom.tudelft.nl>
In-Reply-To: <200110052048.NAA19993@baldur.yggdrasil.com> <20011005231732.B19985@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011005231732.B19985@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Oct 05, 2001 at 11:17:32PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 11:17:32PM +0100, Russell King wrote:
> On Fri, Oct 05, 2001 at 01:48:42PM -0700, Adam J. Richter wrote:
> > 	Attempting to compile linux-2.4.11-pre4/drivers/mtd/bootldr.c
> > fails with a bunch of compiler errors, including a complaint that
> > "struct tag" is not defined anywhere.  Presumably this is the result
> > of an incompletely applied patch.
> 
> Firstly, its ARM only.  Secondly, Compaq decided that a partition table in
> flash isn't a good idea, so they're passing it from the boot loader, which
> is a set of tagged lists.

Did you ever get a motivation on why they want to pass it from the boot
loader? It sounds like a particularly bad idea to me.

We can't allocate memory in the tagged list parser so you need to have
it statically allocated in the kernel. That means that there is a
maximum number of partitions, or that we're wasting memory if we don't
use all partition table entries. This can of course be (partly) solved
by putting the partition table in the __initdata section, but in that
case you can't use the partition data if you have the MTD subsystem as
modules.

I wonder what was wrong with the previous solution where the kernel
just read the partition table directly from flash? If the bootloader
can read the partition table, why can't the kernel?


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
