Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbSJPTXl>; Wed, 16 Oct 2002 15:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261300AbSJPTXl>; Wed, 16 Oct 2002 15:23:41 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:59861 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261294AbSJPTXk> convert rfc822-to-8bit;
	Wed, 16 Oct 2002 15:23:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: root@chaos.analogic.com, Samuel Flory <sflory@rackable.com>
Subject: Re: Kernel reports 4 CPUS instead of 2...
Date: Wed, 16 Oct 2002 12:28:58 -0700
User-Agent: KMail/1.4.1
Cc: Mark Cuss <mcuss@cdlsystems.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.3.95.1021016135105.150A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1021016135105.150A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210161228.58897.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 October 2002 10:54 am, Richard B. Johnson wrote:
> On Wed, 16 Oct 2002, Samuel Flory wrote:
> > >On Wed, 16 Oct 2002, Mark Cuss wrote:
> > >
> > >This is the correct behavior. If you don't like this, you can
> > >swap motherboards with me ;) Otherwise, grin and bear it!
> >
> >   Wouldn't it be easier just to turn off the hypertreading or jackson
> > tech option in the bios ;-)
>
> Why would you ever want to turn it off?  You paid for a CPU with
> two execution units and you want to disable one?  This makes
> no sense unless you are using Windows/2000/Professional, which
> will trash your disks and all their files if you have two
> or more CPUs (true).

No, you're thinking of IBM's Power4 chip, which really does have two CPU cores 
on one chip, sharing only the L2 cache.

The P4 hyperthreading shares just about all CPU resources between the two 
threads of execution.  There are only separate registers, local APIC, and 
some other minor logic for each "CPU" to call its own.  All execution units 
are demand shared between them.  (The new "pause" opcode, rep nop, allows one 
half to yield resources to the other half.)

That's why typical job mixes only get around 20% improvement.  Even optimized 
benchmarks, which run only integer code on one side and floating point on the 
other only get around a 40% boost.  The P4 just doesn't have all that many 
execution units to go around.  Future chips will probably do better.

> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
> The US military has given us many words, FUBAR, SNAFU, now ENRON.
> Yes, top management were graduates of West Point and Annapolis.


-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

