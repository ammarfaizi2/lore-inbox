Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311884AbSCXTtC>; Sun, 24 Mar 2002 14:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSCXTsx>; Sun, 24 Mar 2002 14:48:53 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:31884 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S311884AbSCXTss>; Sun, 24 Mar 2002 14:48:48 -0500
Date: Sun, 24 Mar 2002 14:48:17 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andreas Hartmann <andihartmann@freenet.de>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
In-Reply-To: <E16pDzy-00073c-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0203241440440.30005-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Alan ,  Uh ? ,  OK .  Please show me where it is described
	the values Greater than 1 for overcommit_memory ?  Tia ,  JimL

Linux filesrv1 2.4.19-pre3 #1 SMP Mon Mar 18 11:49:42 EST 2002 i686 unknown

From: filesystems/proc.txt
overcommit_memory
-----------------

This file  contains  one  value.  The following algorithm is used to decide if
there's enough  memory:  if  the  value of overcommit_memory is positive, then
there's always  enough  memory. This is a useful feature, since programs often
malloc() huge  amounts  of  memory 'just in case', while they only use a small
part of  it.  Leaving  this value at 0 will lead to the failure of such a huge
malloc(), when in fact the system has enough memory for the program to run.

On the  other  hand,  enabling this feature can cause you to run out of memory
and thrash the system to death, so large and/or important servers will want to
set this value to 0.

From: sysctl/vm.txt
overcommit_memory:

This value contains a flag that enables memory overcommitment.
When this flag is 0, the kernel checks before each malloc()
to see if there's enough memory left. If the flag is nonzero,
the system pretends there's always enough memory.

This feature can be very useful because there are a lot of
programs that malloc() huge amounts of memory "just-in-case"
and don't use much of it.

Look at: mm/mmap.c::vm_enough_memory() for more information.

From: mm/mmap.c::vm_enough_memory()
...
int sysctl_overcommit_memory;
int max_map_count = DEFAULT_MAX_MAP_COUNT;

/* Check that a process has enough memory to allocate a
 * new virtual mapping.
 */
int vm_enough_memory(long pages)
{
        /* Stupid algorithm to decide if we have enough memory: while
         * simple, it hopefully works in most obvious cases.. Easy to
         * fool it, but this should catch most mistakes.
         */
        /* 23/11/98 NJC: Somewhat less stupid version of algorithm,
         * which tries to do "TheRightThing".  Instead of using half of
         * (buffers+cache), use the minimum values.  Allow an extra 2%
         * of num_physpages for safety margin.
         */

        unsigned long free;

        /* Sometimes we want to use more memory than we have. */
        if (sysctl_overcommit_memory)
            return 1;
...

On Sun, 24 Mar 2002, Alan Cox wrote:

> > 	Hello Alan ,  Is there any documentation for the 'new overcommit
> > 	mode 2/3' functionaltiy ?  Tia ,  JimL
>
> Yes, its in the Documentation dir of the kernel..
>

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

