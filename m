Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317261AbSHAWuc>; Thu, 1 Aug 2002 18:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317306AbSHAWu2>; Thu, 1 Aug 2002 18:50:28 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:18692 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317214AbSHAWuY>;
	Thu, 1 Aug 2002 18:50:24 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alexander Viro <viro@math.psu.edu>
Date: Fri, 2 Aug 2002 00:53:19 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: IDE from current bk tree, UDMA and two channels...
CC: Martin Dalecki <dalecki@cs.net.pl>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
X-mailer: Pegasus Mail v3.50
Message-ID: <CF125D0F09@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  1 Aug 02 at 18:45, Alexander Viro wrote:
> 
> On Thu, 1 Aug 2002, Linus Torvalds wrote:
> 
> > You probably saw this. Looks like blocksize has been buggered somehow.
> > Apparently Petr has a 1kB blocksize optical device..

Just to correct you: it is normal magnetic disk with 512 byte sectors,
from notebook. It works with 512B UDMA requests if we talk to the drive
slowly, with pauses here and there. If we talk to it back-to-back, it
dies. Apparently it forgets that it is doing UDMA transfers and tries
to do normal PIO or MDMA or what - host terminates transfer in the middle,
and disk is signaling that it has more data to go.
 
> Looks like we need
>     a) accurate hardsect_size for these beasts (which is a problem
> with current setup, since it's per-queue and not per-device; master and
> slave can have different hardsect sizes).
>     b) extra check in check_partitions() that would verify that
> partition doesn't end in the middle of a sector (and round it down
> if it does).

It will not help. Device is reporting 512B sectors, and it even supports
them in PIO.
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
