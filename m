Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285169AbRLFQw1>; Thu, 6 Dec 2001 11:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285155AbRLFQvX>; Thu, 6 Dec 2001 11:51:23 -0500
Received: from dsl081-242-114.sfo1.dsl.speakeasy.net ([64.81.242.114]:16770
	"EHLO drscience.sciencething.org") by vger.kernel.org with ESMTP
	id <S285051AbRLFQvQ>; Thu, 6 Dec 2001 11:51:16 -0500
From: "Britt Park" <britt@drscience.sciencething.org>
To: <linux-kernel@vger.kernel.org>
Subject: userblock
Date: Thu, 6 Dec 2001 08:52:25 -0800
Message-ID: <NFBBJPODOLDHKMANGFPGAECJCAAA.britt@sciencething.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Userblock is a user space block driver kit and is available at
http://www.sciencething.org/geekthings/index.html.  Here's the README:

Userblock is a user space block device driver kit.  It works by
creating a character device through which a user space program can
handle block device reads and writes.  It was written mostly as an
exercise and to provide amusement.  It may however have some real
uses.  Encrypted filesystems could be written more easily using
userblock than using /dev/loop, since the encryption code wouldn't
have to run in the kernel.

Userblock has a few shortcomings:

1.) It is not bullet proof.  Badly behaved user space drivers can do
bad things in kernel space.  It is not, however, very difficult to
write well behaved user space drivers.  Note that the example user
space drivers, fileblock and userblock, are rudimentary.

2.) If your user space driver gets its data from a file, as in the
fileblock example, or uses memory for its data, as in the memblock
example, your data is effectively buffered twice.  Any suggestions as
to making this go away would be appreciated.


To build userblock and the examples:

1.) Make sure you have a 2.4.x kernel source tree installed somewhere.
I wrote this using 2.4.13.  Earlier or later kernels may require some
minor changes in userblock.

2.) Edit the CFLAGS line at the top of kernel/Makefile to remove
-DCONFIG_SMP if you are running on a UP system.  (I don't have a UP
system set up so I don't know whether userblock works at all on UP
systems.  I will be grateful to anyone who tests it.)  Also edit the
-I/usr/src/linux/include bit to point to the right place on your
system.

3.) make depend. make. Fix whatever is broken. Iterate.  (Please let
me know what went wrong so I can fix it for others.)


To use the examples:

>From the root directory of the distribution run either fileblock_start or
memblock_start as root.

fileblock_start syntax:
        ./fileblock_start size_in_kb backing_file
        backing_file does not need to match size_in_kb in size; it just has
        to exist.

memblock_start syntax:
        ./memblock_start size_in_kb

Once you've run either fileblock_start or memblock_start you will have
a block device called /dev/ub for fileblock_start or /dev/mb for
memblock_start.  You can do a mkfs on the device and then mount the
device.

To stop /dev/ub or /dev/mb, unmount any filesystems on them and run
either fileblock_stop or memblock_stop as root from the root directory
of the distribution.  Don't kill the user space driver programs
directly or you will run the risk of the kernel getting hosed.  Note
that fileblock_start, memblock_start, fileblock_stop and memblock_stop
are not intended as a production mechanism for starting and stopping
your devices.  They just demonstrate the syntax for running the kernel
module, the user space drivers and ubshutdown for shutting down
cleanly.


Writing your own user space drivers:

Follow the example drivers in fileblock and memblock.  Basically, a
user space driver opens the special character device, /dev/ubs or
/dev/mbs for the examples, and goes into a loop, first reading a
request from the kernel, next processing the request and then replying
to the request by writing back to the kernel.  There are three
request types: UBS_READ, UBS_WRITE and UBS_STOP.  Their names should
explain their function.


Please send me a message if you have questions, comments or
improvements or just for the hell of it.  I'm particularly interested
in suggestions to improve the synchronization in the kernel module.
What is there looks ugly to me but I haven't found a better way of
doing things.  The latest version of userblock should always be
available at "http://www.sciencething.org/geekthings/".

I can be reached at britt@sciencething.org

Cheers,

Britt Park

