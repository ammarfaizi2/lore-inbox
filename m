Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130024AbRAFTl1>; Sat, 6 Jan 2001 14:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131020AbRAFTlR>; Sat, 6 Jan 2001 14:41:17 -0500
Received: from fes-qout.whowhere.com ([209.185.123.96]:45459 "HELO
	mailcity.com") by vger.kernel.org with SMTP id <S130024AbRAFTlF>;
	Sat, 6 Jan 2001 14:41:05 -0500
To: linux-kernel@vger.kernel.org
Date: Sat, 06 Jan 2001 14:40:45 -0500
From: "Joe Pranevich" <jpranevich@lycos.com>
Message-ID: <CNDCNNNONGMAFAAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: on
Reply-To: jpranevich@lycos.com
X-Mailer: MailCity Service
Subject: New features in Linux 2.4 - Wonderful World of Linux 2.4
X-Sender-Ip: 32.226.166.224
Organization: Lycos Communications  (http://comm.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This document has already been picked up by some Linux news sites, but it really belongs here. This is my list of new features since Linux 2.2, gathered by reading this list, playing with patches, and getting input from people. Parts of it are non-technical, but there is some good info here.

I hope that someone out there finds this list useful.

Joe

--

Wonderful World of Linux 2.4

Joe Pranevich

   In the beginning, there was Linus and his 386. For reasons far too
   complicated to be discussed here, he decided not to use the commonly
   available operating system of the time and instead decided to write
   his own. Several years and many thousands of lines of code later,
   Linux 2.2was released. Linux 2.2 was a milestone in and of itself and
   I wrote an article about it, which I am quite happy with.
   Unfortunately for me however (and fortunately for the rest of the
   world), Linus and company continued to hack away at the Linux OS and
   the 2.4 release of the Linux kernel is nearing completion. This
   document describes some of the new features in Linux 2.4.

   Linux 2.4.0 was released without much fanfare on January 4^th, 2001.
   Although it has often been criticized for tardiness, the Linux kernel
   adheres to the Open Source philosophy of releasing code when it is
   ready. (Development snapshots have been made available weekly for
   interested parties.) As the kernel is generally only a small piece of
   a much larger Linux Operating System, the major distribution vendors
   will likely not be packaging it standard for several months yes.

   In this document, I have attempted to bring attention to areas where
   Linux 2.4 is not compatible with Linux 2.2. As this is a major
   release, the developers have taken this time to refine existing APIs
   (application programming interfaces) and other structures to make the
   system more cohesive. This process will almost definitely break any
   program that relies on an intimate knowledge of the kernel (such as
   the PPP daemon) but many other programs may be affected. One special
   item of note is that devfs, the Device Filesystem, will change the
   names of all device nodes on the system. (A compatibility layer for
   the old names has been provided.) It will be up to the individual
   distributions to determine whether or not to implement devfs and to
   what extent to patch the existing packages. If you would like to
   experiment with the Linux 2.4 kernel before it is released by a major
   distribution, please be sure to read the CHANGES document with the
   kernel and manually upgrade any necessary packages.
Joe - jpranevich@linuxtoday.com (Home) 
      jpranevich@lycos-inc.com  (Work)

   < This work has absolutely nothing to do with Lycos, my employer. The
   views here are all mine and this article does not constitute an
   endorsement from Lycos or anything of the sort. Reproduction or
   translation of this article is fine, with permission. Email me. It's
   fun.>

   --

The Many Flavors of Linux

   In terms of sheer volume of code, the Linux kernel is predominantly
   made up of drivers. In fact, the size of the Linux core has not
   increased much over the last several revisions. Some of these drivers
   are architecture independent, such as the IDE driver. That is, these
   drivers have been written to work on multiple platforms. Other drivers
   are dependent on a particular architecture. For example, the ADB
   (Apple Desktop Bus) mouse driver isn't really applicable on the i386
   port and so isn't supported. Linux kernel developers strive to make
   drivers as general as possible, so as to allow a driver to be reused
   with relatively little effort on a different platform if a device
   becomes available. It is convenient to think of the Linux kernel as a
   single entity, but some features may vary from platform to platform.

   In order to narrow the scope a bit, this document will mostly stick to
   Intel hardware as that is the hardware that I use most often at home.
   While I won't go into the specifics of each individual port, it should
   be mentioned that Linux 2.4 adds support for three new architectures:
   ia64 (Itanium, the successor to i386), S/390 (an IBM mainframe), and
   SuperH (Windows CE hardware). Linux 2.4 also includes support for the
   newer 64-bit MIPS processors. Of course, some platforms will be more
   mature than others.

   In terms of Intel-like hardware, Linux 2.4 is very similar in support
   to Linux 2.2. All Intel chips since the 386 are still supported, up to
   the Pentium III. Unlike Linux 2.2 however, Linux 2.4 includes direct
   support for the newest Pentium IV processors. (Older processors will
   probably never be supported.) MMX and MMX2 are also supported.
   Optimizations have been added to speed up Linux on all processors, but
   especially on the newer processors, such as the Pentium III.
   Compatible chips, such as those produced by AMD and Cyrix, are also
   supported. Additionally, Linux 2.4 will include support for other
   hardware often present on newer chips including non-Intel varieties of
   the MTRRs/MCRs, which will improve performance on some high bandwidth
   devices. While Linux 2.2 included support for the IO-APIC (Advanced
   Programmable Interrupt Controller) on multi-processor systems, Linux
   2.4 will support these on uni-processor systems and also support
   machines with multiple IO-APICs. The support for multiple IO-APICs
   will allow Linux 2.4 to scale much better than previous incarnations
   of Linux on high-end hardware.

   As modern day processors continue to get more and more powerful, the
   Linux kernel needs to be able to keep up with developments. One
   additional feature of the 2.4 kernel is support for processors faster
   than 2 gigahertz. Although no such processors exist today, it is quite
   likely that processors this fast (or faster) will be available to
   general consumers within the next several years.

Linux 2.4 and ia64 (Itanium)

   While not yet delivered to the starving masses, Intel's 64-bit
   replacement to the x86 line is almost here. While real hardware is not
   yet readily available, patches that include support for this chip and
   its successors have already been included in the mainstream kernel
   release. This porting process was no doubt simplified by Linux's
   existing support for 64-bit processors (including Compaq's Alpha chips
   and the Sun's Sparc64) which were already merged into the main Linux
   tree.

Linux Internals

   Linux 2.2 was a major improvement over Linux 2.0 and the Linux 1.x
   series. It supported many new filesystems, a new system of file
   caching, and it was much more scalable. (If you want a list of
   features new to Linux 2.2, you can read my article about it.) Linux
   2.4 builds on these things and more to be the best darned Linux kernel
   yet in a variety of situations.

   The Linux kernel is an assortment of modular components and subsystems
   including device drivers, protocols, and other component types. APIs,
   programming interfaces that provide a standard method by which the
   Linux kernel can be expanded, glues these to the core of the Linux
   kernel. Most of this document will focus on these components of the
   Linux OS as these are the components that seem to do the most work:
   drive your disks, read your files, and do all of the obvious and
   physical things. Linux 2.4 is however much more than just these
   components. These assorted drivers and APIs all revolve around a
   common center of the Linux kernel. This center includes such
   fundamental features as the scheduler, the memory manager, the virtual
   filesystem, and the resource allocator.

   Linux 2.4 is the first release of the Linux kernel that will include a
   full-featured resource management subsystem. Previous incarnations of
   Linux included some vestiges of support, but it was considered kludgy
   and did not provide the functionality needed for the "Plug and Play"
   world that we live in today. Unlike many of the other internal
   changes, many users will be able to directly experience this change as
   it impacts the way resources are allocated and reported in the kernel.
   As part of this change, the PCI card database deprecated in Linux 2.2
   has been un-deprecated so that all resources can have an associated
   device name, rather than just an associated driver.

   The new release of the Linux kernel also fixes some problems with the
   way the VFS (virtual filesystem) layer and the file caches were
   handled. In previous versions of Linux, file caching was dependent on
   a dual-buffer system, which simplified some issues, but caused many
   headaches for kernel developers who had to make sure that it was not
   possible for these buffers to be out of synch. Additionally, the
   presence of the redundant buffer increased memory use and slowed down
   the system as the kernel would have to do extra work to keep things in
   synch. Linux 2.4 solves these problems by moving to a simpler
   single-buffer system.

   A number of changes in Linux 2.4 can be described as "enterprise
   level." That is, they may not be immediately useful to many desktop
   users but work to strengthen Linux as a whole. For the most part, the
   addition of these features does not degrade Linux in more "normal"
   environments. First, Linux 2.4 can handle many more simultaneous
   processes by being more scalable on multiprocessor systems and also by
   providing a configurable process limit. Second, the scheduler has been
   revised somewhat to be more efficient on systems with a larger number
   of concurrent processes. Third, the revised Linux kernel can now
   handle an amazing number of users and groups-- about 4.2 billion. (And
   that's a lot of users!) In addition, support for more powerful
   hardware is provided in the new kernel, which now supports up to 64
   gigabytes of RAM on Intel hardware, up to 16 Ethernet cards, 10 IDE
   controllers, multiple IO-APICs, and other pointless abuses of good
   hardware. The 2-gigabyte file size restriction has also been lifted.
   With these changes and others, the Linux kernel development team is
   proving that Linux can be an option in many new environments.

   The way Linux handles shared memory has also been changed in Linux 2.4
   to be more standards compliant. One side effect of this    set of
   changes is that Linux 2.4 will require a special "shared memory"
   filesystem to be mounted in order for (POSIX-style) shared memory
   segments to work. SysV-style shared memory will continue to work
   without the additional filesystem. The mounting of this filesystem
   should be handled by the distributions when they become ready for
   Linux 2.4.

   Another "odd" change included in this new revision of the Linux kernel
   involves the VFS layer. In previous versions of Linux, indeed most
   every version of UNIX, you can only mount a filesystem once. Linux 2.4
   has decided to turn this on its ear by allowing any filesystem to be
   mounted as many times as desired (with all changes appearing
   immediately on the other mount points). This is especially useful for
   filesystems like /proc that need to be mounted in an initrd and then
   mounted again. Additionally, the infrastructure is there to eventually
   allow even odder things: union mounts which contain files from
   multiple filesystems together, etc. In this respect, Linux is either
   cutting edge or crazy. I'm betting on the former. :)

   Linux 2.4 also includes a much larger assortment of device drivers and
   supported hardware than any other Linux revision and any particular
   device you care to name has a decent shot at working under Linux 2.4.
   (Of course, you should consult the documentation before you go out and
   buy any new hardware, just in case. New hardware especially may not be
   supported yet.)

   One frequently asked question about Linux 2.4 is how much memory it
   will require. Many operating systems seem to require more and more
   memory and resources as they mature, but Linux 2.4 will largely buck
   that trend by actually requiring less memory in certain situations. Of
   course, Linux 2.4 includes much more functionality than does Linux
   2.2and many of these features do take up space so your mileage may
   vary. (Remember that most kernel components can be disabled at
   compile-time, unlike the bloat of many other operating systems.)

UNIX Devices - /dev/*

   Although taking place largely under the hood, there is one major
   change that will have a drastic effect on the way Linux 2.4 handles
   devices. Incidentally, it is also one of the new kernel's most debated
   features: DevFS, the Device Filesystem. Although currently optional,
   when enabled the new Device Filesystem will have two very major
   effects on the way users and programs interact with hardware and other
   devices. First and most obvious, nearly every "standard" device name
   has changed. Instead of putting all devices essentially in the root
   directory of the /dev tree, Linux 2.4's /dev tree leans towards having
   a large number of directories corresponding to controllers or general
   groupings with individual disks and other devices in those
   directories. For example, what was "/dev/hda" is now likely to appear
   somewhere under "/dev/ide0" This change dramatically increases the
   available namespace for devices and allows for easier integration of
   USB and similar device systems. The second major effect of the new
   system is that device nodes will no longer be created by a user and
   stored on a local disk. Instead, device nodes are created by the
   drivers that use them, as they are loaded. This not only makes the
   /dev directory cleaner, but it also allows Linux to use a root
   filesystem that may not understand all UNIX semantics (such as a DOS
   filesystem.) An additional userspace daemon, devfsd, will be
   recommended so that the old style names will continue to work.

   For the most part, this change should only affect bleeding edge users
   and distribution maintainers. (It remains to be seen what work
   distributions decide to do in this area before release.)
   Unfortunately, there are some drawbacks to this system for power
   users. For example, it is more difficult in this new system to custom
   name your devices or assign non-standard permissions to them. It is
   commonly believed however that these issues can be solved using
   user-level scripting.

System Buses - ISA, PCI, USB, MCA, etc.

   Processors are just one small part of the nifty world that exists
   inside your computer. Equally important is the computer's bus
   architecture, the component(s) of the system that is often responsible
   for internal and external devices. Some bus architectures, such as the
   original ISA, are more irresponsible towards their hardware than
   anything else-- they don't provide any resource management
   functionality,just a place to put in cards. Others, such as PCI,
   support much more advanced levels of configuration and allow for
   devices to be relocated in memory and other things. As of Linux 2.2,
   all major buses used on Intel hardware are supported including (E)ISA,
   VLB, PCI, and the newest addition(an older bus only popular on IBM
   hardware), MCA. Linux 2.4 expands on this support by including direct
   support for ISA Plug-and-Play devices (a scheme to make ISA devices
   almost as intelligent as PCI ones) and I2O devices. But perhaps most
   importantly, Linux 2.4 is the first version of the Linux kernel to
   provide a robust system for resource management. During the
   development of Linux 2.4, it became apparent that such a system would
   be a requirement if Linux were to ever completely support USB, PC
   cards, or any number of other modern hardware advances and take its
   rightful place as a "modern" operating system.

   ISAPnP has long been a major issue for Linux users. Although support
   for ISA hardware has dwindled in favor of more robust PCI hardware,
   many budget devices are still sold that use ISAPnP. Previously, Linux
   users could get ISAPnP hardware working by using often frustrating pnp
   utilities that could require hours of tweaking to get quite right.
   Some distributions attempted to automate this process, but none met
   with any great level of success. As the Linux 2.4 development
   progressed, it became apparent that it would be easy and beneficial to
   integrate ISAPnP support into the resource manager.(Although as of
   this writing, not all drivers have been recoded to take advantage of
   its features.) Sadly however, Linux 2.4's support for ISAPnP at the
   kernel level comes at a time when actual PnP hardware is relatively
   uncommon Had this functionality been available earlier, more users
   could have benefited.

   In contrast, Linux is right on the bleeding edge with its support for
   I2O devices, a new more "intelligent" superset of PCI. Relatively
   revolutionary in its day, PCI was a great improvement as it provided
   for centralized management of devices' memory ranges, registers, etc.
   I2O devices go the next level by providing an API at the device level
   that will allow OS independent drivers to be provided for devices. The
   underlying OS then need only understand the "generic" I2O APIs to use
   the device instead of the hardware-specific ones. As this technology
   is relatively new, not many devices have been manufactured to take
   advantage of this yet, but Linux will be ready if and when they show
   up in the marketplace.

   Much of the major work with devices recently has not been with the
   internal busses, but rather with external ones such as the PC Card
   bus, and the various serial busses. The most common variety of
   external device is the PC Card (formerly known as a PCMCIA card).
   Linux 2.4 includes, at long last, support for these devices in a stock
   kernel. (Previously, it was possible to download a driver from an
   external source; nearly every distribution actually chose to do this.)
   Of course, an external daemon and other components will still be
   required to make the most out of these devices.

   Perhaps the most exciting news on this front is the Universal Serial
   Bus (USB), an external bus that is coming into prominence for devices
   such as keyboards, mice, sound systems, scanners, and printers. USB is
   a popular option on many new pieces of hardware, including non-Intel
   hardware. Linux's support for these devices is still in early stages
   but a large percentage of common USB   hardware (including keyboards,
   mice, speakers, etc.) is already supported in the kernel.

   And even more recently, Firewire (IEE1394) support has been added into
   the Linux kernel. Firewire is a popular option for many high-bandwidth
   devices. Not many drivers (or devices) exist for this hardware
   architecture yet, but this support is likely to improve over time, as
   the architecture matures.

Block Devices - LVM, Disk Drives, etc.

   In its simplest form, a block device is a device, which can be
   expressed as an array of bytes that can be accessed non-sequentially.
   This would include devices such as disks (where you can read any
   sector you want) but not serial ports (because you can only read what
   is at the end of the wire.) Extensions to this concept (such as
   ejecting a disk, etc.) are handled in Linux through ioctls (I/O
   Controls). The concept of block devices hasn't changed in quite a
   while and support for things such as IDE and SCSI disk drives has been
   present since the first revisions of the Linux kernel.

   In Linux 2.4, all the block device drivers have been rewritten
   somewhat as the block device API has been changed to remove legacy
   garbage from the interface and to completely separate the block API
   from the file API at the kernel level. The changes required for this
   API rewrite have not been major. However, module maintainers who have
   modules outside the main tree may need to update their code. (One
   should never assume full API compatibility for kernel modules between
   major revisions.)

   On the desktop at least, disk devices that use the IDE bus are most
   prevalent. Linux has supported IDE since the earliest kernels, but
   Linux 2.4 has improved support for these devices in a number of ways.
   First off, high-end systems that have multiple IDE controllers may
   benefit as the number of supported IDE controllers has been increased
   from 4 to 10. As most motherboards are shipped with a maximum of two,
   this is not likely to impact many desktop users. Secondly, there have
   been changes in the IDE driver, which will improve Linux 2.4's support
   for PCI and PnP IDE controllers, IDE floppies and tapes, DVDs and
   CD-ROM changers. And finally, Linux 2.4 includes driver updates, which
   should work around bugs present in some IDE chip sets and better
   support the advanced features of others, such as ATA66.

   While it would seem that the SCSI subsystem has not changed as much as
   the IDE subsystem, the SCSI subsystem has been largely rewritten
   "under the hood." Additionally, a number of new SCSI controllers are
   supported in this release. A further SCSI cleanup is expected sometime
   during the2.5 development cycle.

   One completely new feature in the Linux 2.4 kernel is the
   implementation of a "raw" I/O device. A raw device is one whose
   accesses are not handled through the caching layer, instead going
   right to the low-level device itself. A raw device could be used in
   cases where a sophisticated application wants complete control over
   how it does data caching and the expense of the usual cache is not
   wanted. Alternatively, a raw device could be used in data critical
   situations where we want to ensure that the data gets written to the
   disk immediately so that, in the event of a system failure, minimum
   data will be lost. Previous incarnations of this support were not fit
   for inclusion as they required literally doubling the number of device
   nodes so that every block device would also have a raw device
   node.(This is the implementation that many commercial UNIXes use.) The
   current implementation uses a pool of device nodes which can be
   associated with arbitrary block devices.

   One huge area of improvement for Linux 2.4 has been the inclusion of
   the LVM (Logical Volume Manager) subsystem into the mainstream kernel.
   This is a system, standard in Enterprise-class UNIXes such as
   HP-UXandTru64 UNIX (formerly Digital UNIX), that completely rethinks
   the way filesystems and volumes are managed. Without going into
   detail, the LVM allows filesystems to span disks, be resized, and be
   managed in a more flexible way. Some of the features of the LVM
   subsystem can be replicated with the md (multiple device) driver or
   some userspace tools. However, the LVM subsystem offers this support
   in a (de facto) standards-compliant manner that will also be at least
   somewhat familiar to users of commercial UNIXes.

   Another huge area of improvement for Linux 2.4 will be in its support
   for RAID devices, multiple disks working together to provide redundant
   storage or speedier read accesses. In the new kernel, nearly the
   entire RAID subsystem has been rewritten. Performance, probably the
   most important facet of a complete RAID implementation, has been
   improved on both SMP and uniprocessor systems. (On SMP, it's now
   better threaded.)Additionally, the code has been made much more robust
   with the ability to make RAID arrays recursive and be able to mount
   sets for a root disk without the use of a ramdisk image. As more
   enterprise-level users approach Linux, features like a robust RAID
   subsystem become gating factors between acceptance and non-acceptance.
   Linux 2.4 again raises the bar.

Filesystems and Partition Tables

Local Filesystems

   Block devices can be used in a number of ways. The most common way to
   use a block device is to make a filesystem out of it. (Internally, the
   filesystem code is like an overlay on the block device driver.) Other
   ways that a block device can be used include partitioning (which is a
   lot like a filesystem, just handled in a completely different way),
   and using it raw.

   Linux 2.4 includes all of the filesystems present in Linux 2.2. Those
   filesystems include FAT (for the assorted DOSes), NTFS (for Windows
   NT-- Windows 2000 support is spotty), VFAT and FAT32 (for
   Windows9x/ME), HFS (for MacOS), HPFS (for OS/2), and a variety of
   others. (BeOS support is not yet present but is expected sometime in
   2.4.x.) New filesystems have been added, most notably the UDF
   filesystem used on DVD disks and the EFS filesystem used by older
   versions of IRIX. All filesystems have been rewritten to some extent
   to support the new page caching system and will be more efficient
   because of this change.

   There are a number of improvements, which will improve compatibility
   with other systems. OS/2 users will finally be able to write to their
   filesystems from within Linux. NT users do not have this luxury yet as
   their driver is still in the experimental stage. NextStep users will
   be able to mount their CD-ROMs under Linux as we now support an
   extension to the UFS filesystem that NextStep uses. It should be noted
   that Linux does not yet support HFS+, the new Macintosh filesystem.

   Linux 2.4 does not yet include a general-use journaling filesystem,
   although several projects are close to providing this functionality.
   The largest advantage to journaling filesystems is their
   fault-tolerances. A well-designed journaling fileystem can be more
   easily restored after a crash than a traditional one resulting in
   much, much shorter fsck times and a faster return to service.
   ReiserFS, arguably the most mature of the current options, will likely
   go into the kernel sometime shortly after the release of Linux 2.4.
   (And possibly as early as version 2.4.1.) Ext3, an extension of the
   ext2 filesystem that includes journaling support, will also likely be
   ready sometime during the Linux 2.4.x development cycle. (But late
   enough that I'll have to talk about them in the Wonderful World of
   Linux 2.6...)

   For embedded devices, Linux 2.4 has added support for JFFS, the
   Journaling Flash Filesystem, and RamFS, an in-memory filesystem that
   is capable of resizing itself on the fly by being smart about the VFS
   layer. Both of these filesystems already have a devoted following in
   their respective circles of users.

Network Filesystems

   Not all filesystems are mounted over block devices. Some, like the
   proc, shared memory, and devfs filesystems, are completely virtual.
   Others are "mounted" over the network. Unfortunately, most modern OSes
   choose to go about sharing their filesystems over a network in
   completely dissimilar (and incompatible) ways. Luckily for us, Linux
   is able to understand many of the most common varieties of network
   filesystems.

   In the Windows world, Server Message Block (SMB) is the protocol of
   choice for their network filesystems. However, this protocol has been
   extended so many times that even different Microsoft OSes have
   incompatible features! The new version of the Linux kernel is now able
   to better recognize what kind of server is being used and to enable
   bug fixes as necessary. This feature will allow Linux users to
   seamlessly operate in hybrid environments.

   On the other hand, the UNIX world has standardized on (the aptly
   named) Network Filesystem (NFS). Linux 2.4 will markedly improve the
   stability of NFS mounted directories while also providing support for
   NFSv3, the most recent production version of the NFS protocol. NFSv3
   provides much better support for filesystem synchronization, file
   locks, and other concepts important to enterprise environments. (Down
   the road, support for NFSv4 has been announced to be under
   development.)

Partition Tables

   Linux has often been considered the Rosetta stone of operating
   systems. It should not some as a surprise then that Linux 2.4 will
   include much improved support for "foreign" partition tables on
   devices. Linux 2.2 and earlier editions of Linux allowed, for example,
   Macintosh partition tables to be read in the PPC or m68k ports, as
   they would be most likely to come across them. On Intel hardware, it
   was possible for the kernel to understand the "standard" IBM format,
   BSD disk labels, and some other common extensions. In Linux 2.4
   however, the walls between ports have come tumbling down and it will
   now be possible to seamlessly use an external Macintosh harddrive
   attached to an Intel Linux box. Essentially, Linux will be able to
   read any partition table format it understands on any port -- if the
   drivers are loaded in at compile time.

Character Devices - Keyboards, Mice, Consoles, and Ports

   The class of devices that can only be accessed sequentially is the
   character device. These are devices, such as serial devices, which
   allow you to read from a stream or push data onto it, but not to
   "skip" ahead or behind. This includes serial and parallel ports,
   keyboards, mice, and terminal devices. There have been several major
   improvements in this area for the latest incarnation of the Linux
   kernel.

   One of the largest improvements in this area is in regards to Linux
   2.4's support for keyboards and mice. Previous incarnations of Linux
   included support for serial and PS/2 mice and keyboards (and ADB, for
   instance, on the Macintosh.) Linux 2.4 also supports using keyboards
   and mice attached to the USB ports. Additionally, Linux 2.4 also
   supports keyboards on some systems where the keyboard is not
   initialized by the BIOS and systems that have trouble determining
   whether a keyboard is attached or not. And finally, Linux 2.4 includes
   expanded support for digitizer pads and features an emulation option
   to allow them to be used as normal mice, even when this is not
   directly supported in hardware.

   Linux's support for serial ports has not changed much since the days
   of Linux 2.2. Linux 2.4 (and some later versions of Linux 2.2)
   supports sharing IRQs on PCI serial boards; previously, this feature
   was limited to ISA and on-board serial ports. Additionally, Linux 2.4
   has added a number of new drivers for multi-port serial cards. It is
   hoped that these changes and others will make using your serial ports
   under Linux2.4 easier than before.

   In a separate department, there has been some work since 2.2 on
   supporting so-called "WinModems" (or "soft modems"). These are modems
   which exist largely in software and whose drivers are often only
   provided by the manufacturer for Windows. (Often the DSP or other
   parts of the hardware must be implemented in software rather than on
   the board.) While no code has been submitted to Linus for the support
   of these beasts, several independent driver projects have been working
   to get some support for these beasts in and the first fruits of these
   labors are becoming usable outside the main tree. While it will be a
   long time before we see most of these devices supported under Linux,
   for the first time it actually appears that the Open Source snowball
   is beginning to roll in this direction.

   Linux 2.4 also includes a largely rewritten parallel port subsystem.
   One of the major changes in this area is support for so-called
   "generic" parallel devices. Programs which access the parallel ports
   in unusual ways or, more likely, just want to probe the port for PnP
   information can use this functionality. Additionally, this rewrite
   allows Linux 2.4 users to access all the enhanced modes of their
   parallel ports, including using UDMA (for faster I/O) if supported by
   the hardware. Under the new Linux kernel, it is also possible to
   direct all console messages to a parallel port device such as a
   printer. This allows Linux to match the functionality of many
   commercial UNIXes by being able to put kernel and debug messages on a
   line printer.

Multimedia: Sound, TV, Radio, etc.

   On the complicated side of the character device list, we have some of
   the less essential devices to be supported by Linux. Linux, in its
   emerging role as a desktop platform, tries very hard to support sound
   cards, TV and radio tuners, and other sound and video output devices.
   To be honest, Linux 2.4 does not include as many groundbreaking
   changes as Linux 2.2 did in this respect. Linux 2.4 does, however,
   include updates and new drivers for a variety of sound and video
   cards, including adding full duplex support. Linux 2.4 and some later
   versions of Linux 2.2 also include code that will allow some sound
   devices to more easily allocate memory in required ranges; this should
   make the configuration and use of some cards much easier.

   Work is in progress on a completely rewritten sound subsystem, which
   will support many of the more advanced features of today's sound
   cards. This support will not be present in Linux 2.4, but may make it
   into the kernel for Linux 2.6.

Video Cards

   Another more complicated variety of device is the frame-buffer, a way
   of looking at many video cards. A frame-buffer is simply a section of
   memory that represents (or is) video memory to such an extent that
   writing to this memory affects the colors of the pixels on a screen.
   This is more complicated than most other devices because it requires
   ioctls to change the palette and to perform other video-related
   functions.

   Linux 2.4 includes a number of new drivers and improvements to old
   drivers. Especially important here is Linux's support for many more
   "standard" VGA cards and configurations, at least in some modes. (Even
   if the mode is only 16 colors-- at least it works.) Please remember
   that this feature can be bypassed and (on i386) is only necessary for
   people with certain systems, which cannot be supported in any other
   way. At this time,the XFree project provides many more drivers to many
   more video cards than the kernel can support so it is not necessary to
   use this feature to get support for the X Window System. (SVGAlib and
   other libraries also allow you to do direct video manipulation on
   supported hardware, however the use of these libraries must be done
   carefully as there are some security concerns and race conditions.)

   One of the biggest changes in this respect is the addition of the
   Direct Rendering Manager to the Linux kernel. The DRM cleans up access
   to the graphics hardware and eliminates many ways in which multiple
   processes that write to your video cards at once could cause a crash.
   This should improve stability in many situations. The DRM also works
   as an entry point for DMA accesses for video cards. In total, these
   changes will allow Linux 2.4 (in conjunction with Xfree4.x and other
   compatible programs) to be more stable and more secure when doing some
   types of graphics-intensive work. These changes should also make some
   kinds of television tuner cards more workable under Linux.

Networking and Protocols

   Networking and network hardware is one of the major areas where Linux
   has always excelled. These devices are neither "character" nor "block"
   but inhabit a special space free of the need for device nodes. Linux
   2.4 will include many improvements to this layer including new
   drivers, bug fixes, and new functionality added on to existing
   drivers.

   The Linux model of network sockets is one, which is standard across
   most UNIX variants. Unfortunately however, the standard does have some
   correctable deficiencies. Under Linux 2.2 and previous versions, if
   you have a number of processes all waiting on an event from a network
   socket (a web server, for instance), they will all be woken up when
   activity is detected. So, for every web page request received, Linux
   would wake up a number of processes, which would each, try and get at
   the request. As it does not make sense for multiple processes to serve
   the same request, only one will get to the data; the remainder will
   discover nothing to process and fall back asleep. Linux is quite
   efficient at making this all happen as quickly as possible, however it
   could still be made more efficient by removing the redundant wakeups.
   Linux 2.4 includes changes, which implement "wake one" under Linux
   that will allow us to completely remove this "stampede effect" of
   multiple processes. In short, "wake one" does exactly as its name
   indicates: wakes up only one process in the case of activity. This
   will allow applications such as Apache to be even more efficient and
   make Linux an even better choice as a web server.

   Linux 2.4 also includes a completely rewritten networking layer. In
   fact, it has been made as unserialized as possible so that it will
   scale far better than any previous version of Linux. Additionally, the
   entire subsystem has been redesigned to be as stable as possible on
   multiprocessor systems and many possible crashes have been eliminated.
   In addition, it contains optimizations to allow it to work with the
   particular quirks of the networking stacks in use in many common
   operating systems, including Windows. It should also be mentioned at
   this point that Linux is still the only operating system completely
   compatible with the letter of the IPv4 specification (Yes, IPv4; the
   one we've been using all this time) and Linux 2.4 boasts an IPv4
   implementation that is much more scalable than its predecessor.

   As part of this major rewrite, the firewall and IP masquerading
   functionality of the kernel has been completely rewritten again.
   (Older users may remember that these same components were largely
   rewritten for Linux 2.2 also.) The new subsystem has been split into
   two parts: a packet filtering layer and a network address translation
   (NAT) layer. These new subsystems are considerably more generic than
   their predecessors, and it is now possible to do most types of
   sophisticated (level 3) routing through any Linux box. Previously,
   this kind of functionality was largely only available with dedicated
   and proprietary routing hardware. Unfortunately, this major rewrite
   also includes yet another new userspace tool to manage the available
   functionality. For compatibility, modules exist which will allow you
   to use either the Linux 2.0 (ipfwadm) or Linux 2.2 (ipchains) tools
   without a major loss of functionality. This will make the upgrade from
   either of these kernel versions relatively seamless.

   One major new extension that has now been added to Linux's networking
   stack is ECN, Explicit Congestion Notification. In a nutshell, ENC
   allows compliant routers to notify a Linux box that a route is
   congested. Linux will then respond by reducing the speed at which
   packets are being sent. In the long run, this will allow Linux boxes
   to drop less packets over the congested routes and not spend as much
   time or bandwidth with dropped packets and retransmits.

   For Enterprise-level users, there are a number of features that will
   better enable Linux to integrate into older and newer components of
   existing network infrastructures. One important addition in this
   respect is Linux 2.4's new (partial) support for the DECNet and ARCNet
   protocols and hardware. This allows for better interoperation with
   specialized systems, including older Digital/Compaq ones. Also of
   special interest to this class of users, Linux 2.4 will include
   support for ATM network adapters for high-speed networking.

   For the low-end desktop users, PPP is an important part of day-to-day
   life. Linux 2.4 includes some major rewrites and modularization of
   much of the code, including a long awaited combination of the PPP
   layers from the ISDN layer and the serial device PPP layer, such as
   for dial-up connections with modems. In addition to the modularity,
   ISDN has been updated to support many new cards. The PLIP (PPP over
   parallel ports) layer has also been improved and uses the new parallel
   port abstraction layer. And finally, PPP over Ethernet (PPPoE, used by
   some DSL providers) support has been added to the kernel.

   Although not present in Linux 2.4, there is work now on supporting the
   NetBEUI protocol used by MS operating systems. While Microsoft will be
   moving away from this protocol in its products and towards TCP/IP,
   this protocol is still important for a number of Windows-based network
   environments.(Previously, kernel developers had commented that the
   protocol is too convoluted and buggy to be supported in the kernel.
   Now that an implementation has surfaced, it remains to be seen whether
   it will be stable enough to ever be in an official kernel.)

Other Changes

The Program Loader

   One often-overlooked portion of the Linux kernel is the program
   loader; the bit that takes your programs, loads them properly, and
   runs them. Many people are not aware however that Linux 2.2 added
   support for a "miscellaneous" binary loader, a flexible module
   designed to allow you to associate binary types (based on extension or
   file header information) with "helper" applications in much the same
   way as Windows or a comparable operating system would. This would, for
   example, allow you to associate all Windows applications on your
   machine with WINE (Windows Emulator) so that when you typed
   "./notepad.exe" the right thing would happen. (However it is generally
   not a good idea to take this concept to the extreme at the kernel
   level. Many of the "associations" provided by Windows would best be
   handled by your file manager or desktop environment. It would be a bad
   idea, for example, to be able to run "/etc/passwd" and have it come up
   in a text editor. My personal recommendation is to use this
   functionality only when the file type is best imagined as
   "executable.") This was considered a big win by many because it
   allowed many different groups, such as the WINE (Windows non-Emulator)
   and Dosemu (DOS Emulator) groups, to publish instructions for making
   their programs run "native" by the kernel.

   Linux 2.2 and Linux 2.0 included built-in support for starting a Java
   interpreter (if present) whenever a Java application was executed. (It
   was one of the first OSes to do this at the kernel level.)Linux 2.4
   still includes support for loading Java interpreters as necessary, but
   the specific Java driver has been removed and users will need to
   upgrade their configurations to use the "Misc." driver.

The Kernel Web Daemon

   One of the most striking features in the Linux 2.4 kernel is the
   kernel web daemon, or khttpd. It's true; Linux actually supports a
   kernel module that can process HTTP requests without having to
   communicate with any user space servers (such as Apache.) This feature
   is often misunderstood-- it is not designed to replace Apache or any
   other web server and it can be used only when serving raw files (no
   CGI.) If it receives a request for something that it cannot handle, it
   will "pass through" the request to user space where a web server can
   snatch it up and process it without ever being able to know the
   difference. This feature will make Linux an even better choice for
   rapid-fire web serving of static content, such as dedicated image
   servers.

Accessibility

   When thinking of Linux, the words "user friendly" do not generally
   come immediately to mind. Therefore, one might be surprised to learn
   that Linux 2.4 (and some later editions of the Linux 2.2 kernel)
   supports speech synthesizer cards. This driver and the appropriate
   hardware will allow vision-impaired Linux users to hear all Linux
   output, including kernel messages very early in the boot process. Very
   few operating systems can boast such low level support for these
   devices. (There will be other patches and utilities that will be
   required for full use of these devices; this kernel driver is only a
   component of the system.)

Documentation

   In addition to many, many feature changes, Linux 2.4 also includes a
   much more expansive set of documentation included with the kernel.
   Included in the set is, for the first time, documentation in the
   DocBook documentation format, a format similar to HTML that has been
   embraced by GNOME and other GNU projects.

About this Document

   Reproduction and translation are permitted (and encouraged) provided
   that the entire text remains intact. As this document changes
   frequently, please email me if you would like to mirror this document
   on a website to ensure that you have the most recent revision. If
   you'd like to reprint the article in any other medium, please let me
   know.

   All other rights are reserved, of course. Trademarked names belong to
   whoever it is trademarked them.




Get FREE Email/Voicemail with 15MB at Lycos Communications at http://comm.lycos.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
