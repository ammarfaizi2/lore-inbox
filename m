Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbTJ2I2L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 03:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTJ2I2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 03:28:11 -0500
Received: from auth22.inet.co.th ([203.150.14.104]:39690 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S261925AbTJ2I17
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 03:27:59 -0500
From: Michael Frank <mhf@linuxmail.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8/test9 repeatable lockups at high loads - please reproduce
Date: Wed, 29 Oct 2003 16:26:36 +0800
User-Agent: KMail/1.5.2
References: <200310280544.33247.mhf@linuxmail.org>
In-Reply-To: <200310280544.33247.mhf@linuxmail.org>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310291626.37152.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 October 2003 05:44, Michael Frank wrote:
> Using attached stress tests on a P4 with IDE, 2.6.0-test8/test9 lockup
> repeatably within 5 minutes to an hour.
> 
> It is generally pssible to break into kdb debugger but not into kgdb.
> 
> Tests running fine with 2.4.22 and 2.4.21 for 100s of hours
> 
> Requirements:
> 
> gnu tool chain
> X 3 or 4
> configured ready to compile 2.4 or 2.6 kernel source tree linked to /usr/src/linuxtest
> /tmp directory and/or $TEMP set to a user writable temporary directory
> 200MB spare disk space
> 
> How to use:
> 
> $ ln -s /usr/src/yourlinux /usr/src/linuxtest
> $ tar jxf ti-tests.tar.bz2
> 
> to start the test:
> 
> $ ti-tests/ti 1
> 
> to stop the test
> 
> $ ti-tests/ti 0
> 

Sorry, README_TI file was missing. Enclosed

Regards
Michael

*****************************************************************************
ti-tests

Copyright 2003 Michael Frank, mhf@linuxmail.org

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
Version 2 as published by the Free Software Foundation.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
http://www.gnu.org/copyleft/gpl.html
*****************************************************************************

Version: 1.0-beta

1) What does it do
------------------

ti executes one or more concurrent functions to assert system level stress.
ti utilizes dd, the gnu tool chain and unixbench system level functions: syscall, pipe,
   context1, spawn, execl, fstime, fsbuffer, fsdisk, shell, C.

2) Individual functions
-----------------------

Each test function is run in a dedicated xterm or VT when not running under X.
All test functions can be run in the current terminal by prepending the function
name with an underscore such as in _ddw

compk - kernel compile consisting of make clean dep bzImage modules

ddw instances count - "instances" dd write loops of "count" 4K blocks. Instances is
                      in range of 1 to 10 and count must be > 0

ddr instances count - "instances" dd read loop of "count" 4K blocks. Instances is
                      in range of 1 to 10 and count must be > 0

3) Combined test functions
--------------------------

Each combined test function is run in a dedicated xterm or VT when not running under X.
All combined test functions can be run in the current terminal by prepending the function
name with an underscore such as in _ub2

ub2   concurrently run 2 unixbenchs - CPU's below 100MHz:
         syscall / pipe / context1 / spawn  / execl
         fsbuffer / fstime / fsdisk / shell / C

ub5    concurrently run 5 unixbenchs - for CPU's below 500MHz:
         syscall / pipe
         context1 / spawn
         execl / fsbuffer
         fstime / fsdisk
         shell / C

ub10 - concurrently run 10 unixbenchs - GHz CPU's:
         syscall pipe context1 spawn execl
         fstime fsbuffer fsdisk shell C

ub17 - executes ub2, ub5 and ub10

4) Status functions
-------------------

Each status function is run in a dedicated xterm or VT when not running under X.
All status functions except 'vm' can be run in the current terminal by prepending the
function name with an underscore such as in _msg

dmesg - show dmesg every second

la - loadavg every second

msg - show /var/log/messages every second

ps - ps -A every second

vm - show vmstat every second

5) Combined status functions
----------------------------

stat - show msg, dmesg, vm, la, ps

6) Combined status and test functions
-------------------------------------

0 - stop all

1 - start stat compk ub17 ddw 4 5000

7) Requirements
---------------

- Recent POSIX compliant shell such as bash 2.05
- Complete installation of gnu tools such as gcc and make
- Configured ready to compile 2.4 or 2.6 kernel source tree linked to /usr/src/linuxtest
- /tmp directory and/or $TEMP set to a user writable temporary directory

8) Security
-----------

Save all files and exit all applications in case reset is
required

Should not be run as root

Be sure that $TEMP/$FILE* does not match any valuable files

Avoid setting ddw/ddr instances > 5 and if so increase instances in small steps

9) Files
--------

ti -  the main test script
ti-run - modified unixbench Run script
pgms/* - unixbench ready to run programs
src/* - unixbench routines source
tmp/ - unixbench temporary files
results/ - unixbench temporary files
README-TI - this file

10) Installation example
------------------------

$ cd
$ ln -s /usr/src/yourlinux /usr/src/linuxtest   # link in testkernel
$ tar jxf ti-tests.tar.bz2                      # install package
# ln -s ~/ti-tests/ti /usr/local/bin            # or suitable directory in path

More configuration is documented in ti-tests/ti

11) Typical usage
----------------

Run the status display
$ ti stat

Run ub5
$ ti ub5

Commands can also be combined

Run the status display, ub2
$ ti stat ub2

Run combined tests
$ ti 1

12) Logging

Each pass of ub and compk is logged to the system log.

13) Bugs, caveats and limitations
---------------------------------

ti can assert extreme loads. Loadaverage of 100 was observed.

ti may fill up the disk and slow the system down to the point of unusability.

Usage with PIO hardisk mode is not recommended.

ti 0 will kill _all_ processes listed in ti function dokillall,
which is a likely nuisance should one use the system for real work
while testing it.

ti may cause instable hardware or software to crash or hang.

ti may cause overclocked or undercooled or weak hardware to burn up.

Use ti for your benefit and at your own risk. Do not run as root.

14) History
-----------

most functions and the use of unixbench functions originate from testing swsusp.

dd loops were used by the tstinter kernel interactivity test script.


