Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131490AbRCWW3r>; Fri, 23 Mar 2001 17:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131489AbRCWW3k>; Fri, 23 Mar 2001 17:29:40 -0500
Received: from gear.torque.net ([204.138.244.1]:39686 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S131486AbRCWW3U>;
	Fri, 23 Mar 2001 17:29:20 -0500
Message-ID: <3ABBCE6C.8E71034@torque.net>
Date: Fri, 23 Mar 2001 17:30:04 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
CC: icabod <icabod@lump.mine.nu>
Subject: Re: Advansys SCSI driver old verson?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

icabod <icabod@lump.mine.nu> wrote:
> I've noticed a small problem that hinders me 
> from updatingmy system to the new 2.4 kernels. 
> I'm using a PowerMac with a Advansys SCSI 3940UW 
> card in it running my drives. I've noticed that 
> since the 2.4 kernel series the advanasys drivers 
> version 3.2M and the driver version that works for 
> me and came with the 2.2.17+ kernels at least 
> workes fid with my card, that version is 3.3D. I 
> was wondering if anyone had noticed this before, 
> or if there s a reason the older driver was used. 
> The reason I bring this up is tht the driver in 
> the 2.4 kernel series does not drive my particular
> card. I hope that the readers of this list find 
> this helpful, if you have any questions please 
> feel free to reply. Thanks.

Andy Kellner (from ConnectCom Solutions formerly 
known as Advansys) and Bob Frey (former maintainer) 
working in concert have posted several "3.3x" versions 
of the advansys driver to the linux-scsi list. Despite
this, there seems no sign of this improved driver 
being included in the 2.4 series kernels. However 
the advansys driver was upgraded to version 3.3D in 
lk 2.2.18 . Have there been any adverse reports about 
the advansys driver in lk 2.2.18 ?

I am currently using advansys driver version 3.3G
without problems on lk 2.4.2 . The changelog at the
top of the advansys.c file shows an impressive number 
of improvements and fixes between versions 3.2M and 
3.3G (including powerpc support, see below).

This is not the first time that I've sent such a post 
trying to press for an update of this driver. I was 
told that the patch was too big to be contemplated for 
lk 2.4 . Well size didn't stop the complete replacement 
of the much used aic7xxx driver.


You do have some short term options. Since the 
advansys driver has the same source in the lk 2.2 
and lk 2.4 series, you can copy the version 3.3D
advansys.[hc] files from your lk 2.2.18 source to
your lk 2.4.2 source and it will build ok.
Alternatively you can get a recent version (version 
3.3F) from:
http://www.connectcom.net/support/evaluation.html

Doug Gilbert



Changelog from advansys.c file between versions
3.2M and 3.3G follows:

vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
     3.2N (4/1/00):
         1. Add CONFIG_ISA ifdef code.
         2. Include advansys_interrupts_enabled name change patch.
         3. For >= v2.3.28 use new SCSI error handling with new function
            advansys_eh_bus_reset(). Don't include an abort function
            because of base library limitations.
         4. For >= v2.3.28 use per board lock instead of io_request_lock.
         5. For >= v2.3.28 eliminate advansys_command() and
            advansys_command_done().
         6. Add some changes for PowerPC (Big Endian) support, but it isn't
            working yet.
         7. Fix "nonexistent resource free" problem that occurred on a module
            unload for boards with an I/O space >= 255. The 'n_io_port' field
            is only one byte and can not be used to hold an ioport length more
            than 255.

     3.3A (4/4/00):
         1. Update to Adv Library 5.8.
         2. For wide cards add support for CDBs up to 16 bytes.
         3. Eliminate warnings when CONFIG_PROC_FS is not defined.

     3.3B (5/1/00):
         1. Support for PowerPC (Big Endian) wide cards. Narrow cards
            still need work.
         2. Change bitfields to shift and mask access for endian
            portability.

     3.3C (10/13/00):
         1. Update for latest 2.4 kernel.
         2. Test ABP-480 CardBus support in 2.4 kernel - works!
         3. Update to Asc Library S123.
         4. Update to Adv Library 5.12.

     3.3D (11/22/00):
         1. Update for latest 2.4 kernel.
         2. Create patches for 2.2 and 2.4 kernels.

     3.3E (1/9/01):
         1. Now that 2.4 is released remove ifdef code for kernel versions
            less than 2.2. The driver is now only supported in kernels 2.2,
            2.4, and greater.
         2. Add code to release and acquire the io_request_lock in
            the driver entrypoint functions: advansys_detect and
            advansys_queuecommand. In kernel 2.4 the SCSI mid-level driver
            still holds the io_request_lock on entry to SCSI low-level drivers.
            This was supposed to be removed before 2.4 was released but never
            happened. When the mid-level SCSI driver is changed all references
            to the io_request_lock should be removed from the driver.
         3. Simplify error handling by removing advansys_abort(),
            AscAbortSRB(), AscResetDevice(). SCSI bus reset requests are
            now handled by resetting the SCSI bus and fully re-initializing
            the chip. This simple method of error recovery has proven to work
            most reliably after attempts at different methods. Also now only
            support the "new" error handling method and remove the obsolete
            error handling interface.
         4. Fix debug build errors.

     3.3F (1/24/01):
         1. Merge with ConnectCom version from Andy Kellner which
            updates Adv Library to 5.14.
         2. Make PowerPC (Big Endian) work for narrow cards and
            fix problems writing EEPROM for wide cards.
         3. Remove interrupts_enabled assertion function.

     3.3G (2/16/01):
         1. Return an error from narrow boards if passed a 16 byte
            CDB. The wide board can already handle 16 byte CDBs.
