Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269421AbRHCPvk>; Fri, 3 Aug 2001 11:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269428AbRHCPvU>; Fri, 3 Aug 2001 11:51:20 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:754 "EHLO
	dukat.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S269421AbRHCPvR>; Fri, 3 Aug 2001 11:51:17 -0400
Date: Fri, 3 Aug 2001 16:50:36 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, "Stephen C. Tweedie" <sct@redhat.com>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010803165036.C12470@redhat.com>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <01080316082001.01827@starship> <20010803111803.B25450@cs.cmu.edu> <01080317471707.01827@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01080317471707.01827@starship>; from phillips@bonn-fries.net on Fri, Aug 03, 2001 at 05:47:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 03, 2001 at 05:47:17PM +0200, Daniel Phillips wrote:

> > As far as the fsync semantics are concerned. Yeah, they would be useful,
> > but only to avoid one directory fsync call that will tell the kernel
> > _exactly_ what the process wants instead of letting it figure it out by
> > itself.
> 
> No, it's not just that.  It's not enough to fsync just the parent, the
> parent's parent may have been relinked and not comitted.  Also, the
> kernel has the advantage of the locked chain of dcache entries
> available to it.

Not necessarily.  If the file has been hard-linked and then the
original link removed, we don't have a valid dcache entry any more
(and yes, this is a common construct for some applications --- it is
often used to work around NFS atomicity problems.)

An MTA using such a construct and expecting fsync to do the right
thing will *not* work if you follow the dcache chain on fsync as you
propose here.

> We don't need all the paths, and not any specific path, just a path.

Exactly, because fsync makes absolutely no gaurantees about the
namespace.  So a lost+found path is quite sufficient.

Cheers,
 Stephen
