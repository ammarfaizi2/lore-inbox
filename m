Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154780AbPGaWfP>; Sat, 31 Jul 1999 18:35:15 -0400
Received: by vger.rutgers.edu id <S154716AbPGaWe5>; Sat, 31 Jul 1999 18:34:57 -0400
Received: from mail.linuxtoday.com ([216.88.73.5]:4537 "EHLO bigserver.linuxtoday.com") by vger.rutgers.edu with ESMTP id <S154713AbPGaWev>; Sat, 31 Jul 1999 18:34:51 -0400
Message-ID: <37A379E8.2B32D359@lycos.com>
Date: Sat, 31 Jul 1999 18:34:16 -0400
From: Joseph Pranevich <jpranevich@lycos.com>
Reply-To: jpranevich@linuxtoday.com
X-Mailer: Mozilla 4.61 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu
Subject: [offtopic] Wonderful World of Linux 2.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Hello,

I have recently written an updated version of my Linux 2.2 article which
lists the features and whatnot of Linux 2.4. (Or rather, Linux 2.3. But
just try and explain that to many journalists...) I would very much
appreciate your input, as deveolopers, to the writing process. I'm not
as in the loop as I used to be, unfortunately. If anyone can provide any
input, I would appreciate it muchly.

Now, the last time I did this, I got flames when I sent the file to the
list and flames when I didn't. It's a lose-lose situation for me, but I
did nicely preface this whole thing with "offtopic" so I hope that too
many people whp pay by the byte don't try and download it.

I'm particularly lacking in input from the sound, video4linux, scsi, and
network side of things. But if you know of any major feature that I left
out, don't hesitate to let me know. Just be nice about it. :) Also, if
you would respond just to me or trim off the real article in any
replaies, it would save a lot of people bandwidth.

Thanks so much for any input that you might have,

Joe

--

Wonderful World of Linux 2.4 (7/31/99) "Making it right II"

A long time ago, in a galaxy not to far from this one, I wrote an
article.
It wasn't much, just a laundry list of the new and improved features of
Linux 2.2. That was a long time ago and the newness of Linux 2.2 is
beginning to wear off; it's even lost that new kernel smell. And so with
anxious eyes, we set our eyes towards the future of Linux: Linux 2.4.
When
is it due? When it is ready. (But between you and me, we're shooting on
sometime in late fall.)

Before we move into the meat and bones of the situation, I always like
to
step back for a moment and say a few things. Linux 2.2 marked a major
milestone in Linux's evolution: it was the first kernel release which
truly
caught the eye of the all-seeing media. No longer would just obscure
computer publications trumpet the coming of the open source revolution,
but
mainstream publications as well. With the attention has come the
inevitable
FUD (Fear, Uncertainty, and Doubt) that we prayed would never come, but
out
of this media molasses we have emerged as a stronger community. While
many
of Linux's weak points were trumpeted across the sky and many members of
the Linux community despaired, there were still the legions of kernel
hackers that worked day and night to take those weaknesses, acknowledge
them, and work to fix them. I think they've done wonderful job.

As a side effect of the increased media attention, many members of the
media chose to use my original article as a guide, a reference to the
new
changes and features in Linux 2.2 in the absence of any official press
release. To be honest, I was flattered. I do ask however that you cite
the
source whenever possible (both myself and the community who made this
document possible) and if you require any clarifications, please do not
hesitate to email me at the address below with your questions. If you
would
like to reprint or translate this article in full or in part in any
medium,
please email me at the address below so that I can be aware of your work
before you do so. I will make a list of translations that I am aware of
available.

Now, without further ado, Linux 2.4. This draft of the WWoL2.4 is
subtitled
the "making it right edition" and will be definitely followed by a
number
of later drafts, at least 3 of which I will term "final". We all have
different notions of what changes are important, if I don't mention a
particular update that you feel is important, by all means please let me
know.

Joe - jpranevich@linuxtoday.com

< Many thanks to linuxtoday for providing me with the spiffy email addy.
>
--

The Heart - Linux Internals

