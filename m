Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132560AbRDDAO3>; Tue, 3 Apr 2001 20:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132719AbRDDAOW>; Tue, 3 Apr 2001 20:14:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40970 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132560AbRDDAOJ>; Tue, 3 Apr 2001 20:14:09 -0400
Subject: Linux 2.2.19 release notes
To: linux-kernel@vger.kernel.org
Date: Wed, 4 Apr 2001 01:15:55 +0100 (BST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kaxq-0000nf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The master copy of this file is at http://www.linux.org.uk. Check there for
updates and errata



  Linux 2.2.19 Release Notes
  
   Platforms:Alpha, M68K, PowerPC, S/390, Sparc, X86
   
   Introduction
   Linux 2.2.19 is the latest update to the Linux kernel tree. The out of
   the box tree supports the Alpha, PPC, S/390, Sparc and X86 platforms.
   MIPS and ARM are mostly merged but you should obtain the platform
   specific tree.
   
   Compilers
   This code is intended to build with gcc 2.7.2 and egcs 1.1.2. gcc
   2.95.2 and Red Hat gcc 2.96-79 are believed to build the tree
   correctly. As yet we have no detailed information on gcc 2.95.3 but it
   seems to build the tree correctly.
   
   Binary Compatibility
   Linux 2.2.19 should on the whole be fully binary compatible with old
   modules. In general you should not assume binary compatibility between
   kernel object modules in Linux.
   
   Security Notes
   
   Linux 2.2.19 contains significant security fixes as a result of third
   party testing and auditing. We are very grateful to those who
   contributed work and reports to this effort, in particular to OpenWall
   and to Chris Evans.
   
   Architecture Updates
   
   Alpha
          
          + Remove a bogus printk in the OSF syscall error path.
          + Fix ASN reuse races on Alpha SMP
          + Fix read_unlock races on Alpha SMP
          + Show registers across CPU's on SMP Alpha oops
          + Fix bottom half races on Alpha SMP
          + Use our own IRQ routing table for Ruffian boards
          + Remove bogus printk from Alpha exception tables
            
   ARM
          The ARM tree has been partially synchronized with the ARM
          working tree for 2.2
          
          + Fix ptrace races on ARM
          + Miscellaneous ARM updates
          + Fix NFS alignment problems with ARM
            
   i386
          
          + Fix CyrixIII panic on boot in some cases
          + Walk the top 8K not the top 4K of the stack on error dumps
          + Fix further CMOS locking
          + Correct microcode driver feature checking
          + Use E820 memory sizing
          + Handle E820 problems when run with IBM thinkpad
          + Speed up irq/fault paths by avoiding xchg()
          + Tighten up K6 bug check
          + The DMI check for APM could end up running after APM started
          + Updated A20 handler to 2.4 code. Fixes hangs on some obscure
            kit.
          + Watch for timers being reset to 18Hz by firmware bugs
            
   PowerPC
          
          + Fix power off during IDE pmac init
          + Update atyfb128 and serial for pmac
          + Add workarounds for firmware bugs on early iMac
          + Fix oops on resume on some pmac machines
          + Fix problems in the Macintosh HID driver and input driver
          + Fix the pci syscall on the PowerMac machines
            
   S/390
          
          + General fix ups for S/390 problems
          + Add keventd to S/390 for drivers
          + Update DASD driver
          + Add support for over 4K of partitions in procfs
          + Update S/390 to support new official ELF id
          + Update hwc, ctc and iucv
          + Fix a problem in the FPU emulator
            
   Sparc
          
          + Add support for quad sbus sunhme
          + Update NFS compatibility syscalls
          + Add watchdog driver support
          + Update sparc64 syscall tables
          + Fix NETCTL_GETFD on sparc64
            
   Security Updates
   
   binfmt_misc
          binfmt_misc touched user pages directly and could be exploited.
          
   CPIA driver
          An off by one buffer check in the CPIA driver allowed users to
          scribble into kernel memory
          
   CPUID and MSR drivers
          Unloading and reloading these could cause a crash due to
          missing unregister calls. Normally not exploitable but if set
          to autoload and unload they could be abused.
          
   Classifier
          Fix a possible hang in the classifier code.
          
   get/setsockopt
          Mishandling of sign bits in setsockopt and getsockopt allowed
          local DoS and other attacks.
          
   Ptrace/exec race
          Ptrace and exec as well as ptrace/suid races existed that could
          give a local user privileges.
          
   Sockfilter
          Boundary cases in sockfilter could be abused. It is not clear
          if these are actually exploitable
          
   strnlen_user
          Several problems with the implementation have been cured.
          
   SYS5 shared memory
          A code path existed where the shm code would scribble on very
          recently freed memory. It is not clear that this was actually
          exploitable.
          
   sysctl
          Mishandling of sign bits in sysctl allowed local users to
          scribble on kernel memory.
          
   Tighten packet length checks
          The masquerading code checks were a little lax in some cases.
          None of these are believed actually exploitable however.
          
   User access asm bug on x86
          Certain obscure constant copies came out copying the wrong
          number of bytes. No known exploit or actual problem case is
          known but it potentially existed.
          
   UDP Deadlock
          A local user could deadlock the kernel due to bugs in UDP port
          allocation.
          
   Core Updates
   
   Core Dump
          Write out core dumps as sparse files
          
   Dcache aging
          Do aging on the dcache to improve behaviour under load
          
   Hash functions
          Improve the inode and dcache hash functions
          
   Misc device layer
          Reuse of the same minor number is now errored
          
   Page cache coherency
          A problem existed on machines with ambiguous user/kernel
          addresses (the S/390) that could cause the page and buffer
          cache to lose coherency
          
   Page fault
          Ensure a task always handles page faults in run state
          
   Signal delivery
          Queued I/O completion delivery from interrupt context was
          unreliable
          
   Virtual memory
          Revamp the core VM handling to remove a long standing deadlock.
          
   Driver Updates
   
   3c527
          Update the 3c527 driver significantly
          
   3c59x
          Significantly updated
          
   8139too
          Updated with some of the fixes from 2.4
          
   Advantech Watchdog
          Add support for the Advantech watchdog
          
   AGP
          Added support for the Intel i815
          
   ALi 5451
          Fix hang on boot when the midi IRQ is shared
          
   CMPCI
          Initialize driver if compiled into the kernel
          
   COSA
          Fix a wrong memory free
          
   CS46xx
          Fix a problem where the driver failed on the eMachines 400
          
   CS89x0
          Fix media selection
          
   DAC960
          Updated to authors latest version
          
   DRM
          Remove the 'unused' AGP autoload hack from the DRM modules.
          
   DVD
          Fix a problem with reading physical blocks from DVD
          
   EEpro100
          Fix posted write/delay problem.
          
   EMU10K
          Fix problems when the emu10k was compiled built in
          
   ES1370/1371/Solo1
          Fix bugs shown up by some application ioctl sequences
          
   ESS Maestro 3
          Support for this chip has been added
          
   I2O
          Update the i2o block driver.
          
   i810 watchdog
          Added support for the watchdog on the i810 series chipsets
          
   IDE
          Add support for the onstream SC-x0 series tape drives
          
   Intel 'Panther' ethernet
          Driver for the onboard ethernet on this old Intel 486 board.
          
   ISDN
          Extensively updated, new drivers for eicon, hsydn and other
          boards.
          
   Lance
          Fix a dereference to freed memory
          
   Lanstreamer
          Fix crashes on SMP boxes
          
   LP driver
          Remove incorrect message
          
   MDA console
          This driver has been cleaned up
          
   Metricom
          Support new metricom units with longer serial numbers.
          
   Microcode driver
          Updated to match 2.4
          
   NE2000 PCI
          Added support for full duplex capable cards
          
   SCC driver
          Fix a problem with the SCC driver would hang on multiple missed
          interrupts
          
   SiS900
          Add support for the ICS1893 PHY
          
   SonicVibes
          Fix bugs shown up by some application ioctl sequences
          
   Starfire
          New driver.
          
   SX serial
          This driver failed to handle break events correctly
          
   Synclink
          Updated and several bugs fixed
          
   TGA frame buffer
          This driver can now be built as a module
          
   Tulip
          Add basic support for the AMDtek Comet chip
          
   USB ACM
          Loosen up end point rules to allow slightly non conforming
          hardware to work
          
   USB audio
          Updated to match 2.4
          
   USB Bluetooth driver
          Updated to match 2.4
          
   USB DC2xx driver
          Updated to match 2.4
          
   USB Empeg driver
          Updated to match 2.4
          
   USB HID
          Updated to match 2.4. Fix endian problems and locking.
          
   USB hub
          Fix locking on USB hub code
          
   USB FTDI serial
          Updated to match 2.4
          
   USB Keyspan serial
          Updated to match 2.4
          
   USB printer
          Updated to match 2.4
          
   USB Rio
          Updated to match 2.4
          
   USB scanner
          Add further ids for new scanners (eg Epson 1240)
          
   USB Serial
          Fix name reporting in procfs. Update core code to match 2.4
          
   USB visor
          Update the driver to match 2.4
          
   USBdevfs
          Fix missing unlock_kernel
          
   VIA Rhine
          Added support for the VT6102
          
   Yamaha PCI audio
          Add support to setup the legacy devices. Remove old legacy mode
          driver.
          
   File System Updates
   
   FAT
          Updated to handle pre 1980 dates properly
          
   ISO9660
          Fix several bugs shown up by more odd CD-ROMS
          
   Minix subpartitions
          We now support minix subpartitions
          
   NFS caching
          Fix a nasty bug in the NFS caching
          
   NFS Client
          Various small fixes
          
   SMBfs
          Updated to handle pre 1980 dates properly
          
   Miscellaneous Updates
   
   Belorussia NLS table
          Belorussia/Ukraine NLS table (koi8-ru)
          
   Credits
          Update credits and maintainers files to reflect several moves
          
   Parport
          Fix documentation
          
   Ver_linux
          Update the ver_linux reporting script
          
   Network Updates
   
   Accept
          Add wake_one semantics to accept
          
   AX.25
          Fix a missing skb->protocol init
          
   IRDA
          Backport the 2.4 IRDA oops fix. Document options.
          
   Masquerading
          Update the core masquerading code. Fix problems with realaudio
          masquerading
          
   QoS
          Remove experimental tag on QoS features
          
   SLHC
          Fix endian problems in the VJ compression code
          
   SunRPC
          Updated and RPC ping congestion check added
          
   TCP/IP
          Fix problems in the TCP layer
          
   Wireless
          Updated wireless headers
          
   SCSI Updates
   
   3Ware
          Update driver, add 7000 series support
          
   AHA1542/AHA1740
          Remove a bugs sense buffer size check
          
   AIC7xxx
          Update AIC7xxx to v5.1.33
          
   ATP870U
          Fix problems with disconnect
          
   CpqFC
          Update Compaq fibrechannel driver
          
   DC390
          Small driver updates
          
   ICP Vortex
          Driver updates from ICP
          
   PPA scsi
          Fix panic on timeout. Update driver
          
   Scsi_malloc
          Clean up out of memory paths
