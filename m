Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290868AbSBLJbD>; Tue, 12 Feb 2002 04:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290870AbSBLJax>; Tue, 12 Feb 2002 04:30:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17169 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290868AbSBLJas>;
	Tue, 12 Feb 2002 04:30:48 -0500
Message-ID: <3C68E0C3.543A1AD6@mandrakesoft.com>
Date: Tue, 12 Feb 2002 04:30:43 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: "David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com, anton@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: thread_info implementation
In-Reply-To: <Pine.LNX.4.33.0202120947270.11317-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> Hi,
> 
> On Mon, 11 Feb 2002, David S. Miller wrote:
> 
> > It keeps your platform the same, and it does help other platforms.
> > It is the nature of any abstraction change we make in the kernel
> > that platforms have to deal with.
> 
> Of what "abstraction change" are you talking about?
> Any change should usually help most architectures and so far the
> thread_info change has only be done a few.
> 
> > 2) pointer dereference causes performance problems
> >
> >    ummm no, not really, go test it for yourself if you don't
> >    believe me
> >
> > This only leaves "I don't want to do the conversion because it has
> > no benefit to ia64."  Well, it doesn't hurt your platform either,
> > so just cope :-)
> 
> That's simply not true. An extra load might be cheap, maybe on sparc it's
> even free, but on most architectures it has a cost. Additionally every
> access to current requires an extra load, so every function which uses
> current will be larger, all embedded targets will thank you for that.
> Where is the problem to allow these two implementations:
> 1.
> #define current_thread_info() asm(...)
> #define current current_thread_info()->task
> 2.
> #define current asm(...)
> #define current_thread_info() &current->thread_info

...or number 3, do a conversion to 2.5.4 thread_info then embed the task
structure inside struct thread_info, like what was just done with VFS
inodes.  (embedding the general struct in the arch-specific struct would
make sense to me, whereas I can definitely see how embedding the
arch-specific struct in the general struct would be annoying)

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
