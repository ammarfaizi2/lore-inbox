Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbSJWLmi>; Wed, 23 Oct 2002 07:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbSJWLmh>; Wed, 23 Oct 2002 07:42:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25362 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263321AbSJWLmh>;
	Wed, 23 Oct 2002 07:42:37 -0400
Date: Wed, 23 Oct 2002 12:48:46 +0100
From: Matthew Wilcox <willy@debian.org>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: 2.5.44: How to decode call trace
Message-ID: <20021023124846.L27461@parcelfarce.linux.theplanet.co.uk>
References: <87elai82xb.fsf@goat.bogus.local.suse.lists.linux.kernel> <p73isztstim.fsf@oldwotan.suse.de> <878z0p1m2y.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <878z0p1m2y.fsf@goat.bogus.local>; from olaf.dietsche#list.linux-kernel@t-online.de on Wed, Oct 23, 2002 at 12:33:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 12:33:25PM +0200, Olaf Dietsche wrote:
> When I build with "make -k EXTRA_CFLAGS=-g EXTRA_LDFLAGS=-g bzImage",
> I get a ton of error messages from drivers/acpi/include/actypes.h and
> other acpi related stuff, starting with: #error ACPI_MACHINE_WIDTH not
> defined. Maybe this is not the usual way to build with -g, but I don't
> get these errors with "make -k bzImage". Maybe someone is interested
> in this.

Not really.  Users shouldn't be overriding EXTRA_CFLAGS, it's for the
benefit of various parts of the kernel.  Some other parts of the kernel
you break by doing this:

./arch/i386/mach-generic/Makefile:EXTRA_CFLAGS  += -I../kernel
./drivers/ide/pci/Makefile:EXTRA_CFLAGS := -Idrivers/ide
./drivers/message/fusion/Makefile:EXTRA_CFLAGS += ${MPT_CFLAGS}
./drivers/usb/storage/Makefile:EXTRA_CFLAGS     := -Idrivers/scsi
./fs/smbfs/Makefile:EXTRA_CFLAGS += -DSMBFS_PARANOIA
./fs/xfs/Makefile:EXTRA_CFLAGS +=        -Ifs/xfs -funsigned-char
./sound/oss/emu10k1/Makefile:    EXTRA_CFLAGS += -DEMU10K1_DEBUG

The normal way to do what you want is to edit the Makefile and add -g
directly to CFLAGS.

-- 
Revolutions do not require corporate support.
