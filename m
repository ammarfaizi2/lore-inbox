Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281162AbRKHAWo>; Wed, 7 Nov 2001 19:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281177AbRKHAWe>; Wed, 7 Nov 2001 19:22:34 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:10759 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S281162AbRKHAWU>;
	Wed, 7 Nov 2001 19:22:20 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111080022.fA80MHq68859@saturn.cs.uml.edu>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
To: erik@hensema.xs4all.nl
Date: Wed, 7 Nov 2001 19:22:16 -0500 (EST)
Cc: jfbeam@bluetopia.net (Ricky Beam), linux-kernel@vger.kernel.org
In-Reply-To: <20011107170836.A4782@hensema.net> from "Erik Hensema" at Nov 07, 2001 05:08:36 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Hensema writes:
> On Tue, Nov 06, 2001 at 05:09:28PM -0500, Ricky Beam wrote:

>> So, do you run 'free' or 'cat /proc/meminfo'?  'uptime' or 'cat
>> /proc/uptime'?  'netstat', 'route', 'arp', etc. or root through
>> /proc/net/*?  I bet you use 'ps' instead of monkeying around in all
>> the [0-9]* entries in /proc.  The fact is, we already have "little
>> programs" converting, shuffling, reformating, and printing out
>> those values.
> 
> Yes, but I meant a program which reads a single binary value and
> outputs it as ascii, as a generic layer between the binary /proc and
> the ascii world of shell scripts.

The following prints a single value as ASCII for Linux, Solaris,
AIX, Tru64, HP-UX, and any other POSIX system.

ps -o uid= -p 1

This is what you are supposed to do. With the above, you can write
portable shell scripts that work on any UNIX. (real UNIX + Linux)

> Maybe everything should be moved to /kernel? (except for the process info,
> offcourse).
...
> It will be very, very hard for distributors to create a distribution which
> runs one the native 2.6 /proc interface as soon as 2.6 comes out. I think
> we must assume rewriting things like procps, init scripts, etc. will only
> start as soon as 2.6 comes out. We should provide some transitional period
> for userspace to adapt, but make clear to everybody that compatibility
> isn't going to last forever.

The app fixing starts immediately for stuff in /bin. It is all
the k-apps and g-apps that will lag.

Splitting /proc can be done. Start by mounting procfs twice.
Make non-process stuff in /proc invisible, but still available.
Then in /kernel the process stuff can be disabled. The proc fs
code can even register two filesystem types, with different
default mount options. After a while, /proc/cpuinfo and such
can emit warnings. (2.5.z for z>42, and 2.y.z for y>6) Then for
the 3.1 kernel (10 years away?) the old crud gets removed.

