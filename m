Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262590AbSKDTQf>; Mon, 4 Nov 2002 14:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262597AbSKDTQf>; Mon, 4 Nov 2002 14:16:35 -0500
Received: from [12.161.69.65] ([12.161.69.65]:17854 "EHLO
	osismtp.origin.ea.com") by vger.kernel.org with ESMTP
	id <S262590AbSKDTQe>; Mon, 4 Nov 2002 14:16:34 -0500
Subject: Re: Need assistance in determining memory usage
From: Thomas Schenk <tschenk@origin.ea.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1036436466.1106.105.camel@irongate.swansea.linux.org.uk>
References: <1036433472.2884.42.camel@shire> 
	<1036436466.1106.105.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Nov 2002 13:22:44 -0600
Message-Id: <1036437769.2902.76.camel@shire>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 13:01, Alan Cox wrote:
> On Mon, 2002-11-04 at 18:11, Thomas Schenk wrote:
> > was adequate, I wouldn't be asking here and every reference I could find
> > indicates that this is not a trivial problem.  There were also
> > indications I found while searching that these tools do not always
> > report memory numbers accurately.  If there is a way to determine this
> > information using /proc, this would be ideal, since I could then
> > conceivably create a script or simple program that could determine the
> > answer given the process ID, which is what the developers here really
> > want.
> 
> Neither the question nor the answer are trivial. What are you trying to
> do with the data may be the most relevant question

This situation is this:

We are building an online game system.  On some of the systems, there
are simulator processes running that each service a player.  There may
be up to 200 or more of these processes running at any given time and
each uses a fairly large amount of memory (as reported by ps).  Part of
this is due to the fact that the processes have not been optimized to
make the most efficient use of memory.  When the simulator processes
start swapping, then the systems are becoming unstable, performance goes
all to hell and sometimes the systems totally hang.  It would be useful
for us to be able to monitor as closely as possible the amount of memory
each processes is using and especially to be notified when these
processes start using significant amounts of swap, so that we can be
prepared to react before the situation gets out of hand.  The other
reason why we want to collect this data is so that the developers can
analyze the process when it starts to swap and determine if there
optimizations that they can make that will improve the memory
utilization of these processes so that more processes can be run on the
same box and that swap usage is minimized.  

A couple of points that may be useful (or not):

1.  These systems are based on RedHat 7.2, but are running a kernel
built from the kernel source tree for Advanced Server 2.1 (as obtained
from the kernel source RPM for the 2.4.9.e-3 kernel).  Originally, they
were running on the 2.4.18 kernel from RedHat 7.3, but in our particular
situation, the 2.4.9 Advanced Server kernel was found to have better
performance characteristics.

2.  Each of the systems running the simulator processes consist of the
following:

    Dual P4 Xeon 2.5 GHz processors (hyperthreading is enabled in the
      motherboard BIOS setup)
    4 Gigs of RAM
    3Ware RAID controller
    2 x 40 GB disks in RAID 1 configuration
    2 x E1000 NICS

3.  The only modifications that were made to the 2.4.9 AS kernel was to
update to the latest version of the E1000 driver from Intel, since the
one in the AS 2.1 kernel source tree didn't work with the systems.  The
reason why the kernel was compiled locally was to remove unwanted
options, such as USB and sound support, and to eliminate the need for an
initrd.

If further data is required, I can provide it.  Thanks for all who have
responded thus far.

Tom S. 
    
 
-- 
+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
| Tom Schenk      | A positive attitude may not solve all your    |
| Online Ops      | problems, but it will annoy enough people to  |
| tschenk@ea.com  | make it worth the effort. -- Herm Albright    |
+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

