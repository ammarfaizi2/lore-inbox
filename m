Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbUCAPRi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 10:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUCAPRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 10:17:38 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:57095 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S261312AbUCAPRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 10:17:36 -0500
Date: Mon, 1 Mar 2004 12:16:10 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: David Luyer <david@luyer.net>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>, <riel@redhat.com>, <akpm@osdl.org>
Subject: Re: Linux 2.4.25-rc1
In-Reply-To: <20040229044426.GA4381@pacific.net.au>
Message-ID: <Pine.LNX.4.44.0403011209200.4148-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi David,

On Sun, 29 Feb 2004, David Luyer wrote:

> On Thu, Feb 05, 2004 at 10:44:31AM -0200, Marcelo Tosatti wrote:
> > Here goes the first release candidate.
> > 
> > It contains mostly networking updates, XFS update, amongst others.
> > 
> > This release contains a fix for excessive inode memory pressure with
> > highmem boxes. Help is specially wanted with testing this on heavy-load
> > highmem machines.
> 
> How is this likely to manifest itself?

Basically this modification makes the inode reclaiming code rip inodes
with highmem-pagecache attached when its necessary. 

What happened before was that the low memory could get filled with
unreclaimable inodes. Which would screw up the performance badly (and
probably crash the system in extreme situations).

> We just had a box which crashed only 2 hour from deployment, and
> reading over the recent changes this seems like a potential cause
> (although being new, faulty hardware is always a possibility); the
> last items on its serial console were:
> 
> INIT: Sending processes the TERM signal
> memory.c:100: bad pmd 000001e3.
> memory.c

This looks like hardware fault to me or a (maybe, not sure) badly behaving
driver. The inode-highmem modifications can't cause such breakage, as far
as I can see.

Rik, Andrew ?

> Was still responding to ICMP after crash.
> 
> Details:
> 
>   * running 2.4.25 (release with small local patch to put MPT SCSI devices
>     before Adaptec SCSI devices, as "scsihosts" cannot do this)
> 
>   * IBM x335
> 
>   * dual Xeon 3.066GHz (hyperthreads in 2.4.25)
> 
>   * 2.5Gb RAM (HIGHMEM4G)
> 
>   * high CPU load (two processes around 75% of a CPU each at time of crash,
>     being bzip2 compression of gigabytes of data, and some other processes
>     using somewhat less CPU for network and disk IO)
> 
>   * moderate IO load (3Mbps on tg3 ethernet, more than double that on each
>     of MPT SCSI and AIC SCSI)
> 
>   * high inode / file descriptor load -- a single process may open hundreds
>     of thousands of file desciptors over a 5 minute period and then close
>     them all at once; file-max is set to 1024^2
> 
>   * newly deployed (ie no track record of stability to refer to)
> 
> Role of system is basically to receive a constant 3Mbps stream of UDP data
> which is then written to the internal RAID array, this data is then read
> from the internal array and written to an external RAID array (in the process
> doubling in volume; each piece of data ends up in two places; and sometimes
> being read/written a few times before ending up in the right place) and
> ultimately compressed and archived.
> 
> I've rebooted into 2.4.25 for a second chance but if it fails again,
> will reboot to 2.4.24 and then if that fails, revert to old hardware
> and kernel (which was running kernel 2.4.24 on an old Intel ISP2150).

OK, waiting for you input. 

