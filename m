Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311224AbSCLOsN>; Tue, 12 Mar 2002 09:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311223AbSCLOsD>; Tue, 12 Mar 2002 09:48:03 -0500
Received: from jalon.able.es ([212.97.163.2]:58778 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S311221AbSCLOrt>;
	Tue, 12 Mar 2002 09:47:49 -0500
Date: Tue, 12 Mar 2002 15:47:42 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Karsten Weiss <knweiss@gmx.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
Message-ID: <20020312144742.GA2036@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.44.0203121351070.3320-100000@addx.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0203121351070.3320-100000@addx.localnet>; from knweiss@gmx.de on mar, mar 12, 2002 at 14:01:28 +0100
X-Mailer: Balsa 1.3.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.03.12 Karsten Weiss wrote:
>On Mon, 11 Mar 2002, Marcelo Tosatti wrote:
>
>> Here goes -pre3, with the new IDE code. It has been stable enough time in
>
>I´m surprised that there are no descriptions for the following
>config options (after months of fights for inclusion of this
>patch):
>
>CONFIG_IDEDISK_STROKE
>CONFIG_IDE_TASK_IOCTL
>CONFIG_BLK_DEV_IDEDMA_FORCED
>CONFIG_IDEDMA_ONLYDISK
>CONFIG_BLK_DEV_ELEVATOR_NOOP
>
>Or did you simply forget to merge them?
>

This is the last version I grabbed fron the list:

diff -urN linux-2.4.17-pristine/Documentation/Configure.help linux-2.4.17/Documentation/Configure.help
--- linux-2.4.17-pristine/Documentation/Configure.help	Fri Dec 21 09:41:53 2001
+++ linux-2.4.17/Documentation/Configure.help	Sat Jan 19 18:30:28 2002
@@ -723,6 +723,59 @@
   say M here and read <file:Documentation/modules.txt>.  The module
   will be called ide-floppy.o.
 
+AWARD Bios Work-Around
+CONFIG_IDEDISK_STROKE
+  Should you have a system w/ an AWARD Bios and your drives are larger
+  than 32GB and it will not boot, one is required to perform a few OEM
+  operations first.  The option is called "STROKE" because it allows
+  one to "soft clip" the drive to work around a barrier limit.  For
+  Maxtor drives it is called "jumpon.exe".  Please search Maxtor's
+  web-site for "JUMPON.EXE".  IBM has a similar tool at:
+  <http://www.storage.ibm.com/hdd/support/download.htm>.
+
+  If you are unsure, say N here.
+
+Raw Access to Media
+CONFIG_IDE_TASK_IOCTL
+  This is a direct raw access to the media.  It is a complex but
+  elegant solution to test and validate the domain of the hardware and
+  perform below the driver data recover if needed.  This is the most
+  basic form of media-forensics.
+
+  If you are unsure, say N here.
+
+Use Taskfile I/O
+CONFIG_IDE_TASKFILE_IO
+  This is the "Jewel" of the patch.  It will go away and become the new
+  driver core.  Since all the chipsets/host side hardware deal w/ their
+  exceptions in "their local code" currently, adoption of a
+  standardized data-transport is the only logical solution.
+  Additionally we packetize the requests and gain rapid performance and
+  a reduction in system latency.  Additionally by using a memory struct
+  for the commands we can redirect to a MMIO host hardware in the next
+  generation of controllers, specifically second generation Ultra133
+  and Serial ATA.
+
+  Since this is a major transition, it was deemed necessary to make the
+  driver paths buildable in separtate models.  Therefore if using this
+  option fails for your arch then we need to address the needs for that
+  arch.
+
+  If you want to test this functionality, say Y here.
+
+Force DMA
+CONFIG_BLK_DEV_IDEDMA_FORCED
+  This is an old piece of lost code from Linux 2.0 Kernels.
+
+  Generally say N here.
+
+DMA Only on Disks
+CONFIG_IDEDMA_ONLYDISK
+  This is used if you know your ATAPI Devices are going to fail DMA
+  Transfers.
+
+  Generally say N here.
+
 SCSI emulation support
 CONFIG_BLK_DEV_IDESCSI
   This will provide SCSI host adapter emulation for IDE ATAPI devices,
@@ -747,6 +747,14 @@
   If both this SCSI emulation and native ATAPI support are compiled
   into the kernel, the native support will be used.
 
+Use the NOOP Elevator (WARNING)
+CONFIG_BLK_DEV_ELEVATOR_NOOP
+  If you are using a raid class top-level driver above the ATA/IDE core,
+  one may find a performance boost by preventing a merging and re-sorting
+  of the new requests.
+
+  If unsure, say N.
+
 ISA-PNP EIDE support
 CONFIG_BLK_DEV_ISAPNP
   If you have an ISA EIDE card that is PnP (Plug and Play) and


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.19-pre3-jam1 #2 SMP Tue Mar 12 08:37:23 CET 2002 i686
