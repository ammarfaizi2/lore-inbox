Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbSJRLUh>; Fri, 18 Oct 2002 07:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265070AbSJRLUh>; Fri, 18 Oct 2002 07:20:37 -0400
Received: from cmailg2.svr.pol.co.uk ([195.92.195.172]:1036 "EHLO
	cmailg2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S265065AbSJRLUg>; Fri, 18 Oct 2002 07:20:36 -0400
Date: Fri, 18 Oct 2002 12:26:17 +0100
To: christophe varoqui <christophe.varoqui@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: block allocators and LVMs
Message-ID: <20021018112617.GA1942@fib011235813.fsnet.co.uk>
References: <3DA24B4A0064C333@mel-rta8.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA24B4A0064C333@mel-rta8.wanadoo.fr>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe,

On Thu, Oct 17, 2002 at 10:30:05PM +0200, christophe varoqui wrote:
> hello,
> 
> reading the recent threads about FS block allocator algorithms and about 
> possible integration of a new volume management framework, I wondered if 
> the role of intelligent block allocators and/or online FS defragmentation  
> could be replaced by a block remapper in the LVM subsystem.

Crazy idea :)

I think this is best left to the fs to handle, mainly because the
blocks that the fs deals with are so small.  You would end up with
*huge* remapping tables.  Also you would need to spend a lot of time
collecting the information neccessary calculate the remapping, to do
it properly you'd need to record an ordering of data acccesses not
just io counts (ie. so you could build a Markov chain).

> Am I completely out of my mind ?

Not completely, I think the statistics could be extremely valuable for
gauging the performance of different filesystems.  It would be very
easy to write a little dm target that just records all the information
in a spare block device, this target could then be layered over any
block device for testing.

- Joe
