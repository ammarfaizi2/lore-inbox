Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263085AbSJGPMv>; Mon, 7 Oct 2002 11:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263086AbSJGPMu>; Mon, 7 Oct 2002 11:12:50 -0400
Received: from franka.aracnet.com ([216.99.193.44]:62097 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263085AbSJGPLn>; Mon, 7 Oct 2002 11:11:43 -0400
Date: Mon, 07 Oct 2002 08:15:01 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Oliver Neukum <oliver@neukum.name>, Helge Hafting <helgehaf@aitel.hist.no>,
       linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Message-ID: <1367128987.1033978499@[10.10.2.3]>
In-Reply-To: <m17yUp7-006fgcC@Mail.ZEDAT.FU-Berlin.DE>
References: <m17yUp7-006fgcC@Mail.ZEDAT.FU-Berlin.DE>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OpenOffice _is_ an important application, whether we like it or not.
> 
> How does one measure and profile application startup other than with
> a stopwatch ? I'd like to gather some objective data on this.

I suggest a slightly (not a lot) more sophisticated stopwatch ...

Use -mm kernels, that's where the latest vm stuff is
http://www.zipworld.com.au/~akpm/linux/patches/2.5/2.5.40/2.5.40-mm2/
and Andrew is normally wonderfully responsive to clear data from 
profiles (see oprofile below)

Then either use strace with the time option on it (-t?), or:

1. use oprofile (grab from akpm's site:
http://www.zipworld.com.au/~akpm/linux/patches/2.5/2.5.40/2.5.40-mm2/experimental/), and boot with idle=poll

2. in one window type the command to stop the oprofile stuff, but
don't press return (something like "op_stop > /dev/linux")

3. In another window do:

rm -rf /var/lib/oprofile

op_start --vmlinux=/boot/vmlinux --map-file=/boot/System.map --ctr0-event=CPU_CLK_UNHALTED --ctr0-count=300000 > /dev/null

my_application

4. When your app finishes starting, hit return in that first window.

5. oprofpp -dl -i /boot/vmlinux  > data_dumpy_place.

Examine output.
Or something along those lines. Not very sophisticated, but that's
what I'd do I guess (what does that say? ;-))

M.

PS. Actually the combination of an strace and profile might be most
meaningful (though you might want to do them seperately ... make
sure the cache is either cold or warm both times, not one of each).

