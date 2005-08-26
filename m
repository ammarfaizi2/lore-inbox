Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbVHZTdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbVHZTdD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbVHZTdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:33:03 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1533 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1030213AbVHZTdB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:33:01 -0400
Message-ID: <430F6E5F.9050702@mvista.com>
Date: Fri, 26 Aug 2005 12:32:47 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Wilkerson, Bryan P" <Bryan.P.Wilkerson@intel.com>
CC: Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: Re: kgdb on EM64T
References: <194B303F2F7B534594F2AB2D87269D9F06E5CE22@orsmsx408>
In-Reply-To: <194B303F2F7B534594F2AB2D87269D9F06E5CE22@orsmsx408>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wilkerson, Bryan P wrote:
> Thanks you Tom and George for the tips on using kgdb with
> 2.6.13-rc4-mm1.  
> 
> I almost have it working but kgdb seems to have a few issues.  I can get
> it running from the dev machine using the kgdb and console=kgdb boot
> options on the test kernel.  The kernel waits as it should and when I
> attach with "target remote /dev/ttyS0" and I can continue the boot but
> eventually it gets to a point in the boot where it frees unused kernel
> memory successfully and then a warning, "unable to open an initial
> console",  followed by, "Kernel panic - not syncing: Attempted to kill
> init!"
> 
> Removing the console=kgdb boot option and the machine boots all the way
> to run level 5.   I tried to break into kgdb at this point using the 
> 	$echo -e "\003" > /dev/ttyS0
> from the dev machine but the test kernel panics at gdb_interrupt+75 when
> it receives anything on the serial port.  Hmmm...
> 
> I'm wondering if I'm maybe just the first to try this on EM64T (kernel
> builds in the arch/x86_64 tree).   

Possibly:).  Since the serial port seems to work (i.e. the first test 
above), the fault seems to be in handling the int3.  Is int3 the right 
instruction for this machine?  If not you would make the change in 
kgdb.h.  I think that is the only place it is defined.
> 
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
