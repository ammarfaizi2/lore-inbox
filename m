Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267980AbTB1Pks>; Fri, 28 Feb 2003 10:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267988AbTB1Pks>; Fri, 28 Feb 2003 10:40:48 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:33551 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S267980AbTB1Pkq>; Fri, 28 Feb 2003 10:40:46 -0500
Date: Fri, 28 Feb 2003 10:49:48 -0500
From: Ben Collins <bcollins@debian.org>
To: Pavel Machek <pavel@suse.cz>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com, ak@suse.de, arnd@bergmann-dalldorf.de
Subject: Re: ioctl32 consolidation -- call for testing
Message-ID: <20030228154948.GY21100@phunnypharm.org>
References: <20030227203440.GP21100@phunnypharm.org> <20030227.122126.30208201.davem@redhat.com> <20030227205044.GQ21100@phunnypharm.org> <20030227.123701.16257819.davem@redhat.com> <20030227211256.GR21100@phunnypharm.org> <20030228132330.GC8498@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030228132330.GC8498@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > One thing I am just now wondering is why struct ioctl_trans defines cmd
> > as an unsigned long instead of just unsigned int. That adds an uneeded
> > bit of space to the array.
> 
> Do you think so?
> 
> cmd probably could be u32 (since it is ioctl32 after all), but I doubt
> it matters, as two following entries are pointers so it looks to me
> like it is going to be lost by alignment, anyway.

The thing is, on sparc64, these pointers were cast to u32's, so the
struct was only 12 bytes instead of the current 24. Dave's concern is
the doubling of this pretty large array.

What you could do is allow each architecture to define the ioctl_trans
struct, and also macros for acessing and setting each member. That would
probably satisfy this special cases.

> > As for your suggestion, sounds great, but I'll leave it to Pavel :)
> 
> First things first, patch probably still breaks all other
> architectures than x86-64 and sparc64....

If you make the change that Dave suggests, it will be fixed :) Even with
this patch, sparc64 is still broken for modules (like alsa and ieee1394)
that register conversions on load.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