Linux 2.2 was a great improvement over Linux 2.0. It supported many new
file systems, it supported a completely rethought caching system for
file
names, and it was much more scalable than Linux 2.0. Linux 2.4 will
build
on the great advancements provided under Linux 2.2 to become an even
better
platform for desktop, server, and embedded tasks. However, it is the
intent
of the Linux kernel developers to get Linux 2.4 into the hands of the
end
users much more quickly than Linux 2.2 did. To meet this goal, Linux 2.4
will understandably not be as different from Linux 2.2 as Linux 2.2 was
from Linux 2.0. I think you will agree however that the advancements in
Linux 2.4 will be just as noteworthy as previous versions. (Or else I
wouldn't need to be writing this!)

What, at the core, is Linux? Linux is much more than just a collection
of
assorted device drivers, as any operating system must certainly be. It's
what binds these drivers together into a cohesive unit that matters.
It's
the scheduler, the resource allocator, the virtual filesystem layer,
memory
management, and so many other unsung features that are the real heroes
of
the Linux world. These are the portions of the Linux operating system
that
really define what is Linux because on every platform that Linux has
been
ported to from i386 (Intel-compatible PC), to ARM (embedded devices), to
Sparc64 (high-end servers) this code is the same. In many ways, the
"heart"
of Linux 2.4 is different than Linux 2.2's and most of the subsystems
that
I just listed have been changed in one way or another.

Linux 2.2 and earlier Linux's included a base resource management system
which was used rather bluntly to allocate and keep track of IO ports and
IRQ lines and the other limited niceties of computer architectures.
Unfortunately it was deficient in a number of important ways which are
crucial to modern desktop operating systems: it lacked the ability to
cleanly handle nested resources (where we handle one device's memory as
a
subset of another, for example a PCI bus), it included a hardcoded list
of
resource types, and other deficiencies. In the interests of better
resource
management, the old code was scrapped in favor of new code which
resolved
the issues that I just described. While it has not been put to this use
yet, it has been suggested that the new resource allocator code may put
us
one step closer to real PnP support in the kernel. (For a more detailed
discussion of PnP, please check the section on buses, below.)

The Linux model of network sockets is one which is standard across most
UNIX variants. Unfortunately however, the standard does have some
deficiencies but these deficiencies can be corrected without breaking
the
standard altogether. Under Linux 2.2 and previous versions, if you have
a
number of processes all waiting on an event from a network socket (a web
server, for instance), they will all be woken up when activity if
detected.
So, for every web page request received, Linux would wake up a number of
processes which would each try and get at the request. As it does not
make
sense for multiple processes to serve the same request, only one will
get
to the data; the remainder will notice that it doesn't have anything to
process and fall back asleep. Linux is quite efficient at making this
all
happen as quickly as possible, however it is still very inefficient...
but
there is a better way. Linux 2.4 includes changes which implement "wake
one" under Linux which will allow us to completely remove the "stampede
effect". In short, "wake one" does exactly as its name indicates: wakes
up
only one process in the case of activity. This will allow applications
such
as Apache to be even more efficient and make Linux an even better choice
as
a web server.

Linux includes other changes that will make it a better choice for
higher-end systems in particular. Linux 2.2 scaled to multiple
processors
much better than did Linux 2.0 (the first version of Linux to support
multiple-processors at all.) This was primarily achieved by removing a
global kernel lock and replacing it with finer granularity locks which
would allow more work to be done on multiple processors at once. Linux
2.4
takes this advancement even further as many subsystems' locks have been
replaced or rethought to allow finer control. In fact, several key
subsystems including TCP/IP (IPv4) and the virtual filesystem layer
(VFS)
have been completely rewritten with the intent to provide more
scalability.
8-way scalability under Linux is now a reality! (Linux can still scale
to
as many as 64 processors on some high level machines, however certain
kernel activities would have to have complete control of the machine.
What
these changes allow us to do is spend considerably less time in routines
that require complete control and let the rest of the system go faster.)

The virtual filesystem layer, as previously mentioned, has been
optimized
for multi-processing, but that is not the only change in that layer.
Linux
2.2 featured a number of wonderful changes to the filesystem layer to
support better caching, however it still used a split buffer system that
kept the reading and writing buffer separate. Linux 2.4 brings this wall
down with a complete rewrite of the page caching layer leading to a
subsequent reduction in overall memory needs and removing a number of
cases
where Linux had to jump through hoops to keep the two caches in synch.
Overall, this is a more efficient system allowing for many operations,
including synching, to happen much more rapidly than could be managed
previously. There were other changes to made to this layer in the
process,
including the removal of race conditions (when multiple processes can
manage to interfere with each other because they "race" for access to
variables), the speeding up of large writes to multiple disks at once,
and
the dynamic allocation of file descriptors (which allow more files to be
open at once, in some cases.) These changes led to some necessary evils
(described in the filesystem section) but overall I feel that this is a
total win for Linux.

One common problem with Linux 2.2 that interfered with high-end (Intel?)
machines was its process limitations. Linux 2.2 only allowed you to have
1024 processes or threads running at once. With high-end systems with
many
thousands of users, this could become a problem very quickly. Linux 2.4
has
gotten rid of this relic and implemented a scalable limit which can be
configured at run time. The number of simultaneous processes is limited
of
course to the amount of RAM you have in the system. On high-end servers
with as little as half a gigabyte of RAM installed, it is easily
possible
to support as many as 16 thousand processes at once. Other users have
reported being able to run many more than that on their specific
systems.
This was one of the major bottlenecks that kept Linux out of the
Enterprise
markets.

In terms of memory consumption, Linux 2.4 will require approximately the
same amount of memory as does Linux 2.2. Some subsystems have been added
or
expanded and some have been streamlined. Some obsolete code has been
removed. There are even certain cases where some systems will require
less
memory than Linux 2.2!

Processors and Ports

While infrastructure is the heart of the Linux operating system, it is
the
parts of the operating system that are specific to the individual
flavors
of Linux that are most obvious to the end users. These "arms and legs"
of
the Linux operating system include all of the architecture dependent and
independent driver code which controls the processors, disk drives,
ports,
and everything else that provides real access to the computer. For the
purposes of this article, I will be concentrating on i386 Linux which is
the Linux that I use most often at home. That is not to say that there
have
not been great advancements in other areas, however they are beyond my
direct experience. If there is enough demand, and someone is interested
in
helping, I may be willing to write appendixes which describe some of the
big improvements in other areas. There have been no new ports entered
into
mainstream Linux since Linux 2.2 although this may change.

On Intel-compatible hardware, Linux 2.4 includes the same excellent
support
for processors as did Linux 2.2. This includes optimizations for 386,
486,
586 (Pentium), and 686 (Pentium Pro / Pentium II / Pentium III)
processors, as well as "compatible" counterparts such as those made by
AMD
and Cyrix. Additionally, Linux 2.4 will include additional support for
hardware present with modern chips. While Linux 2.2 includes support for
Intel's Memory Type Range Registers (MTRRs) to raise performance to some
kinds of high-bandwidth devices, Linux 2.4 has taken this support even
further by supporting variants common to the compatible chips. This
includes the double MTRRs present with AMD K7 processors and MCR variant
preferred by Cyrix. Linux 2.2 also included support for the IO-APIC
which
allowed interrupts to be spread across multiple processors in a
multi-processing system. Linux 2.4 will, as expected, take this to the
next
level and support some high-end systems which actually contain multiple
IO-APIC controllers; this will increase performance on these machines.

To my knowledge, the only multi-processor systems which we still do not
completely support are some very old 486 ones that mix 486DX and 486SX
chips in the same system. This is mainly because the SX chips did not
contain math coprocessors and there is some difficulty in making sure
that
applications that need floating point math get to work on the right one.
As
you can imagine, there isn't much call for this feature.

In terms of what types of programs it can run, Linux 2.4 is very much
the
same as Linux 2.2. The only notable exception to this rule is that
support
has been removed to run Java applications directly, it has been replaced
by
a more modular system which allows for arbitrary associations, not
unlike
Windows's own associations. This change is not new to Linux 2.4, however
you will have to configure this before your Java applications will work.
The removal of this feature will save memory on some configurations,
albeit
not much.

Buses - ISA, PCI, USB, MCA, etc.

Processes however are just a small part of the guts of a computer.
Equally
important to its operation is its bus architecture because it is this
component of the system that is responsible for (or irresponsible
towards,
as the case may be) internal devices. Linux 2.4 has not yet touched much
on
the internal workings of many of the supported busses, including (E)ISA,
VLB, PCI, and MCA except to begin to work them into the new resource
management subsystem. Plug-and-Play, the somewhat misguided attempt to
support device configuration and detection on the ISA bus, is still not
supported at the kernel level. However, PnP devices can still be used
somewhat easily by configuring them from userspace with the isapnp
utilities package available with nearly every distribution. Once
configured, PnP devices can be loaded using modules just like any other
device.

There is exciting news from this front however. Universal Serial Bus, a
new
bus type just now coming into prominence for devices such as keyboards,
mice, sound systems, and scanners is now supported in the Linux kernel.
At
the time of this writing, the support is not 100% and many individual
and
common USB devices are not supported or not completely supported. I
would
be confident however that the number of devices which are supported will
only rise over time, just as we observed a similar rise in the number of
framebuffer devices that are now supported. (The framebuffer was a new
feature to Linux 2.2, see below.) Currently, keyboards and mice are
working
mostly as you would expect. Support for sound systems is coming along
rapidly. Other devices, such as modems and network cards, already have
preliminary support however their drivers are not complete.

In addition to USB, I2O device (Intelligent Input/Output) support, an
extension of PCI, has been added in Linux 2.4. In theory, this will
allow
for more operating system independent devices and drivers to exist. Many
I2O devices are already functioning and more will be added before Linux
2.4.

PCMCIA support is still not provided in the kernel as shipped by Linus.
However the code is generally available and provided built-in to most
distributions. This is done by mutual agreement.

Block Devices - Disk Drives, RAID Controllers, etc.

Now, just having a bus and a processor does not' make a computer any
more
than a skeleton and heart would make any other organism. To spread this
analogy even further into the realm of not actually being applicable,
you
need a brain. No, not to think with, that's handled in our heart.
(Imagine
for a moment that we still subscribe to the classical theory of
anatomy.)
Instead, we need a brain to hold our data and actually do meaningful
things.

Linux 2.2 already supported the most common types of storage media
including RAID controllers, IDE and SCSI disks, and many other
advancements. Linux 2.4 has built on this by providing more of the same:
more drivers for more cards and more stability for the ones that already
exist. Linux 2.4 has also made it easier for larger systems at this
level
by doubling the number of IDE controllers supported internally in the
kernel to 8. If you have one of these beasts, you will now be able to
use
all of its interfaces. There have also been some kernel changes to allow
for better support of IDE CD changers although support for having
multiple
CDs in the changer mounted at once is not provided. (For obvious
reasons:
the latency on a multi-user machine would be terrible!) And finally,
Linux
2.4 is much better at identifying buggy or special IDE hardware and
enabling workarounds or speed enhancements.

SCSI has received less advancements in Linux 2.4, except for the
touching
down of a number of new SCSI controller drivers.

It's long been traditional for Linux developers to take ideas and
concepts
that "make sense" from one operating system and apply it to Linux.
Rarely
however do these ideas emerge onto the Linux scene without an incredible
amount of thought and digestion, usually resulting in a better final
idea.
One particular idea was adapted from mainstream UNIX: raw device i/o,
the
ability to access a low-level block device directly and without any
intervening cache layer. Few doubt that this idea had its merits,
however
the traditional implementation of this idea (the creation of "raw"
devices
corresponding to each and every block device) was unacceptable to Linux
developers. Eventually, a solution was developed that even Linus could
agree on: the ability to associate a raw character device with any
arbitrary block device without having to preallocate many unnecessary
device nodes. While applications to this system are not obvious to the
casual desktop user, this system allows greater control to applications
that want it, including and especially database applications which are
smart enough to do their own disk management..

Filesystems

Having a block device is only really useful if you can have some data on
it. But having data is useless unless it is in some prescribed format
which
allows for convenient storage and retrieval. By this point, we have
completely broken my analogy. Oh well. It should also be mentioned that
these filesystems (as well as nearly everything else) will work with all
versions of Linux and are not only applicable to i386 Linux.

Linux 2.4 includes all of the new filesystems present in Linux 2.2.
These
filesystems include FAT (for MSDOS), NTFS (for Windows NT/2000), VFAT
and
FAT32 (for Windows 9x), HFS (for Macintoshes), and many, many others.
All
of these filesystems have been rewritten to some extent to support the
new
page caching system and will be more efficient because of it. On the
flip
side however, binary-only filesystem modules designed for Linux 2.2 will
not work with Linux 2.4. (Unlike some software firms, Linux does not
generally provide for back-compatibility at the module level. Generally,
open source modules can adapt quickly enough and binary module providers
are expected to do the same or release the code.)

Some users will however notice major improvements to allow for better
compatibility with other systems. OS/2 users will finally be able to
both
read and write to their disks under Linux. (This change is a long time
in
coming.) Linux 2.4 will also include a couple of improvements designed
to
make it interoperate better with other UNIX-like operating systems. Key
to
this is Linux 2.4's upcoming support for the IRIX efs filesystem and the
IRIX disklabel (partition table) format. Also, support for NextStep has
also improved as the UFS driver now supports its CDROMs.

Users who mount Windows shared drives via SMB (Server Message Block
protocol) will be pleased that there will no longer be a compile time
option for enabling workarounds for (released broken) Win9x systems.
Instead, Linux will be able to detect what kind of system it is
connecting
to and enable bug fixes as needed. This will make Linux a considerably
better option for heterogeneous networks.

Of special importance to many Linux users is Linux's ability to mount
the
shared drives of UNIX operating systems. Linux 2.4 includes for the
first
time the ability to access NFS shares which conform to version 3 of the
NFS
protocol. NFS version 3 includes many advantages over previous versions
and
it has been one of Linux's most often requested features.

There are still some pieces of support that is currently lacking in
Linux
2.4. There is no support for journalizing filesystems, for instance. Due
to
the relatively low fsck times and the ease of data recovery journalizing
filesystems support, this is considered by many to be an entrance
requirement to the enterprise. It is hoped that this and other "missing"
features will be completed before 2.4 is ready for release.

Input Devices - Keyboards and Mice

Now, storage is important and the bus is important, but if you can't do
anything with the machine yourself then it really is not any use to you.
To
desktop users, the keyboard and mouse are the input devices of choice.
It
is fitting then that Linux 2.4 includes some improvements to this arena.

The biggest news on this front is that Linux 2.4 will support for the
first
time keyboards and mice attached to the Universal Serial Bus. When
plugged
in, these input device will behave just as if they were "normal"
keyboards
and mice. Additionally, Linux will now work on more systems, including
broken (or specially embedded) ones where the keyboard is not
pre-initialized by the BIOS. Also, better support is provided for
machines
without keyboards in some cases. (Mostly for buggy machines that don't
handle the lack of a keyboard as well as one would like.)

There are some places where some people feel that Linux 2.4 could
improve,
of course. With the addition of USB we have the chance to have multiple
keyboards and mice attached to the same bus. Linux 2.4 however does not
have internal multi-heading of these devices; you cannot assign one
keyboard and one mouse to one terminal and another set to a different
terminal. Support for this is provided in the GGI project, however this
project's code has not yet (and may never be) synched into the
mainstream
kernel. (It is however a good place to check if you need this
functionality.)

Video: Console, Frame-buffers

Now, you have ways of getting data into your Linux box, but that's
really
of no use unless you can get data out. That's pretty pointless! Linux
2.2
included some of the most revolutionary features to hit mainstream
Linux's
console support since the introduction of virtual consoles. (which was
well
before v1.0) Primarily, these changes were in the modularity of the
console
subsystem and the inclusion of frame-buffer drivers into the kernel,
with a
virtual frame-buffer console. (This support had existed previously in
many
Linuxes, but was never made portable enough to be of any use to i386
Linux
users.) In theory, this may someday allow for every Linux user to use a
single, smaller, X server and keep video support in the kernel. In the
end
however the option to use a frame-buffer is just that, an option, and
while
many people may not agree in the extent of its usage, no one can doubt
the
important role that it plays in systems which do not have a built-in
text
mode.

Linux 2.4 expands on frame-buffer support in many ways. Many new drivers
have been added for video cards including better support for VGA
displays
and even really old (16 color) VGA. As promised, we are seeing Linux
gradually support a wider and wider range of hardware in this capacity.

Linux 2.4 also includes support, useful primarily for servers, to
redirect
console output (including kernel and debug messages) to a device on a
parallel port (a printer, for example.) Like many features, this is just
an
option however it has already proven useful in a number of server and
debugging configurations.

Ports - Serial, Parallel, Infra-Red, etc.

Linux has always had excellent support for ports, such as serial ports,
that allows one to get around many of the drawbacks currently in the
keyboard and video layers. Linux really does have excellent support for
consoles, even system consoles with boot messages, on the serial ports.
It
is fitting that Linux 2.4 has improved support for many of these port
types
that are in common use today.

Serial support for Linux 2.4 has not changed much and many of the same
limitations still apply. (In particular, setting module options is
generally done with an external utility rather than the standard
parameters
usually passed to loadable modules.) Later versions of Linux 2.2 and all
versions of Linux 2.2 will allow one to share IRQs on PCI serial boards;
previously this was only allowed on ISA cards and on-board serial ports.
Some other pieces of multiport hardware will be better supported under
Linux 2.2. More updates and new drivers are flowing in regularly.

In contrast, the parallel port subsystem has undergone some major
overhauls
since 2.2. There is now a generic parallel port driver for abstracted
communication with "unknown" types of parallel devices. This could be
used,
for example, by programs that want to poll the parallel port for
Plug-and-Play information. (This is completely unrelated to the
Plug-and-Play capabilities of ISA cards.) Additionally, this has the
side
effect of allowing the root console to be spit out to a parallel port:
you
can configure this to cause console messages to be written out to a
printer. (This is especially useful for debugging in cases when copying
from the screen just won't do.) Also, Linux 2.4 supports writing to the
parallel ports using DMA, if supported in the hardware. This will speed
up
access to printers and other parallel devices.

Infra-red support has progressed since Linux 2.2 and there have been
many
changes in this area, including better network support.

In a separate department, there has been some work since 2.2 on
supporting
so-called "WinModems". These are modems which exist largely in software
and
whose drivers are only provided by the manufacturer for Windows. (Hence
the
name.) While no code has been submitted to Linus for the support of
these
beasts, it is possible that we may see some support for them before 3.0.
One major obstacle here is that each and every WinModem is different; it
is
unlikely that a driver for one would be applicable to another and the
sheer
number of different types of WinModems would make this difficult or
impossible to ever get a decent selection of hardware supported.
Impossible
odds have never phased open source developers however and I for one will
not be surprised when the first driver makes it into the kernel,
someday.

Networking and Protocols

Even further distant from the simplicity of keyboards and mice,
networking
and network hardware is one of the major areas where Linux has always
excelled. Linux 2.2 included many improvements to this layer including
new
drivers. Linux 2.4 has expanded on the already great amount of supported
hardware by providing bug fixes and new drivers for a variety of cards
including and especially ISDN devices.

Linux 2.4 also includes a completely rewritten networking layer. In
fact,
it has been made an unserialized as possible so that it will scale far
better than any previous version of Linux. In addition, it contains many
optimizations to allow it to work with the particular quirks of the
networking stacks in use in many common operating systems, including
Windows. It should also be mentioned at this point that Linux is still
the
only operating system completely compatible with the IPv4 specification.
We
can be sure to see many more improvements in this area before the Linux
2.4
release date is reached.

Next to the new network layer, the next most important improvement in
the
Linux 2.4 network layer is the addition of code to handle the DECNet
protocols. This allows for better interoperation with specialized
Digital/Compaq systems.

For the low-end desktop users, PPP is an important part of day to day
life.
Linux 2.4 includes some major rewrites and modularization of much of the
code, including a long awaited combination of the PPP layers from the
ISDN
layer and the PPP layer used on serial devices, such as modems.

Multimedia: Sound, TV, Radio, etc.

And gradually, we have worked our way from the essential components of
the
system to the fluffy components, the ones that may or may not be useful
to
your individual needs. Linux, in its emerging role as a desktop
platform,
tries very hard to support these devices, including sound cards, TV and
radio tuners, and other sound and video output devices. To be honest,
Linux
2.4 does not include as many ground-breaking changes as Linux 2.2 did in
this respect. (Yet...) Linux 2.4 does however include updates and new
drivers for a variety of sound and video cards, including full duplex
support. Linux 2.4 and some later versions of Linux 2.2 also include
code
which will allow some sound devices to more easily allocate memory in
the
ranges needed by some sound cards; this should make the configuration
and
use of these cards much easier.

Linux 2.4 (and later versions of Linux 2.2) now supports the DoubleTalk
speech synthesizer card. This is the first piece of hardware of this
type
which is supported under Linux, maybe we'll see more of these in the
future. (Really, all the "cool" hardware types are already supported.
We'll
take what we can get. :) )

--

I appreciate any comments that you may have, especially changes that you
feel are important that I missed. For the purpose of keeping my email
sorted into nice, neat piles, please respond to
jpranevich@linuxtoday.com.
(Yes, .com. Watch the .com.)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
