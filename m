Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263356AbTDCMCM>; Thu, 3 Apr 2003 07:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263358AbTDCMCM>; Thu, 3 Apr 2003 07:02:12 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:26117 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263356AbTDCMCL>; Thu, 3 Apr 2003 07:02:11 -0500
Date: Thu, 3 Apr 2003 14:13:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Badari Pulavarty <pbadari@us.ibm.com>
cc: Joel.Becker@oracle.com, <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <200304020931.38671.pbadari@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0304031256550.5042-100000@serv>
References: <200303311541.50200.pbadari@us.ibm.com>
 <Pine.LNX.4.44.0304021413210.12110-100000@serv> <200304020931.38671.pbadari@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2 Apr 2003, Badari Pulavarty wrote:

> (ii) We need to worry about backward compatibility. For example:
> 17th disk used to have <65, 0>. Now its major, minor is <8, 256>.
> So /dev/ entires need to be re-created to match these, everytime
> you reboot 2.4/2.5 etc. Greg KH udev might fix this for us. 

I expected something like this. As soon as we want to maintain 
compatibility it can get quite ugly.
I would prefer to leave the dev_t range below 0x10000 unchanged for 2.6 
(this means in the kernel the minor bits stay at 8) and new dev_t entries 
a created dynamically. Work which is currently still done in sd.c (e.g. 
numbering/naming) can be incrementally moved to the generic code and 
during 2.7 it can be dropped from sd.c. This way other drivers can 
automatically benefit from this and don't have to reproduce the hacks 
done in sd.c. Also if someone wants more partitions it would be a simple 
switch in sd.c and all dev_t numbers are allocated dynamically.

I am really interested why nobody wants to do now that small deciding step 
to use dynamic dev_t numbers. Everyone agrees that we want to use dynamic 
numbers, but almost everyone wants to hold on to static dev_t numbers. 
What will be the next step after enlarging dev_t? Playing around with the 
major/minor split will not help in the long term and only creates new 
problems. On the other hand at this point it's trivial now to maintain 
compability for old device numbers and create and use dynamic numbers.

bye, Roman

