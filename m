Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbRGNPSU>; Sat, 14 Jul 2001 11:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264952AbRGNPSK>; Sat, 14 Jul 2001 11:18:10 -0400
Received: from mail.intrex.net ([209.42.192.246]:44044 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S264461AbRGNPR5>;
	Sat, 14 Jul 2001 11:17:57 -0400
Date: Sat, 14 Jul 2001 11:23:04 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x swap >= 2*memsize requirement status.
Message-ID: <20010714112304.B1327@bessie.localdomain>
In-Reply-To: <Pine.LNX.4.21.0107141326001.12808-100000@polypc17.chem.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0107141326001.12808-100000@polypc17.chem.rug.nl>; from jdejong@chem.rug.nl on Sat, Jul 14, 2001 at 01:42:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2001 at 01:42:46PM +0200, J.R. de Jong wrote:
> Can anyone shed some
> light on how 'required' this requirement really is and what one could
> expect to happen when this requirement is not met?

Well, I just swapoffed my swap partitions and I am still able to compose this
email, so I guess its not actually required.  I'm even building mozilla at
the same time.  Ill have to add the swap back before the mozilla build gets
to the final link stage :-)  I believe that the issue is that with 2.4 once
a process gets pages swapped out, it owns that area of swap until the process
dies.  The 2.2 kernel would free the swap space up when it swapped the
processes pages back into memory.  The 2.4 way performs much better than the
2.2 way.  The problem is that if the swap space is less than the ram size, it
is possible to fill up the swap and then strange things happen.  For example
consider a machine with 64M of ram and 64M of swap which is running 2 32M
processes.  Now lets say we start a third process that grows to a large value
and causes both of the original 32M processes to be swapped out.  Now the
third process dies a the two 32M process can run in memory again, but they
still own the swap space they were swapped into.  This means that when we
start a third process, it can not be swapped out since the swap space is
owned the the two original processes, they will get swapped out instead when
memory gets tight.

I know that people have worked on changing this behavior, but I do not know
what the current state of those changes is.

Hope this helps,

Jim
