Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132886AbREHR3D>; Tue, 8 May 2001 13:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133012AbREHR2x>; Tue, 8 May 2001 13:28:53 -0400
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:16277 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id <S132886AbREHR2o>; Tue, 8 May 2001 13:28:44 -0400
Message-ID: <3AF82D3E.C916B055@rz.tu-ilmenau.de>
Date: Tue, 08 May 2001 19:30:38 +0200
From: Alexander Eichhorn <alexander.eichhorn@rz.tu-ilmenau.de>
Reply-To: alexander.eichhorn@rz.tu-ilmenau.de
Organization: Technical University Ilmenau
X-Mailer: Mozilla 4.7 [de] (WinNT; I)
X-Accept-Language: de,en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [Question] Explanation of zero-copy networking
In-Reply-To: <Pine.LNX.3.95.1010507145625.6441A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At first, thanks for the (unexpected large) discussion and hints! 

Second: sorry for the multimedia-centric viewpoint, but i think
it's an important task for future operating systems development
(or better: for a real world OS like linux) to have sophisticated 
support for a _large diversity_ in application requirements 
and realtime/multimedia apps are treated stepmotherly for too long.


"Richard B. Johnson" wrote:

> So, the kernel is going to send a packet to another host on
> behalf of the system caller.  It copies the data,  (partial
> checksum) assembles the packet, finishes the checksum, then
> sends it.  The CPU is given to somebody  else while waiting
> for the packet to  get somewhere and be ACKed.  But,  think
> about a server  where EVERY  task  is  waiting  for I/O  to
> complete!  These CPU cycles,  that you saved by eliminating
> a copy (or two), are now wasted spinning.
>
> Basically, "no copy" is an academic exercise. It makes the first
> packet get sent more quickly, after which everything slows to
> the natural bandwidth of the system.

This is the semantic of a typical client/server request/reply 
protocol which is used in "traditional" applications. But it isn't 
appropriate for the communication of realtime mediastreams
because it breakes the strict timing constraints. Here we need
asynchronous (*non blocking semantics*) communication.

> 
> If you used a server for multicast-only.  In other words,  you
> just spewed out unidirectional data, you still slow to the rate
> at which the media can take the data.  And CPUs can obtain or
> generate these data a lot faster than 100-base can sink them.
> 
> When we get to media that can sink data as fast as we can generate
> them (it), then we have to worry about memory copy speed. However,
> these new devices are actually an IP subsystem.  They generate and
> receive entire datagrams. To fully utilize these devices, the data-
> gram generation and reception (the basis of all TCP/IP networking)
> will have to be moved out of the kernel and into these boards. The
> kernel code will only handle interfaces, connections, and rules.

Ohhhh, these are the arguments of people rather investing in
more ressources than investing in clever algorithms. It's comparable 
to the old war between the ATM folks and the IP/Ethernet folks; 
concepts against "brute" ressources. 

1. You don't take into account that there are not only high-end PC's and
Workstations with enormous CPU and memory resources! Devices for 
"pervasive ubiquitous computing" (don't blame me for this fashion word)
for example are mostly embedded systems with scarce ressources, happy
to have enough CPU-cycles for video-codecs. 

2. On the other hand are Video-on-Demand servers with (not only one)
high speed NIC's, large SAN's or disk arrays for video storage with
gigabit/infiniband connections, <fill in your favorite toy>. Here's
the problem not only saturating the links (for economic reasons), but
also to guarantee low delay and jitter to every connection. 
I think we should extend the usability of linux to this class of 
servers too.

3. Have a look at the various papers on high performance networking.
The gap between the growth in network bandwidth and the growth in CPU 
and bus performance is increasing. Today the system-busses are not 
considered to be in the "window of scarcity" (today we have 100MBit 
Ethernets and 133++MB/s PCI). Tomorrow our operating system concepts 
have to cope with 1, 10, ?? Gigabit Ethernets, Infiniband ,
... who knows.

This means: scale CPU and memory-bus performance accordingly or 
use ressource-sparing ipc-mechanisms and implement computational 
complex algorithms (checksum calculations, encryption) in hardware.
Besides continuous-media applications other applications who need
to move data-chunks much larger as the CPU-caches will
benefit from such infrastructures too. (Both classes of systems 
from above will be affected.)

For those applications copy avoidance is so fundamantal or 
copying is so expensive because copying needs all three basic 
system ressources (CPU, memory and bandwidth of local communication-
facilities - busses) at the same time (synchronous)!

Many researchers recognized this problem and developed techniques 
to overcome the dusted os-concepts (UNet, UVM,..). Unfortunately
they need special hardware (NIC's), have partially too much 
overheads or are not general enough. The one thing it shows us
is that there is still some work to be done.

Regards,

Alexander Eichhorn

-- 
Alexander Eichhorn
Technical University of Ilmenau
Computer Science And Automation Faculty
Distributed Systems and Operating Systems Department
Phone +49 3677 69 4557, Fax  +49 3677 69 4541
